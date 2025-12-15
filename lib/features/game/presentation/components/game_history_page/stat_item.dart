import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';

class StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const StatItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Column(
      children: [
        AppText.xlBoldTitle(value, color: color),
        SizedBox(height: theme.spacing.semiXs),
        AppText.smallBody(
          label,
          color: theme.colors.primaryText.withValues(alpha: 0.8),
        ),
      ],
    );
  }
}
