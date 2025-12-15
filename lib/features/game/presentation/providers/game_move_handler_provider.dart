import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/cell_state.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/ai_player_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_state_provider.dart';

final gameMoveHandlerProvider = Provider.autoDispose<GameMoveHandler>((ref) {
  return GameMoveHandler(ref);
});

class GameMoveHandler {
  final Ref _ref;
  final Random _random;

  GameMoveHandler(this._ref) : _random = Random();

  Future<bool> handleCellTap(int index) async {
    final gameState = _ref.read(gameStateProvider);

    if (gameState is GameOverState) return false;
    if (gameState is PlayingGameState && gameState.isProcessing) return false;
    if (gameState.board[index] != CellState.empty) return false;

    // Player makes a move
    await _ref.read(gameStateProvider.notifier).makeMove(index, GameOpponent.friend);

    // Check if game is over
    final updatedState = _ref.read(gameStateProvider);
    if (updatedState is GameOverState) {
      return true; // Game ended
    }

    // AI makes a move if playing against AI
    if (updatedState.opponent == GameOpponent.ai && updatedState.currentPlayer == CellState.playerTwo) {
      await triggerAIMove();

      final finalState = _ref.read(gameStateProvider);
      return finalState is GameOverState;
    }

    return false;
  }

  Future<void> triggerAIMove() async {
    final gameState = _ref.read(gameStateProvider);
    final aiPlayer = _ref.read(aiPlayerProvider);

    _ref.read(gameStateProvider.notifier).setProcessing(true);

    // Add random delay between 1-2.5 seconds for better UX
    final delayMs = 1000 + _random.nextInt(1500);
    await Future.delayed(Duration(milliseconds: delayMs));

    final aiMove = aiPlayer.getBestMove(gameState.board);
    await _ref.read(gameStateProvider.notifier).makeMove(aiMove, GameOpponent.ai);

    _ref.read(gameStateProvider.notifier).setProcessing(false);
  }
}
