import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';

class TextBtnChild extends StatelessWidget {
  const TextBtnChild({
    required this.text,
    required this.color,
    this.leadingIcon,
    this.suffixIcon,
    this.bold = false,
    super.key,
  });

  final String text;
  final Color color;
  final IconData? leadingIcon;
  final IconData? suffixIcon;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final textPrimaryButtonStyle = AppTheme.of(
      context,
    ).typography.button.primary;
    final spacing = AppTheme.of(context).spacing;

    if (leadingIcon == null && suffixIcon == null) {
      return Text(text, style: textPrimaryButtonStyle);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: 18, color: color),
          SizedBox(width: spacing.small),
        ],
        Flexible(
          child: Text(
            text,
            style: textPrimaryButtonStyle.copyWith(color: color),
          ),
        ),
        if (suffixIcon != null) ...[
          SizedBox(width: spacing.small),
          Icon(suffixIcon, size: 18, color: color),
        ],
      ],
    );
  }
}
