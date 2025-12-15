import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/constants/assets.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/presentation/routing/routes.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/trophy_count_provider.dart';

class TrophyCounterWidget extends ConsumerWidget {
  const TrophyCounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final trophyCountAsync = ref.watch(trophyCountProvider);

    return GestureDetector(
      onTap: () => context.router.push(const GameHistoryRoute()),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.small,
          vertical: theme.spacing.xs,
        ),
        decoration: BoxDecoration(
          color: theme.colors.primaryColor.withValues(alpha: 0.7),
          borderRadius: theme.radius.xs.asBorderRadius,
          border: Border.all(
            color: theme.colors.trophyColor.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 12,
              height: 12,
              child: Image.asset(Assets.trophyIcon),
            ),
            SizedBox(width: theme.spacing.xs),
            trophyCountAsync.when(
              data: (count) => AppText.regularBody(
                count.toString(),
                color: theme.colors.trophyColor,
                fontWeight: FontWeight.w600,
              ),
              loading: () => SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colors.trophyColor,
                  ),
                ),
              ),
              error: (_, __) => AppText.regularBody(
                '0',
                color: theme.colors.trophyColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
