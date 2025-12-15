import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/buttons/btn_child.dart';

abstract class AppBaseButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final Image? leadingImage;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final double? fontSize;
  final bool bold;
  final bool disabled;
  final Color? foreground;
  final Color? background;
  final Color? shadowColor;
  final bool busy;
  final Radius? radiusData;
  final EdgeInsets? padding;

  const AppBaseButton({
    required this.text,
    required this.onPressed,
    required this.disabled,
    this.fontSize,
    this.leadingIcon,
    this.leadingImage,
    this.suffixIcon,
    this.suffixWidget,
    this.bold = false,
    this.busy = false,
    this.foreground,
    this.background,
    this.shadowColor,
    this.radiusData,
    this.padding,
    super.key,
  }) : assert((leadingIcon == null || leadingImage == null) && (suffixIcon == null || suffixWidget == null));

  ButtonStyle getImplementationStyle(BuildContext context);

  /// Optional method to allow the implementation to add a suffix widget.
  /// This is useful for buttons that need to display a price or a badge.
  ///
  /// This needs this method because the suffix widget is not part of the button style, and
  /// needs a const value to be passed to the super constructor.
  Widget? getSuffixWidget(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    return busy
        ? Align(
            child: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(color: AppTheme.of(context).colors.primaryColor),
            ),
          )
        : ElevatedButton(
            style: getImplementationStyle(context),
            onPressed: disabled ? null : onPressed,
            child: BtnChild(
              color: getImplementationStyle(context).foregroundColor!.resolve({WidgetState.pressed})!,
              leadingIcon: leadingIcon,
              leadingImage: leadingImage,
              suffixIcon: suffixIcon,
              suffixWidget: getSuffixWidget(context),
              textStyle: getImplementationStyle(context).textStyle!.resolve({WidgetState.pressed}),
              text: text,
              bold: bold,
            ),
          );
  }
}

class AppPrimaryButton extends AppBaseButton {
  const AppPrimaryButton({
    required super.text,
    required super.onPressed,
    super.busy = false,
    super.disabled = false,
    super.bold = true,
    super.radiusData,
    super.shadowColor,
    super.leadingIcon,
    super.leadingImage,
    super.suffixIcon,
    super.padding,
    super.key,
  });

  const AppPrimaryButton.light({
    required super.text,
    required super.onPressed,
    super.disabled = false,
    super.busy = false,
    super.bold = false,
    super.radiusData,
    super.leadingIcon,
    super.leadingImage,
    super.suffixIcon,
    super.padding,
    super.shadowColor,
    super.key,
  });

  @override
  ButtonStyle getImplementationStyle(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final radius = AppTheme.of(context).radius.full;
    final theme = AppTheme.of(context);

    return ElevatedButton.styleFrom(
      foregroundColor: colors.primaryText,
      shadowColor: shadowColor,
      splashFactory: InkRipple.splashFactory,
      textStyle: bold
          ? theme.typography.page.smallBoldBody.copyWith(fontWeight: FontWeight.w700)
          : theme.typography.page.smallBody,
      backgroundColor: disabled ? null : colors.primaryColor,
      padding: padding ?? EdgeInsets.symmetric(horizontal: theme.spacing.big, vertical: theme.spacing.semiBig),
      shape: RoundedRectangleBorder(
        borderRadius: radiusData != null ? BorderRadius.all(radiusData!) : BorderRadius.all(radius),
      ),
    );
  }
}

class AppSecondaryButton extends AppBaseButton {
  const AppSecondaryButton({
    required super.text,
    required super.onPressed,
    super.busy = false,
    super.disabled = false,
    super.radiusData,
    super.leadingIcon,
    super.leadingImage,
    super.shadowColor,
    super.suffixIcon,
    super.padding,
    super.foreground,
    super.key,
  });

  const AppSecondaryButton.bold({
    required super.text,
    required super.onPressed,
    super.disabled = false,
    super.busy = false,
    super.bold = true,
    super.radiusData,
    super.shadowColor,
    super.leadingIcon,
    super.leadingImage,
    super.suffixIcon,
    super.foreground,
    super.padding,
    super.key,
  });

