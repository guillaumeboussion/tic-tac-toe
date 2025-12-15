import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe_app/constants/assets.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/data.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/design/widgets/buttons/app_button.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/core/presentation/routing/routes.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_controller_provider.dart';

@RoutePage()
class GameResultPage extends ConsumerStatefulWidget {
  const GameResultPage({
    @PathParam('result') required String resultParam,
    @QueryParam() this.trophiesWon,
    @PathParam('opponent') required String opponentParam,
    super.key,
  }) : result = resultParam == 'victory'
           ? GameResult.victory
           : resultParam == 'draw'
           ? GameResult.draw
           : GameResult.defeat,
       opponent = opponentParam == 'friend'
           ? GameOpponent.friend
           : GameOpponent.ai;

  final GameResult result;
  final int? trophiesWon;
  final GameOpponent opponent;

  @override
  ConsumerState<GameResultPage> createState() => _GameResultPageState();
}

class _GameResultPageState extends ConsumerState<GameResultPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _lottieController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _lottieController = AnimationController(vsync: this);

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _rotationAnimation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  String _getTitle(BuildContext context) {
    final l10n = ref.read(l10nProvider);

    // For friend games, show which player won instead of victory/defeat
    if (widget.opponent == GameOpponent.friend) {
      switch (widget.result) {
        case GameResult.victory:
          return l10n.player_1_wins;
        case GameResult.draw:
          return l10n.draw;
        case GameResult.defeat:
          return l10n.player_2_wins;
      }
    }

    // For AI games, show victory/defeat
    switch (widget.result) {
      case GameResult.victory:
        return l10n.victory;
      case GameResult.draw:
        return l10n.draw;
      case GameResult.defeat:
        return l10n.defeat;
    }
  }

  String _getLottie() {
    switch (widget.result) {
      case GameResult.victory:
        return Assets.lottieTrophy;
      case GameResult.draw:
        return Assets.lottieHandsShake;
      case GameResult.defeat:
        return widget.opponent == GameOpponent.friend
            ? Assets.lottieTrophy
            : Assets.lottieCross;
    }
  }

  Color _getResultColor(AppThemeData theme) {
    switch (widget.result) {
      case GameResult.victory:
        return widget.opponent == GameOpponent.friend
            ? theme.colors.playerOneColor
            : theme.colors.success;
      case GameResult.draw:
        return theme.colors.warning;
      case GameResult.defeat:
        return widget.opponent == GameOpponent.friend
            ? theme.colors.playerTwoColor
            : theme.colors.error;
    }
  }

  void _handleNewGame() {
    ref.read(gameControllerProvider).resetGame();
    context.router.back();
  }

  void _handleBackToHome() {
    context.router.popUntil((route) => route.settings.name == HomeRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final l10n = ref.watch(l10nProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _handleBackToHome();
        }
      },
      child: Scaffold(
        backgroundColor: theme.colors.primaryColor.withValues(alpha: 0.95),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.spacing.big),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(theme.spacing.big),
                  decoration: BoxDecoration(
                    color: theme.colors.secondaryColor,
                    borderRadius: theme.radius.regular.asBorderRadius,
                    border: Border.all(
                      color: _getResultColor(theme).withValues(alpha: 0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getResultColor(theme).withValues(alpha: 0.3),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        _getLottie(),
                        width: 200,
                        height: 200,
                        repeat: false,
                        controller: _lottieController,
                        onLoaded: (composition) {
                          _lottieController.duration = composition.duration;
                          if (widget.result == GameResult.draw) {
                            _lottieController.animateTo(0.5);
                          } else {
                            _lottieController.forward();
                          }
                        },
                      ),
                      SizedBox(height: theme.spacing.regular),
                      Text(
                        _getTitle(context),
                        style: theme.typography.page.xxlBoldTitle.copyWith(
                          color: _getResultColor(theme),
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            Shadow(
                              color: _getResultColor(
                                theme,
                              ).withValues(alpha: 0.5),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (widget.trophiesWon != null &&
                          widget.trophiesWon! != 0) ...[
                        SizedBox(height: theme.spacing.semiBig),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.regular,
                              vertical: theme.spacing.small,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  (widget.trophiesWon! > 0
                                          ? theme.colors.success
                                          : theme.colors.error)
                                      .withValues(alpha: 0.2),
                              borderRadius: theme.radius.small.asBorderRadius,
                              border: Border.all(
                                color:
                                    (widget.trophiesWon! > 0
                                            ? theme.colors.success
                                            : theme.colors.error)
                                        .withValues(alpha: 0.5),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.trophiesWon! > 0 ? '🏆' : '💔',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                SizedBox(width: theme.spacing.semiSmall),
                                AppText.mediumBoldBody(
                                  '${widget.trophiesWon! > 0 ? '+' : ''}${widget.trophiesWon} ${l10n.trophies}',
                                  color: widget.trophiesWon! > 0
                                      ? theme.colors.success
                                      : theme.colors.error,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: theme.spacing.big),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            AppSuccessButton(
                              text: l10n.new_game,
                              onPressed: _handleNewGame,
                              leadingIcon: Icons.replay,
                            ),
                            SizedBox(height: theme.spacing.regular),
                            AppSecondaryButton.bold(
                              text: l10n.back_to_home,
                              onPressed: _handleBackToHome,
                              leadingIcon: Icons.home,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
