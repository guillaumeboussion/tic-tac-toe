import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';

class BtnChild extends ConsumerWidget {
  const BtnChild({
    required this.text,
    required this.color,
    this.leadingIcon,
    this.leadingImage,
    this.suffixIcon,
    this.suffixWidget,
    this.textStyle,
    this.bold = false,
    super.key,
  }) : assert((leadingIcon == null || leadingImage == null) && (suffixIcon == null || suffixWidget == null));

  final String text;
  final Color color;
  final IconData? leadingIcon;
  final Image? leadingImage;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final TextStyle? textStyle;
  final bool bold;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textPrimaryButtonStyle = AppTheme.of(context).typography.button.primary;
    final textPrimaryBoldButtonStyle = AppTheme.of(context).typography.button.primary;
    final spacing = AppTheme.of(context).spacing;

    if (leadingIcon == null && suffixIcon == null && leadingImage == null && suffixWidget == null) {
      return Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle ?? (!bold ? textPrimaryButtonStyle : textPrimaryBoldButtonStyle),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) ...[
          Icon(
            leadingIcon,
            size: 18,
            color: color,
          ),
          SizedBox(width: spacing.small),
        ],
        if (leadingImage != null) ...[
          SizedBox(height: 20, child: leadingImage!),
          SizedBox(width: spacing.small),
        ],
        Flexible(
          child: Text(
            text,
            style: textStyle ?? (!bold ? textPrimaryButtonStyle : textPrimaryBoldButtonStyle),
          ),
        ),
        if (suffixIcon != null) ...[
          SizedBox(width: spacing.small),
          Icon(
            suffixIcon,
            size: 18,
            color: color,
          ),
        ],
        if (suffixWidget != null) ...[
          SizedBox(width: spacing.small),
          suffixWidget!,
        ]
      ],
    );
  }
}
