import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/data.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/l10n/app_localizations.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/features/game/domain/entities/game_entity.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';

class GameHistoryCard extends ConsumerWidget {
  final GameEntity game;

  const GameHistoryCard({super.key, required this.game});

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy - HH:mm').format(date);
  }

  String _getResultEmoji(GameResult result) {
    switch (result) {
      case GameResult.victory:
        return '🏆';
      case GameResult.draw:
        return '🤝';
      case GameResult.defeat:
        return '😢';
    }
  }

  Color _getResultColor(GameResult result, AppThemeData theme) {
    switch (result) {
      case GameResult.victory:
        return theme.colors.success;
      case GameResult.draw:
        return theme.colors.warning;
      case GameResult.defeat:
        return theme.colors.error;
    }
  }

  String _getResultText(GameResult result, AppLocalizations l10n) {
    switch (result) {
      case GameResult.victory:
        return l10n.victory;
      case GameResult.draw:
        return l10n.draw;
      case GameResult.defeat:
        return l10n.defeat;
    }
  }

  String _getOpponentText(GameOpponent opponent, AppLocalizations l10n) {
    switch (opponent) {
      case GameOpponent.ai:
        return l10n.ai;
      case GameOpponent.friend:
        return l10n.friend;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final l10n = ref.watch(l10nProvider);
    final resultColor = _getResultColor(game.result, theme);

    return Container(
      padding: EdgeInsets.all(theme.spacing.small),
      decoration: BoxDecoration(
        color: theme.colors.primaryColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(theme.radius.small.x),
        border: Border.all(
          color: resultColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: resultColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(theme.radius.small.x),
            ),
            child: Center(
              child: Text(
                _getResultEmoji(game.result),
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          SizedBox(width: theme.spacing.small),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText.regularBoldBody(
                      _getResultText(game.result, l10n),
                      color: resultColor,
                    ),
                    SizedBox(width: theme.spacing.xs),
                    AppText.smallBody(
                      'vs ${_getOpponentText(game.opponent, l10n)}',
                      color: theme.colors.primaryText.withValues(alpha: 0.6),
                    ),
                  ],
                ),
                SizedBox(height: theme.spacing.semiXs),
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: theme.colors.primaryText.withValues(alpha: 0.5),
                    ),
                    SizedBox(width: theme.spacing.semiXs),
                    AppText.smallBody(
                      _formatDuration(game.partyTime),
                      color: theme.colors.primaryText.withValues(alpha: 0.7),
                    ),
                    SizedBox(width: theme.spacing.small),
                    if (game.trophiesWon != null && game.trophiesWon != 0) ...[
                      Icon(
                        Icons.emoji_events,
                        size: 14,
                        color: game.trophiesWon! > 0
                            ? theme.colors.trophyColor
                            : theme.colors.error,
                      ),
                      SizedBox(width: theme.spacing.semiXs),
                      AppText.smallBody(
                        '${game.trophiesWon! > 0 ? '+' : ''}${game.trophiesWon}',
                        color: game.trophiesWon! > 0
                            ? theme.colors.trophyColor
                            : theme.colors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: theme.spacing.semiXs),
                AppText.xsBody(
                  _formatDate(game.timestamp),
                  color: theme.colors.primaryText.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
