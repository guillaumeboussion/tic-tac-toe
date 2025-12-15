import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/cell_state.dart';

final aiPlayerProvider = Provider<AIPlayerProvider>((ref) {
  return AIPlayerProvider();
});

class AIPlayerProvider {
  final Random _random;

  AIPlayerProvider() : _random = Random();

  /// Get the best move for the AI using minimax algorithm
  int getBestMove(List<CellState> board) {
    // Try to win
    final winningMove = _findWinningMove(board, CellState.playerTwo);
    if (winningMove != null) return winningMove;

    // Block opponent from winning
    final blockingMove = _findWinningMove(board, CellState.playerOne);
    if (blockingMove != null) return blockingMove;

    // Take center if available
    if (board[4] == CellState.empty) return 4;

    // Take a corner
    final corners = [0, 2, 6, 8];
    final availableCorners = corners.where((i) => board[i] == CellState.empty).toList();
    if (availableCorners.isNotEmpty) {
      return availableCorners[_random.nextInt(availableCorners.length)];
    }

    // Take any available edge
    final edges = [1, 3, 5, 7];
    final availableEdges = edges.where((i) => board[i] == CellState.empty).toList();
    if (availableEdges.isNotEmpty) {
      return availableEdges[_random.nextInt(availableEdges.length)];
    }

    // Fallback: take any available cell
    return board.indexOf(CellState.empty);
  }

  int? _findWinningMove(List<CellState> board, CellState player) {
    const winPatterns = [
      [0, 1, 2], // Top row
      [3, 4, 5], // Middle row
      [6, 7, 8], // Bottom row
      [0, 3, 6], // Left column
      [1, 4, 7], // Middle column
      [2, 5, 8], // Right column
      [0, 4, 8], // Diagonal \
      [2, 4, 6], // Diagonal /
    ];

    for (final pattern in winPatterns) {
      final cells = pattern.map((i) => board[i]).toList();
      final playerCells = cells.where((c) => c == player).length;
      final emptyCells = cells.where((c) => c == CellState.empty).length;

      if (playerCells == 2 && emptyCells == 1) {
        // Found a winning/blocking move
        final emptyIndex = pattern[cells.indexOf(CellState.empty)];
        return emptyIndex;
      }
    }

    return null;
  }
}
