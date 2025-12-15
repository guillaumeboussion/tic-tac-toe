import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/data.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/design/widgets/buttons/app_button.dart';
import 'package:tic_tac_toe_app/core/l10n/app_localizations.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';

class GameResultDialog extends ConsumerStatefulWidget {
  final GameResult result;
  final int? trophiesWon;
  final VoidCallback onNewGame;
  final VoidCallback onBackToHome;

  const GameResultDialog({
    required this.result,
    this.trophiesWon,
    required this.onNewGame,
    required this.onBackToHome,
    super.key,
  });

  @override
  ConsumerState<GameResultDialog> createState() => _GameResultDialogState();
}

class _GameResultDialogState extends ConsumerState<GameResultDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
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
    super.dispose();
  }

  String _getTitle(AppLocalizations l10n) {
    switch (widget.result) {
      case GameResult.victory:
        return l10n.victory;
      case GameResult.draw:
        return l10n.draw;
      case GameResult.defeat:
        return l10n.defeat;
    }
  }

  String _getEmoji() {
    switch (widget.result) {
      case GameResult.victory:
        return '🏆';
      case GameResult.draw:
        return '🤝';
      case GameResult.defeat:
        return '😢';
    }
  }

  Color _getResultColor(AppThemeData theme) {
    switch (widget.result) {
      case GameResult.victory:
        return theme.colors.success;
      case GameResult.draw:
        return theme.colors.warning;
      case GameResult.defeat:
        return theme.colors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final l10n = ref.watch(l10nProvider);

    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: theme.colors.primaryColor.withValues(alpha: 0.95),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.big),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: child,
                ),
              ),
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
                    Text(
                      _getEmoji(),
                      style: const TextStyle(fontSize: 80),
                    ),
                    SizedBox(height: theme.spacing.regular),
                    Text(
                      _getTitle(l10n),
                      style: theme.typography.page.xxlBoldTitle.copyWith(
                        color: _getResultColor(theme),
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            color: _getResultColor(theme).withValues(alpha: 0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    if (widget.trophiesWon != null && widget.trophiesWon! > 0) ...[
                      SizedBox(height: theme.spacing.semiBig),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: theme.spacing.regular,
                            vertical: theme.spacing.small,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colors.success.withValues(alpha: 0.2),
                            borderRadius: theme.radius.small.asBorderRadius,
                            border: Border.all(
                              color: theme.colors.success.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('🏆', style: TextStyle(fontSize: 24)),
                              SizedBox(width: theme.spacing.semiSmall),
                              AppText.mediumBoldBody(
                                '+${widget.trophiesWon} ${l10n.trophies}!',
                                color: theme.colors.success,
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
                          SizedBox(
                            width: double.infinity,
                            child: AppPrimaryButton(
                              text: l10n.new_game,
                              onPressed: widget.onNewGame,
                            ),
                          ),
                          SizedBox(height: theme.spacing.regular),
                          SizedBox(
                            width: double.infinity,
                            child: AppSecondaryButton(
                              text: l10n.back_to_home,
                              onPressed: widget.onBackToHome,
                            ),
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
    );
  }
}
