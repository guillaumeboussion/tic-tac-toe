import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';

enum ToastType { success, error, warning }

class AppToasts extends StatelessWidget {
  const AppToasts.success({
    required this.title,
    required this.content,
    this.toastType = ToastType.success,
    this.color,
    IconData? icon,
    super.key,
  }) : _icon = icon;

  const AppToasts.warning({
    required this.title,
    required this.content,
    this.toastType = ToastType.warning,
    this.color,
    IconData? icon,
    super.key,
  }) : _icon = icon;

  const AppToasts.error({
    required this.title,
    required this.content,
    this.toastType = ToastType.error,
    this.color,
    IconData? icon,
    super.key,
  }) : _icon = icon;

  final String title;
  final String content;
  final ToastType toastType;
  final Color? color;
  final IconData? _icon;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final Color color = () {
      switch (toastType) {
        case ToastType.error:
          return theme.colors.error;
        case ToastType.success:
          return theme.colors.success;
        case ToastType.warning:
          return theme.colors.warning;
      }
    }();

    final Icon icon = () {
      switch (toastType) {
        case ToastType.error:
          return _icon != null
              ? Icon(
                  _icon,
                  color: theme.colors.primaryText,
                  size: 26,
                )
              : Icon(
                  Icons.close,
                  color: theme.colors.primaryText,
                  size: 26,
                );
        case ToastType.success:
          return _icon != null
              ? Icon(
                  _icon,
                  color: theme.colors.primaryText,
                  size: 26,
                )
              : Icon(
                  Icons.check,
                  color: theme.colors.primaryText,
                  size: 26,
                );
        case ToastType.warning:
          return _icon != null
              ? Icon(
                  _icon,
                  color: theme.colors.primaryText,
                  size: 26,
                )
              : Icon(
                  Icons.close,
                  color: theme.colors.primaryText,
                  size: 26,
                );
      }
    }();

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.regular,
          vertical: theme.spacing.small,
        ),
        decoration: BoxDecoration(
          // boxShadow: [theme.shadow.regular],
          color: color,
          borderRadius: theme.radius.regular.asBorderRadius,
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: theme.spacing.small),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.regularBoldBody(
                    title,
                    color: theme.colors.primaryText,
                  ),
                  SizedBox(height: theme.spacing.xs),
                  AppText.smallBody(
                    content,
                    color: theme.colors.primaryText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
