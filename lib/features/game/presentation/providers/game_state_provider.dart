import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/cell_state.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';

part 'game_state_provider.freezed.dart';

final gameStateProvider = StateNotifierProvider.autoDispose<GameStateNotifier, GameState>((ref) {
  return GameStateNotifier();
});

class GameStateNotifier extends StateNotifier<GameState> {
  final Random _random = Random();

  GameStateNotifier()
      : super(GameState(
          board: List.filled(9, CellState.empty),
          currentPlayer: CellState.playerOne,
          opponent: GameOpponent.ai,
        ));

  void initializeGame(GameOpponent opponent) {
    // Randomly select first player when playing against AI
    final currentPlayer = opponent == GameOpponent.ai && _random.nextBool() ? CellState.playerTwo : CellState.playerOne;

    state = GameState(
      board: List.filled(9, CellState.empty),
      currentPlayer: currentPlayer,
      opponent: opponent,
    );
  }

  void resetGame() {
    // Randomly select first player when playing against AI
    late final CellState currentPlayer;

    if (state.opponent == GameOpponent.ai) {
      currentPlayer = _random.nextBool() ? CellState.playerTwo : CellState.playerOne;
    } else {
      currentPlayer = CellState.playerOne;
    }

    state = GameState(
      board: List.filled(9, CellState.empty),
      currentPlayer: currentPlayer,
      opponent: state.opponent,
    );
  }

  Future<void> makeMove(int index, GameOpponent playerType) async {
    if (state.isGameOver || (state.isProcessing && playerType != GameOpponent.ai)) return;
    if (state.board[index] != CellState.empty) return;

    final newBoard = List<CellState>.from(state.board);
    newBoard[index] = state.currentPlayer;

    state = state.copyWith(board: newBoard);

    _checkGameOver();

    if (!state.isGameOver) {
      _switchPlayer();
    }
  }

  void _switchPlayer() {
    state = state.copyWith(
      currentPlayer: state.currentPlayer == CellState.playerOne ? CellState.playerTwo : CellState.playerOne,
    );
  }

  void _checkGameOver() {
    final winningLine = _checkWinner();

    if (winningLine != null) {
      final winner = state.board[winningLine.first];
      final result = winner == CellState.playerOne ? GameResult.victory : GameResult.defeat;
      state = state.copyWith(result: result, winningLine: winningLine);
    } else if (state.isBoardFull) {
      state = state.copyWith(result: GameResult.draw);
    }
  }

  List<int>? _checkWinner() {
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
      final a = state.board[pattern[0]];
      final b = state.board[pattern[1]];
      final c = state.board[pattern[2]];

      if (a != CellState.empty && a == b && b == c) {
        return pattern;
      }
    }

    return null;
  }

  void setProcessing(bool processing) {
    state = state.copyWith(isProcessing: processing);
  }
}

@freezed
class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    required List<CellState> board,
    required CellState currentPlayer,
    GameResult? result,
    List<int>? winningLine,
    required GameOpponent opponent,
    @Default(false) bool isProcessing,
  }) = _GameState;

  bool get isGameOver => result != null;

  bool get isBoardFull => !board.contains(CellState.empty);
}
