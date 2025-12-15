import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/cell_state.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/ai_player_provider.dart';

part 'game_state_provider.freezed.dart';

final gameStateProvider =
    StateNotifierProvider.autoDispose<GameStateNotifier, GameState>((ref) {
      return GameStateNotifier(ref);
    });

class GameStateNotifier extends StateNotifier<GameState> {
  final Ref _ref;
  final Random _random = Random();

  GameStateNotifier(this._ref)
    : super(
        GameState.playing(
          board: List.filled(9, CellState.empty),
          currentPlayer: CellState.playerOne,
          opponent: GameOpponent.ai,
        ),
      );

  void initializeGame(GameOpponent opponent) {
    // Randomly select first player when playing against AI
    final currentPlayer = _getRandomPlayer(opponent);

    state = GameState.playing(
      board: List.filled(9, CellState.empty),
      currentPlayer: currentPlayer,
      opponent: opponent,
    );
  }

  void resetGame() {
    final currentPlayer = _getRandomPlayer(state.opponent);

    state = GameState.playing(
      board: List.filled(9, CellState.empty),
      currentPlayer: currentPlayer,
      opponent: state.opponent,
    );
  }

  CellState _getRandomPlayer(GameOpponent opponent) {
    return _random.nextBool() ? CellState.playerOne : CellState.playerTwo;
  }

  Future<void> makeMove(int index, GameOpponent playerType) async {
    if (state is GameOverState ||
        (state is PlayingGameState &&
            (state as PlayingGameState).isProcessing &&
            playerType != GameOpponent.ai)) {
      return;
    }
    if (state.board[index] != CellState.empty) return;

    final newBoard = List<CellState>.from(state.board);
    newBoard[index] = state.currentPlayer;

    state = (state as PlayingGameState).copyWith(board: newBoard);

    _checkGameOver();

    if (state is! GameOverState) {
      _switchPlayer();
    }
  }

  void _switchPlayer() {
    state = (state as PlayingGameState).copyWith(
      currentPlayer: state.currentPlayer == CellState.playerOne
          ? CellState.playerTwo
          : CellState.playerOne,
    );
  }

  void _checkGameOver() {
    final winningLine = _checkWinner();

    if (winningLine != null) {
      final winner = state.board[winningLine.first];
      final result = winner == CellState.playerOne
          ? GameResult.victory
          : GameResult.defeat;
      state = GameState.gameOver(
        board: state.board,
        currentPlayer: state.currentPlayer,
        opponent: state.opponent,
        result: result,
        winningLine: winningLine,
      );
    } else if (state.isBoardFull) {
      state = GameState.gameOver(
        board: state.board,
        currentPlayer: state.currentPlayer,
        opponent: state.opponent,
        result: GameResult.draw,
        winningLine: null,
      );
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

  /// Handle cell tap from UI - validates and executes player move, then triggers AI if needed
  Future<void> handleCellTap(int index) async {
    // Early returns for invalid states
    if (state is GameOverState) return;
    if (state is PlayingGameState && (state as PlayingGameState).isProcessing) {
      return;
    }
    if (state.board[index] != CellState.empty) return;

    // Make the player's move
    await makeMove(index, GameOpponent.friend);

    // If AI opponent and it's AI's turn, trigger AI move
    if (state is! GameOverState &&
        state.opponent == GameOpponent.ai &&
        state.currentPlayer == CellState.playerTwo) {
      await triggerAIMove();
    }
  }

  /// Trigger AI move with realistic delay
  Future<void> triggerAIMove() async {
    setProcessing(true);

    // Add random delay between 1-2.5 seconds for better UX
    final delayMs = 1000 + _random.nextInt(1500);
    await Future.delayed(Duration(milliseconds: delayMs));

    // Get AI's best move
    final aiPlayer = _ref.read(aiPlayerProvider);
    final aiMove = aiPlayer.getBestMove(state.board);

    await makeMove(aiMove, GameOpponent.ai);

    setProcessing(false);
  }

  /// Mark the game as processed (end-game logic has been executed)
  void markAsProcessed() {
    if (state is GameOverState) {
      state = (state as GameOverState).copyWith(hasBeenProcessed: true);
    }
  }
}

@freezed
sealed class GameState with _$GameState {
  const GameState._();

  const factory GameState.playing({
    required List<CellState> board,
    required CellState currentPlayer,
    required GameOpponent opponent,
    @Default(false) bool isProcessing,
  }) = PlayingGameState;

  const factory GameState.gameOver({
    required List<CellState> board,
    required CellState currentPlayer,
    required GameOpponent opponent,
    required GameResult result,
    required List<int>? winningLine,
    @Default(false) bool isProcessing,
    @Default(false) bool hasBeenProcessed,
  }) = GameOverState;

  bool get isBoardFull => !board.contains(CellState.empty);
}
