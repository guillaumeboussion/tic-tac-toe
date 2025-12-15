import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/buttons/btn_child.dart';
import 'package:tic_tac_toe_app/core/design/widgets/buttons/indicator.dart';

abstract class _AppBaseTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final IconData? suffixIcon;
  final bool bold;
  final bool busy;
  final Radius? radiusData;
  final EdgeInsets? padding;
  final Color? textColor;

  const _AppBaseTextButton({
    required this.text,
    required this.onPressed,
    this.leadingIcon,
    this.suffixIcon,
    this.bold = false,
    this.busy = false,
    this.radiusData,
    this.padding,
    this.textColor,
    super.key,
  });

  ButtonStyle getImplementationStyle(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return busy
        ? const Align(
            child: SizedBox.square(
              dimension: 24,
              child: AppProgressIndicator(),
            ),
          )
        : TextButton(
            style: getImplementationStyle(context),
            onPressed: onPressed,
            child: BtnChild(
              color: getImplementationStyle(context).foregroundColor!.resolve({WidgetState.pressed})!,
              leadingIcon: leadingIcon,
              suffixIcon: suffixIcon,
              text: text,
              bold: bold,
            ),
          );
  }
}

class AppPrimaryTextButton extends _AppBaseTextButton {
  const AppPrimaryTextButton({
    required super.text,
    required super.onPressed,
    super.busy = false,
    super.radiusData,
    super.leadingIcon,
    super.suffixIcon,
    super.padding,
    super.textColor,
    super.key,
  });

  const AppPrimaryTextButton.bold({
    required super.text,
    required super.onPressed,
    super.busy = false,
    super.bold = false,
    super.radiusData,
    super.leadingIcon,
    super.suffixIcon,
    super.padding,
    super.textColor,
    super.key,
  });

  @override
  ButtonStyle getImplementationStyle(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final radius = AppTheme.of(context).radius.small;
    final theme = AppTheme.of(context);

    return TextButton.styleFrom(
      foregroundColor: textColor ?? colors.primaryColor,
      splashFactory: NoSplash.splashFactory,
      textStyle: bold ? theme.typography.page.smallBoldBody : theme.typography.page.smallBody,
      padding: padding ?? EdgeInsets.symmetric(horizontal: theme.spacing.big, vertical: theme.spacing.regular),
      shape: RoundedRectangleBorder(
        borderRadius: radiusData != null ? BorderRadius.all(radiusData!) : BorderRadius.all(radius),
      ),
    );
  }
}
