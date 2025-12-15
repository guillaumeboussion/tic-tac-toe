import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/scaffold.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/components/game_history_page/empty_history_widget.dart';
import 'package:tic_tac_toe_app/features/game/presentation/components/game_history_page/game_history_card.dart';
import 'package:tic_tac_toe_app/features/game/presentation/components/game_history_page/statistics_card.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_history_provider.dart';

@RoutePage()
class GameHistoryPage extends ConsumerWidget {
  const GameHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final l10n = ref.watch(l10nProvider);
    final statisticsAsync = ref.watch(gameStatisticsProvider);
    final historyAsync = ref.watch(gameHistoryProvider);

    return AppScaffold(
      titleText: l10n.game_history,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(gameStatisticsProvider);
          ref.invalidate(gameHistoryProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(theme.spacing.regular),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                statisticsAsync.when(
                  data: (stats) => StatisticsCard(statistics: stats),
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                SizedBox(height: theme.spacing.regular),
                historyAsync.when(
                  data: (games) => games.isEmpty
                      ? const EmptyHistoryWidget()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.mediumBoldTitle(
                              l10n.previous_games,
                            ),
                            SizedBox(height: theme.spacing.small),
                            ...games.map((game) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: theme.spacing.small,
                                  ),
                                  child: GameHistoryCard(game: game),
                                )),
                          ],
                        ),
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (_, __) => Center(
                    child: AppText.regularBody(l10n.error_loading_history),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
