import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return CircularProgressIndicator(
      key: const ValueKey('CircularProgressIndicatorButton'),
      backgroundColor: theme.colors.borderPrimaryLight,
      valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primaryColor),
    );
  }
}
