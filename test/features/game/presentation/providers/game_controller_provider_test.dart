import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tic_tac_toe_app/constants/game_config.dart';
import 'package:tic_tac_toe_app/features/game/data/repositories/game_repository.dart';
import 'package:tic_tac_toe_app/features/game/domain/entities/game_entity.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/cell_state.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_controller_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_state_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_timer_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/trophy_count_provider.dart';

import '../../../../mocks.dart';

void main() {
  setUpAll(() {
    // Register fallback values for mocktail matchers
    registerFallbackValue(
      GameState.playing(
        board: List.filled(9, CellState.empty),
        currentPlayer: CellState.playerOne,
        opponent: GameOpponent.ai,
      ),
    );
    registerFallbackValue(GameOpponent.ai);
    registerFallbackValue(
      GameEntity(
        id: '0',
        timestamp: DateTime.now(),
        partyTime: Duration.zero,
        opponent: GameOpponent.ai,
        result: GameResult.victory,
        trophiesWon: null,
      ),
    );
    registerFallbackValue(Duration.zero);
  });

  group('[GameController]', () {
    late MockGameStateNotifier mockGameStateNotifier;
    late MockGameTimerNotifier mockGameTimerNotifier;
    late MockIGameRepository mockGameRepository;

    setUp(() {
      mockGameStateNotifier = MockGameStateNotifier();
      mockGameTimerNotifier = MockGameTimerNotifier();
      mockGameRepository = MockIGameRepository();

      // Reset all mocks to ensure clean state
      reset(mockGameStateNotifier);
      reset(mockGameTimerNotifier);
      reset(mockGameRepository);
    });

    ProviderContainer setupContainer() {
      final container = ProviderContainer(
        overrides: [
          gameStateProvider.overrideWith(() => mockGameStateNotifier),
          gameTimerProvider.overrideWith(() => mockGameTimerNotifier),
          gameRepositoryProvider.overrideWithValue(mockGameRepository),
          trophyCountProvider.overrideWith((ref) => Future.value(0)),
        ],
      );

      addTearDown(container.dispose);

      return container;
    }

    group('[initializeGame]', () {
      test(
        'given player vs AI game, when AI goes first, should initialize game, start timer and trigger AI move',
        () async {
          // Arrange
          final container = setupContainer();
          final controller = container.read(gameControllerProvider);
          final playingState = GameState.playing(
            board: List.filled(9, CellState.empty),
            currentPlayer: CellState.playerTwo,
            opponent: GameOpponent.ai,
          );
          when(() => mockGameStateNotifier.build()).thenReturn(playingState);
          when(
            () => mockGameStateNotifier.initializeGame(any()),
          ).thenReturn(null);
          when(() => mockGameTimerNotifier.start()).thenReturn(null);
          when(
            () => mockGameStateNotifier.triggerAIMove(),
          ).thenAnswer((_) async => {});

          // Act
          await controller.initializeGame(GameOpponent.ai);

          // Assert
          verify(
            () => mockGameStateNotifier.initializeGame(GameOpponent.ai),
          ).called(1);
          verify(() => mockGameTimerNotifier.start()).called(1);
          verify(() => mockGameStateNotifier.triggerAIMove()).called(1);
        },
      );
    });

    group('[resetGame]', () {
      test(
        'given existing game with AI opponent and AI goes first, when reset, should reset game, start timer and trigger AI move',
        () async {
          // Arrange
          final container = setupContainer();
          final controller = container.read(gameControllerProvider);
          final playingState = GameState.playing(
            board: List.filled(9, CellState.empty),
            currentPlayer: CellState.playerTwo,
            opponent: GameOpponent.ai,
          );
          when(() => mockGameStateNotifier.build()).thenReturn(playingState);
          when(() => mockGameStateNotifier.resetGame()).thenReturn(null);
          when(() => mockGameTimerNotifier.start()).thenReturn(null);
          when(
            () => mockGameStateNotifier.triggerAIMove(),
          ).thenAnswer((_) async => {});

          // Act
          await controller.resetGame();

          // Assert
          verify(() => mockGameStateNotifier.resetGame()).called(1);
          verify(() => mockGameTimerNotifier.start()).called(1);
          verify(() => mockGameStateNotifier.triggerAIMove()).called(1);
        },
      );
    });

    group('[handleGameEnd]', () {
      test(
        'given AI game with victory result, when handling game end, should stop timer, award victory trophies, save game and return data',
        () async {
          // Arrange
          final container = setupContainer();
          final controller = container.read(gameControllerProvider);
          const gameDuration = Duration(seconds: 45);
          final gameOverState = GameState.gameOver(
            board: List.filled(9, CellState.empty),
            currentPlayer: CellState.playerOne,
            opponent: GameOpponent.ai,
            result: GameResult.victory,
            winningLine: [0, 1, 2],
            hasBeenProcessed: false,
          );
          when(() => mockGameStateNotifier.build()).thenReturn(gameOverState);
          when(() => mockGameTimerNotifier.build()).thenReturn(gameDuration);
          when(() => mockGameTimerNotifier.stop()).thenReturn(null);
          when(
            () => mockGameRepository.getTrophiesCount(),
          ).thenAnswer((_) async => 50);
          when(
            () => mockGameRepository.updateTrophiesCount(any()),
          ).thenAnswer((_) async {});
          when(
            () => mockGameRepository.addGameToHistory(any()),
          ).thenAnswer((_) async {});
          when(() => mockGameStateNotifier.markAsProcessed()).thenReturn(null);

          // Act
          final result = await controller.handleGameEnd();

          // Assert
          verify(() => mockGameTimerNotifier.stop()).called(1);
          verify(() => mockGameRepository.getTrophiesCount()).called(1);
          verify(
            () => mockGameRepository.updateTrophiesCount(
              50 + GameConfig.trophiesForVictory,
            ),
          ).called(1);
          verify(
            () => mockGameRepository.addGameToHistory(
              any(
                that: isA<GameEntity>()
                    .having((e) => e.result, 'result', GameResult.victory)
                    .having(
                      (e) => e.trophiesWon,
                      'trophiesWon',
                      GameConfig.trophiesForVictory,
                    )
                    .having((e) => e.partyTime, 'partyTime', gameDuration)
                    .having((e) => e.opponent, 'opponent', GameOpponent.ai),
              ),
            ),
          ).called(1);
          verify(() => mockGameStateNotifier.markAsProcessed()).called(1);

          expect(result, isNotNull);
          expect(result!.result, GameResult.victory);
          expect(result.trophiesWon, GameConfig.trophiesForVictory);
          expect(result.opponent, GameOpponent.ai);
        },
      );

      test(
        'given AI game with defeat result, when handling game end, should stop timer, deduct defeat trophies, save game and return data',
        () async {
          // Arrange
          final container = setupContainer();
          final controller = container.read(gameControllerProvider);
          const gameDuration = Duration(seconds: 30);
          final gameOverState = GameState.gameOver(
            board: List.filled(9, CellState.empty),
            currentPlayer: CellState.playerTwo,
            opponent: GameOpponent.ai,
            result: GameResult.defeat,
            winningLine: [0, 1, 2],
            hasBeenProcessed: false,
          );
          when(() => mockGameStateNotifier.build()).thenReturn(gameOverState);
          when(() => mockGameTimerNotifier.build()).thenReturn(gameDuration);
          when(() => mockGameTimerNotifier.stop()).thenReturn(null);
          when(
            () => mockGameRepository.getTrophiesCount(),
          ).thenAnswer((_) async => 20);
          when(
            () => mockGameRepository.updateTrophiesCount(any()),
          ).thenAnswer((_) async {});
          when(
            () => mockGameRepository.addGameToHistory(any()),
          ).thenAnswer((_) async {});
          when(() => mockGameStateNotifier.markAsProcessed()).thenReturn(null);

          // Act
          final result = await controller.handleGameEnd();

          // Assert
          verify(() => mockGameTimerNotifier.stop()).called(1);
          verify(() => mockGameRepository.getTrophiesCount()).called(1);
          verify(
            () => mockGameRepository.updateTrophiesCount(
              20 + GameConfig.trophiesForDefeat,
            ),
          ).called(1);
          verify(
            () => mockGameRepository.addGameToHistory(
              any(
                that: isA<GameEntity>()
                    .having((e) => e.result, 'result', GameResult.defeat)
                    .having(
                      (e) => e.trophiesWon,
                      'trophiesWon',
                      GameConfig.trophiesForDefeat,
                    )
                    .having((e) => e.partyTime, 'partyTime', gameDuration)
                    .having((e) => e.opponent, 'opponent', GameOpponent.ai),
              ),
            ),
          ).called(1);
          verify(() => mockGameStateNotifier.markAsProcessed()).called(1);

          expect(result, isNotNull);
          expect(result!.result, GameResult.defeat);
          expect(result.trophiesWon, GameConfig.trophiesForDefeat);
          expect(result.opponent, GameOpponent.ai);
        },
      );

      test(
        'given AI game with draw result, when handling game end, should stop timer, award no trophies, save game and return data',
        () async {
          // Arrange
          final container = setupContainer();
          final controller = container.read(gameControllerProvider);
          const gameDuration = Duration(seconds: 60);
          final gameOverState = GameState.gameOver(
            board: List.filled(9, CellState.empty),
            currentPlayer: CellState.playerOne,
            opponent: GameOpponent.ai,
            result: GameResult.draw,
            winningLine: null,
            hasBeenProcessed: false,
          );
          when(() => mockGameStateNotifier.build()).thenReturn(gameOverState);
          when(() => mockGameTimerNotifier.build()).thenReturn(gameDuration);
          when(() => mockGameTimerNotifier.stop()).thenReturn(null);
          when(
            () => mockGameRepository.getTrophiesCount(),
          ).thenAnswer((_) async => 30);
          when(
            () => mockGameRepository.updateTrophiesCount(any()),
          ).thenAnswer((_) async {});
          when(
            () => mockGameRepository.addGameToHistory(any()),
          ).thenAnswer((_) async {});
          when(() => mockGameStateNotifier.markAsProcessed()).thenReturn(null);

          // Act
          final result = await controller.handleGameEnd();

          // Assert
          verify(() => mockGameTimerNotifier.stop()).called(1);
          verify(() => mockGameRepository.getTrophiesCount()).called(1);
          verify(
            () => mockGameRepository.updateTrophiesCount(
              30 + GameConfig.trophiesForDraw,
            ),
          ).called(1);
          verify(
            () => mockGameRepository.addGameToHistory(
              any(
                that: isA<GameEntity>()
                    .having((e) => e.result, 'result', GameResult.draw)
                    .having(
                      (e) => e.trophiesWon,
                      'trophiesWon',
                      GameConfig.trophiesForDraw,
                    )
                    .having((e) => e.partyTime, 'partyTime', gameDuration)
                    .having((e) => e.opponent, 'opponent', GameOpponent.ai),
              ),
            ),
          ).called(1);
          verify(() => mockGameStateNotifier.markAsProcessed()).called(1);

          expect(result, isNotNull);
          expect(result!.result, GameResult.draw);
          expect(result.trophiesWon, GameConfig.trophiesForDraw);
          expect(result.opponent, GameOpponent.ai);
        },
      );
    });
  });
}
