import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/cell_state.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/ai_player_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_state_provider.dart';

import '../../../../mocks.dart';

void main() {
  group('[GameStateNotifier]', () {
    late ProviderContainer container;
    late MockAIPlayer mockAIPlayer;

    setUp(() {
      mockAIPlayer = MockAIPlayer();
      container = ProviderContainer(
        overrides: [aiPlayerProvider.overrideWithValue(mockAIPlayer)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    /// Helper to initialize game with a specific starting player for testing
    void initializeGameWithPlayer(
      GameStateNotifier notifier,
      GameOpponent opponent,
      CellState startingPlayer,
    ) {
      notifier.state = GameState.playing(
        board: List.filled(9, CellState.empty),
        currentPlayer: startingPlayer,
        opponent: opponent,
      );
    }

    test(
      'given player one completes a row, when checking game, should detect victory',
      () async {
        // Arrange
        final notifier = container.read(gameStateProvider.notifier);
        initializeGameWithPlayer(
          notifier,
          GameOpponent.friend,
          CellState.playerOne,
        );

        // Act - Player One wins top row
        await notifier.makeMove(0); // X
        await notifier.makeMove(3); // O
        await notifier.makeMove(1); // X
        await notifier.makeMove(4); // O
        await notifier.makeMove(2); // X wins

        // Assert
        final state = container.read(gameStateProvider);

        expect(state, isA<GameOverState>());

        final gameOver = state as GameOverState;

        expect(gameOver.result, GameResult.victory);
        expect(gameOver.winningLine, [0, 1, 2]);
      },
    );

    test(
      'given player one completes a diagonal, when checking game, should detect victory',
      () async {
        // Arrange
        final notifier = container.read(gameStateProvider.notifier);
        initializeGameWithPlayer(
          notifier,
          GameOpponent.friend,
          CellState.playerOne,
        );

        // Act - Player One wins main diagonal
        await notifier.makeMove(0); // X
        await notifier.makeMove(1); // O
        await notifier.makeMove(4); // X
        await notifier.makeMove(2); // O
        await notifier.makeMove(8); // X wins

        // Assert
        final state = container.read(gameStateProvider);

        expect(state, isA<GameOverState>());

        final gameOver = state as GameOverState;

        expect(gameOver.result, GameResult.victory);
        expect(gameOver.winningLine, [0, 4, 8]);
      },
    );

    test(
      'given player two wins, when checking game, should detect defeat',
      () async {
        // Arrange
        final notifier = container.read(gameStateProvider.notifier);
        initializeGameWithPlayer(
          notifier,
          GameOpponent.friend,
          CellState.playerOne,
        );

        // Act - Player Two wins top row
        await notifier.makeMove(3); // X
        await notifier.makeMove(0); // O
        await notifier.makeMove(4); // X
        await notifier.makeMove(1); // O
        await notifier.makeMove(6); // X
        await notifier.makeMove(2); // O wins

        // Assert
        final state = container.read(gameStateProvider);

        expect(state, isA<GameOverState>());

        final gameOver = state as GameOverState;

        expect(gameOver.result, GameResult.defeat);
        expect(gameOver.winningLine, [0, 1, 2]);
      },
    );

    test(
      'given board is full with no winner, when checking game, should detect draw',
      () async {
        // Arrange
        final notifier = container.read(gameStateProvider.notifier);
        initializeGameWithPlayer(
          notifier,
          GameOpponent.friend,
          CellState.playerOne,
        );

        // Act - Create a draw scenario
        await notifier.makeMove(0); // X
        await notifier.makeMove(1); // O
        await notifier.makeMove(2); // X
        await notifier.makeMove(3); // O
        await notifier.makeMove(4); // X
        await notifier.makeMove(6); // O
        await notifier.makeMove(5); // X
        await notifier.makeMove(8); // O
        await notifier.makeMove(7); // X - Draw

        // Assert
        final state = container.read(gameStateProvider);

        expect(state, isA<GameOverState>());

        final gameOver = state as GameOverState;

        expect(gameOver.result, GameResult.draw);
        expect(gameOver.winningLine, isNull);
      },
    );

    test(
      'given game is over, when trying to make move, should not allow move',
      () async {
        // Arrange
        final notifier = container.read(gameStateProvider.notifier);
        initializeGameWithPlayer(
          notifier,
          GameOpponent.friend,
          CellState.playerOne,
        );

        // Complete a winning game
        await notifier.makeMove(0); // X
        await notifier.makeMove(3); // O
        await notifier.makeMove(1); // X
        await notifier.makeMove(4); // O
        await notifier.makeMove(2); // X wins [0,1,2]

        final stateBeforeInvalidMove = container.read(gameStateProvider);

        // Act
        await notifier.makeMove(5);

        // Assert
        final stateAfter = container.read(gameStateProvider);

        expect(stateAfter.board, stateBeforeInvalidMove.board);
        expect(stateAfter, isA<GameOverState>());
      },
    );

    test(
      'given player two starts and completes a column, when checking game, should detect defeat',
      () async {
        // Arrange
        final notifier = container.read(gameStateProvider.notifier);
        initializeGameWithPlayer(
          notifier,
          GameOpponent.friend,
          CellState.playerTwo,
        );

        // Act - Player Two (O) starts and wins left column
        await notifier.makeMove(0); // O
        await notifier.makeMove(1); // X
        await notifier.makeMove(3); // O
        await notifier.makeMove(2); // X
        await notifier.makeMove(6); // O wins

        // Assert
        final state = container.read(gameStateProvider);

        expect(state, isA<GameOverState>());

        final gameOver = state as GameOverState;

        expect(gameOver.result, GameResult.defeat);
        expect(gameOver.winningLine, [0, 3, 6]);
      },
    );
  });
}
