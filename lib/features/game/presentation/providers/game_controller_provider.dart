import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/constants/game_config.dart';
import 'package:tic_tac_toe_app/features/game/data/repositories/game_repository.dart';
import 'package:tic_tac_toe_app/features/game/domain/entities/game_entity.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/cell_state.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_history_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_state_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_timer_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/trophy_count_provider.dart';

final gameControllerProvider = Provider.autoDispose<GameController>((ref) {
  return GameController(ref);
});

class GameController {
  final Ref _ref;

  GameController(this._ref);

  Future<void> initializeGame(GameOpponent opponent) async {
    _ref.read(gameStateProvider.notifier).initializeGame(opponent);
    _ref.read(gameTimerProvider.notifier).start();

    // If AI is playing and it goes first, trigger its move
    final gameState = _ref.read(gameStateProvider);
    if (gameState.opponent == GameOpponent.ai &&
        gameState.currentPlayer == CellState.playerTwo) {
      await _ref.read(gameStateProvider.notifier).triggerAIMove();
    }
  }

  Future<void> resetGame() async {
    _ref.read(gameStateProvider.notifier).resetGame();
    _ref.read(gameTimerProvider.notifier).start();

    // If AI is playing and it goes first, trigger its move
    final gameState = _ref.read(gameStateProvider);
    if (gameState.opponent == GameOpponent.ai &&
        gameState.currentPlayer == CellState.playerTwo) {
      await _ref.read(gameStateProvider.notifier).triggerAIMove();
    }
  }

  Future<GameEndData?> handleGameEnd() async {
    final gameState = _ref.read(gameStateProvider);
    final gameDuration = _ref.read(gameTimerProvider);
    final gameRepository = _ref.read(gameRepositoryProvider);

    if (gameState is! GameOverState) return null;

    // Prevent duplicate calls
    if (gameState.hasBeenProcessed) return null;

    // Stop timer
    _ref.read(gameTimerProvider.notifier).stop();

    // Calculate trophies (only for AI games)
    int? trophiesWon;

    if (gameState.opponent == GameOpponent.ai) {
      switch (gameState.result) {
        case GameResult.victory:
          trophiesWon = GameConfig.trophiesForVictory;
        case GameResult.draw:
          trophiesWon = GameConfig.trophiesForDraw;
        case GameResult.defeat:
          trophiesWon = GameConfig.trophiesForDefeat;
      }

      final currentTrophies = await gameRepository.getTrophiesCount();

      await gameRepository.updateTrophiesCount(
        max(0, currentTrophies + trophiesWon),
      );

      _ref.invalidate(trophyCountProvider);
    }

    _ref.invalidate(gameHistoryProvider);
    _ref.invalidate(gameStatisticsProvider);

    // Save game to history
    final gameEntity = GameEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      result: gameState.result,
      timestamp: DateTime.now(),
      trophiesWon: trophiesWon,
      partyTime: gameDuration,
      opponent: gameState.opponent,
    );

    await gameRepository.addGameToHistory(gameEntity);

    // Mark the game as processed to prevent duplicate handling
    _ref.read(gameStateProvider.notifier).markAsProcessed();

    return GameEndData(
      result: gameState.result,
      trophiesWon: gameState.opponent == GameOpponent.ai ? trophiesWon : null,
      opponent: gameState.opponent,
    );
  }
}

class GameEndData {
  final GameResult result;
  final int? trophiesWon;
  final GameOpponent opponent;

  const GameEndData({
    required this.result,
    required this.trophiesWon,
    required this.opponent,
  });
}
