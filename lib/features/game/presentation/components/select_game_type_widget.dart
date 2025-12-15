import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';

class SelectGameOpponentWidget extends ConsumerStatefulWidget {
  final GameOpponent gameOpponent;
  final VoidCallback? onTap;

  const SelectGameOpponentWidget({
    required this.gameOpponent,
    this.onTap,
    super.key,
  });

  @override
  ConsumerState<SelectGameOpponentWidget> createState() => _SelectGameOpponentWidgetState();
}

class _SelectGameOpponentWidgetState extends ConsumerState<SelectGameOpponentWidget> with TickerProviderStateMixin {
  late AnimationController _scaleAnimationController;
  late AnimationController _gradientAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();

    _scaleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _gradientAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _gradientAnimation = Tween<double>(begin: -0.5, end: 1.5).animate(
      CurvedAnimation(
        parent: _gradientAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    _gradientAnimationController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    _gradientAnimationController.forward(from: 0.0);
    await _scaleAnimationController.forward();
    await _scaleAnimationController.reverse();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final l10n = ref.read(l10nProvider);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedBuilder(
          animation: _gradientAnimation,
          builder: (context, child) {
            final gradientColor =
                widget.gameOpponent == GameOpponent.ai ? theme.colors.playerOneColor : theme.colors.friendOpponentColor;

            return Container(
              padding: EdgeInsets.symmetric(
                vertical: theme.spacing.semiBig,
                horizontal: theme.spacing.regular,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [
                    (_gradientAnimation.value - 0.3).clamp(0.0, 1.0),
                    _gradientAnimation.value.clamp(0.0, 1.0),
                    (_gradientAnimation.value + 0.3).clamp(0.0, 1.0),
                  ],
                  colors: [
                    theme.colors.secondaryColor,
                    _gradientAnimation.value < 0.0 || _gradientAnimation.value > 1.0
                        ? theme.colors.secondaryColor
                        : gradientColor.withValues(alpha: 0.15),
                    theme.colors.secondaryColor,
                  ],
                ),
                borderRadius: theme.radius.small.asBorderRadius,
                border: Border.all(
                  color: theme.colors.inputBorder.withValues(alpha: 0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: gradientColor.withValues(alpha: 0.4),
                    offset: const Offset(0, 0),
                    blurRadius: 16,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: child,
            );
          },
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(theme.spacing.small),
                decoration: BoxDecoration(
                  color: widget.gameOpponent == GameOpponent.ai
                      ? theme.colors.playerOneColor.withValues(alpha: 0.1)
                      : theme.colors.friendOpponentColor.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.gameOpponent == GameOpponent.ai ? Icons.computer : Icons.people,
                  color: widget.gameOpponent == GameOpponent.ai
                      ? theme.colors.playerOneColor
                      : theme.colors.friendOpponentColor,
                  size: 28,
                ),
              ),
              SizedBox(width: theme.spacing.regular),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.mediumBoldBody(
                      widget.gameOpponent == GameOpponent.ai ? l10n.play_vs_computer : l10n.play_vs_friend,
                      color: theme.colors.primaryText,
                    ),
                    SizedBox(height: theme.spacing.xs),
                    AppText.smallBody(
                      widget.gameOpponent == GameOpponent.ai ? l10n.challenge_the_ai : l10n.local_multiplayer,
                      color: theme.colors.descriptionText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
