import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    return Container(
      padding: EdgeInsets.all(theme.spacing.regular),
      decoration: BoxDecoration(
        gradient: theme.colors.gradients.primary,
        borderRadius: BorderRadius.circular(theme.radius.small.x),
        boxShadow: [theme.boxShadows.small],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.xxlBoldTitle('${statistics.totalTrophies}', color: theme.colors.trophyColor),
              SizedBox(width: theme.spacing.xs),
              AppText.largeBody(l10n.trophies, color: theme.colors.primaryText, fontWeight: FontWeight.w600),
            ],
          ),
          SizedBox(height: theme.spacing.regular),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatItem(label: l10n.wins, value: statistics.wins.toString(), color: theme.colors.success),
              StatItem(label: l10n.draws, value: statistics.draws.toString(), color: theme.colors.warning),
              StatItem(label: l10n.losses, value: statistics.losses.toString(), color: theme.colors.error),
            ],
          ),
        ],
      ),
    );
  }
}
