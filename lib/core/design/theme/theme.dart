import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/data.dart';

class AppTheme extends InheritedWidget {
  const AppTheme({required this.data, required super.child, super.key});

  final AppThemeData data;

  static AppThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    return widget!.data;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return data != oldWidget.data;
  }
}
