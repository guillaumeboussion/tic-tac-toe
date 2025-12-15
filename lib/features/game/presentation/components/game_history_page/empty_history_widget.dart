import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';

class EmptyHistoryWidget extends ConsumerWidget {
  const EmptyHistoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final l10n = ref.watch(l10nProvider);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.big),
        child: Column(
          children: [
            const Text('🎮', style: TextStyle(fontSize: 64)),
            SizedBox(height: theme.spacing.regular),
            AppText.regularBody(
              l10n.no_games_yet,
              color: theme.colors.primaryText.withValues(alpha: 0.6),
              alignment: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
