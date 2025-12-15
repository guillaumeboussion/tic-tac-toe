import 'package:flutter/widgets.dart';

class AppSpacingData {
  const AppSpacingData({
    required this.semiXs,
    required this.xs,
    required this.small,
    required this.semiSmall,
    required this.regular,
    required this.semiBig,
    required this.big,
    required this.semiHuge,
    required this.huge,
  });

  factory AppSpacingData.regular() => const AppSpacingData(
        semiXs: 2,
        xs: 4,
        semiSmall: 8,
        small: 12,
        regular: 16,
        semiBig: 20,
        big: 32,
        semiHuge: 48,
        huge: 64,
      );

  final double semiXs;
  final double xs;
  final double small;
  final double semiSmall;
  final double regular;
  final double semiBig;
  final double big;
  final double semiHuge;
  final double huge;
}

extension SpacingToInsets on double {
  EdgeInsets get asInsets => EdgeInsets.all(this);

  EdgeInsets get asHorizontalInsets => EdgeInsets.symmetric(horizontal: this);

  EdgeInsets get asVerticalInsets => EdgeInsets.symmetric(vertical: this);
}
