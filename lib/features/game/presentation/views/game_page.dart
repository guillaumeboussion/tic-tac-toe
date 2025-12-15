import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/design/widgets/buttons/app_button.dart';
import 'package:tic_tac_toe_app/core/l10n/app_localizations.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/core/presentation/routing/routes.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/cell_state.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/presentation/components/game_page/game_cell_widget.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_controller_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_move_handler_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_state_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_timer_provider.dart';

@RoutePage()
class GamePage extends ConsumerStatefulWidget {
  const GamePage({
    @PathParam('opponent') required String opponentParam,
    super.key,
  }) : opponent = opponentParam == 'friend'
           ? GameOpponent.friend
           : GameOpponent.ai;

  final GameOpponent opponent;

  const GamePage({required this.opponent, super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)
      ..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    // Initialize game
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameControllerProvider).initializeGame(widget.opponent);
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  String _getTurnText(GameState gameState, AppLocalizations l10n) {
    if (gameState.isProcessing) {
      return l10n.ai_turn;
    }

    if (widget.opponent == GameOpponent.ai) {
      return gameState.currentPlayer == CellState.playerOne ? l10n.your_turn : l10n.ai_turn;
    } else {
      return gameState.currentPlayer == CellState.playerOne ? l10n.player_1_turn : l10n.player_2_turn;
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _handleReset() {
    ref.read(gameControllerProvider).resetGame();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final l10n = ref.watch(l10nProvider);
    final gameState = ref.watch(gameStateProvider);
    final elapsedTime = ref.watch(gameTimerProvider);

    // Listen for game state changes to trigger navigation
    ref.listen<GameState>(gameStateProvider, (previous, next) async {
      if (next is GameOverState && previous is! GameOverState) {
        final gameEndData = await ref.read(gameControllerProvider).handleGameEnd();

        // Voluntary away few milliseconds to allow UI to update before navigation
        await Future.delayed(const Duration(milliseconds: 300));

        if (gameEndData != null && context.mounted) {
          context.router.push(GameResultRoute(result: gameEndData.result, trophiesWon: gameEndData.trophiesWon));
        }
      }
    });

    return Scaffold(
      backgroundColor: theme.colors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.regular),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: theme.colors.primaryText),
                    onPressed: () => context.router.back(),
                  ),
                  Column(
                    children: [
                      AppText.smallBody(l10n.game_time, color: theme.colors.secondaryText),
                      AppText.mediumBoldBody(_formatDuration(elapsedTime), color: theme.colors.primaryText),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: theme.colors.primaryText),
                    onPressed: _handleReset,
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.regular),

              // Game Mode Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.regular, vertical: theme.spacing.semiSmall),
                decoration: BoxDecoration(
                  color: theme.colors.secondaryColor,
                  borderRadius: theme.radius.small.asBorderRadius,
                  border: Border.all(
                    color: widget.opponent == GameOpponent.ai
                        ? theme.colors.playerOneColor
                        : theme.colors.friendOpponentColor,
                  ),
                ),
                child: AppText.smallBoldBody(
                  widget.opponent == GameOpponent.ai ? l10n.vs_ai : l10n.vs_friend,
                  color: widget.opponent == GameOpponent.ai
                      ? theme.colors.playerOneColor
                      : theme.colors.friendOpponentColor,
                ),
              ),
              SizedBox(height: theme.spacing.big),

              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  final isPlayerOneTurn = gameState.currentPlayer == CellState.playerOne;
                  final indicatorColor = isPlayerOneTurn ? theme.colors.playerOneColor : theme.colors.playerTwoColor;

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: theme.spacing.regular, vertical: theme.spacing.small),
                    decoration: BoxDecoration(
                      color: indicatorColor.withValues(alpha: 0.2),
                      borderRadius: theme.radius.small.asBorderRadius,
                      border: Border.all(color: indicatorColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: indicatorColor.withValues(alpha: 0.3),
                          blurRadius: 20 * _pulseAnimation.value,
                          spreadRadius: 5 * _pulseAnimation.value,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPlayerOneTurn ? Icons.close : Icons.radio_button_unchecked,
                          color: indicatorColor,
                          size: 20,
                        ),
                        SizedBox(width: theme.spacing.semiSmall),
                        AppText.mediumBoldBody(_getTurnText(gameState, l10n), color: indicatorColor),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: theme.spacing.big),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: EdgeInsets.all(theme.spacing.regular),
                      decoration: BoxDecoration(
                        color: theme.colors.secondaryColor,
                        borderRadius: theme.radius.regular.asBorderRadius,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 5),
                        ],
                      ),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          final cellState = gameState.board[index];
                          final isWinningCell =
                              gameState is GameOverState && gameState.winningLine?.contains(index) == true;

                          return GameCellWidget(
                            cellState: cellState,
                            isWinningCell: isWinningCell,
                            onTap: () => ref.read(gameMoveHandlerProvider).handleCellTap(index),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: theme.spacing.big),

              // Bottom Actions
              SizedBox(
                width: double.infinity,
                child: AppOutlinedButton(text: l10n.back_to_home, onPressed: () => context.router.back()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
