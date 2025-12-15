import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/features/game/domain/entities/game_statistics.dart';
import 'package:tic_tac_toe_app/features/game/presentation/components/game_history_page/stat_item.dart';

class StatisticsCard extends ConsumerWidget {
  final GameStatistics statistics;

  const StatisticsCard({super.key, required this.statistics});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final l10n = ref.watch(l10nProvider);

    return Column(
      children: [
        // Trophy Card - Elevated and prominent
        Container(
          padding: EdgeInsets.all(theme.spacing.semiBig),
          decoration: BoxDecoration(
            color: const Color(0xFF2A3649),
            borderRadius: theme.radius.regular.asBorderRadius,
            boxShadow: [
              BoxShadow(
                color: theme.colors.trophyColor.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(theme.spacing.small),
                decoration: BoxDecoration(
                  color: theme.colors.trophyColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.emoji_events_rounded,
                  color: theme.colors.trophyColor,
                  size: 32,
                ),
              ),
              SizedBox(width: theme.spacing.regular),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.trophies.toUpperCase(),
                    style: TextStyle(
                      color: theme.colors.primaryText.withValues(alpha: 0.6),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: theme.spacing.semiXs),
                  AppText.xxlBoldTitle(
                    '${statistics.totalTrophies}',
                    color: theme.colors.trophyColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: theme.spacing.regular),
        // Stats Card - Clean and organized
        Container(
          padding: EdgeInsets.all(theme.spacing.semiBig),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2836),
            borderRadius: theme.radius.regular.asBorderRadius,
            border: Border.all(
              color: theme.colors.primaryText.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.mediumBoldTitle(
                l10n.statistics,
                color: theme.colors.primaryText,
              ),
              SizedBox(height: theme.spacing.semiBig),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: StatItem(
                      label: l10n.wins,
                      value: statistics.wins.toString(),
                      color: theme.colors.success,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: theme.colors.primaryText.withValues(alpha: 0.1),
                  ),
                  Expanded(
                    child: StatItem(
                      label: l10n.draws,
                      value: statistics.draws.toString(),
                      color: theme.colors.warning,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: theme.colors.primaryText.withValues(alpha: 0.1),
                  ),
                  Expanded(
                    child: StatItem(
                      label: l10n.losses,
                      value: statistics.losses.toString(),
                      color: theme.colors.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
