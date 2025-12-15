import 'package:tic_tac_toe_app/core/design/theme/data/colors.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/shadows.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/spacing.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/typography.dart';

class AppThemeData {
  const AppThemeData({
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.radius,
    required this.boxShadows,
  });

  factory AppThemeData.regular() => AppThemeData(
    colors: AppColorsData.light(),
    typography: AppTypographyData.regular(),
    spacing: AppSpacingData.regular(),
    radius: const AppRadiusData.regular(),
    boxShadows: AppBoxShadowsData.regular(),
  );

  final AppColorsData colors;
  final AppTypographyData typography;
  final AppSpacingData spacing;
  final AppRadiusData radius;
  final AppBoxShadowsData boxShadows;
}