  @override
  ButtonStyle getImplementationStyle(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final radius = AppTheme.of(context).radius.full;
    final theme = AppTheme.of(context);

    return ElevatedButton.styleFrom(
      foregroundColor: colors.primaryColor,
      backgroundColor: colors.playerTwoColor,
      splashFactory: InkRipple.splashFactory,
      textStyle: bold
          ? theme.typography.page.smallBoldBody.copyWith(
              fontWeight: FontWeight.w700,
              color: foreground ?? colors.primaryColor,
            )
          : theme.typography.page.smallBody.copyWith(color: foreground ?? colors.primaryColor),
      shadowColor: shadowColor,
      padding: padding ?? EdgeInsets.symmetric(horizontal: theme.spacing.big, vertical: theme.spacing.semiBig),
      shape: RoundedRectangleBorder(
        borderRadius: radiusData != null ? BorderRadius.all(radiusData!) : BorderRadius.all(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final radius = AppTheme.of(context).radius.regular;
    final theme = AppTheme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: radiusData != null ? BorderRadius.all(radiusData!) : BorderRadius.all(radius),
        onTap: busy || disabled ? null : onPressed,
        child: Container(
          padding: padding ?? EdgeInsets.symmetric(horizontal: theme.spacing.big, vertical: theme.spacing.semiBig),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade700, Colors.grey.shade800],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: radiusData != null ? BorderRadius.all(radiusData!) : BorderRadius.all(radius),
          ),
          child: busy
              ? Align(
                  child: SizedBox.square(dimension: 24, child: CircularProgressIndicator(color: colors.primaryColor)),
                )
              : Center(
                  child: BtnChild(
                    color: foreground ?? colors.primaryText,
                    leadingIcon: leadingIcon,
                    leadingImage: leadingImage,
                    suffixIcon: suffixIcon,
                    suffixWidget: getSuffixWidget(context),
                    textStyle: bold
                        ? theme.typography.page.smallBoldBody.copyWith(
                            fontWeight: FontWeight.w700,
                            color: foreground ?? colors.primaryText,
                          )
                        : theme.typography.page.smallBody.copyWith(color: foreground ?? colors.primaryText),
                    text: text,
                    bold: bold,
                  ),
                ),
        ),
      ),
    );
  }
}

class AppOutlinedButton extends AppBaseButton {
  const AppOutlinedButton({
    required super.text,
    required super.onPressed,
    super.busy = false,
    super.disabled = false,
    super.background = Colors.transparent,
    super.radiusData,
    super.leadingIcon,
    super.leadingImage,
    super.shadowColor,
    super.suffixIcon,
    super.padding,
    super.key,
  });

  const AppOutlinedButton.bold({
    required super.text,
    required super.onPressed,
    super.disabled = false,
    super.background = Colors.transparent,
    super.busy = false,
    super.bold = true,
    super.radiusData,
    super.shadowColor,
    super.leadingIcon,
    super.leadingImage,
    super.suffixIcon,
    super.padding,
    super.key,
  });

  @override
  ButtonStyle getImplementationStyle(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final radius = AppTheme.of(context).radius.full;
    final theme = AppTheme.of(context);

    return OutlinedButton.styleFrom(
      foregroundColor: colors.primaryColor,
      backgroundColor: background,
      minimumSize: const Size(0, 40),
      splashFactory: InkRipple.splashFactory,
      textStyle: bold ? theme.typography.page.smallBoldBody : theme.typography.page.smallBody,
      shadowColor: shadowColor ?? Colors.transparent,
      elevation: shadowColor != null ? 2 : 0,
      padding: padding ?? EdgeInsets.symmetric(horizontal: theme.spacing.big, vertical: theme.spacing.regular),
      shape: RoundedRectangleBorder(
        borderRadius: radiusData != null ? BorderRadius.all(radiusData!) : BorderRadius.all(radius),
        side: BorderSide(color: colors.primaryColor),
      ),
    );
  }
}

class AppSuccessButton extends AppBaseButton {
  const AppSuccessButton({
    required super.text,
    required super.onPressed,
    super.busy = false,
    super.disabled = false,
    super.bold = true,
    super.radiusData,
    super.shadowColor,
    super.leadingIcon,
    super.leadingImage,
    super.suffixIcon,
    super.padding,
    super.key,
  });

  @override
  ButtonStyle getImplementationStyle(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final radius = AppTheme.of(context).radius.regular;
    final theme = AppTheme.of(context);

    return ElevatedButton.styleFrom(
      foregroundColor: colors.primaryText,
      shadowColor: shadowColor,
      splashFactory: InkRipple.splashFactory,
      textStyle: bold
          ? theme.typography.page.smallBoldBody.copyWith(fontWeight: FontWeight.w700)
          : theme.typography.page.smallBody,
      backgroundColor: Colors.transparent,
      padding: padding ?? EdgeInsets.symmetric(horizontal: theme.spacing.big, vertical: theme.spacing.semiBig),
      shape: RoundedRectangleBorder(
        borderRadius: radiusData != null ? BorderRadius.all(radiusData!) : BorderRadius.all(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final radius = AppTheme.of(context).radius.regular;
    final theme = AppTheme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: radiusData != null ? BorderRadius.all(radiusData!) : BorderRadius.all(radius),
        onTap: busy || disabled ? null : onPressed,
        child: Container(
          padding: padding ?? EdgeInsets.symmetric(horizontal: theme.spacing.big, vertical: theme.spacing.semiBig),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.success, Color.lerp(colors.success, Colors.black, 0.2)!],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: radiusData != null ? BorderRadius.all(radiusData!) : BorderRadius.all(radius),
          ),
          child: busy
              ? Align(
                  child: SizedBox.square(dimension: 24, child: CircularProgressIndicator(color: colors.primaryColor)),
                )
              : Center(
                  child: BtnChild(
                    color: colors.primaryText,
                    leadingIcon: leadingIcon,
                    leadingImage: leadingImage,
                    suffixIcon: suffixIcon,
                    suffixWidget: getSuffixWidget(context),
                    textStyle: bold
                        ? theme.typography.page.smallBoldBody.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colors.primaryText,
                          )
                        : theme.typography.page.smallBody.copyWith(color: colors.primaryText),
                    text: text,
                    bold: bold,
                  ),
                ),
        ),
      ),
    );
  }
}
