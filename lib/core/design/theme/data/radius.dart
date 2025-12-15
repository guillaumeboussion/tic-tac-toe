import 'package:flutter/rendering.dart';

class AppRadiusData {
  const AppRadiusData({
    required this.xs,
    required this.small,
    required this.regular,
    required this.big,
    required this.full,
  });

  const AppRadiusData.regular()
    : xs = const Radius.circular(4),
      small = const Radius.circular(8),
      regular = const Radius.circular(14),
      big = const Radius.circular(20),
      full = const Radius.circular(30);

  final Radius xs;
  final Radius small;
  final Radius regular;
  final Radius big;
  final Radius full;
}

extension RadiusToBorderRadius on Radius {
  BorderRadius get asBorderRadius => BorderRadius.all(this);

  BorderRadius get asTopBorderRadius =>
      BorderRadius.only(topLeft: this, topRight: this);

  BorderRadius get asBottomBorderRadius =>
      BorderRadius.only(bottomLeft: this, bottomRight: this);

  BorderRadius get asLeftBorderRadius =>
      BorderRadius.only(topLeft: this, bottomLeft: this);

  BorderRadius get asRightBorderRadius =>
      BorderRadius.only(topRight: this, bottomRight: this);
}
