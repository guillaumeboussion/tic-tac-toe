import 'package:flutter/material.dart';

class AppBoxShadowsData {
  const AppBoxShadowsData({
    required this.small,
    required this.big,
    required this.card,
    required this.iconButton,
    required this.profileCard,
    required this.premiumCard,
    required this.paywallPremiumCard,
  });

  AppBoxShadowsData.regular()
      : small = BoxShadow(
          color: const Color(0xFFD1D3D4).withValues(alpha: 0.28),
          blurRadius: 25,
          offset: const Offset(0, 8),
        ),
        big = BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 9,
          offset: const Offset(0, 4),
        ),
        card = BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 4,
          offset: const Offset(0, 4),
        ),
        iconButton = BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
        profileCard = BoxShadow(
          color: const Color(0xFFD1D3D4).withValues(alpha: 0.34),
          blurRadius: 4,
          offset: const Offset(0, 0),
        ),
        premiumCard = BoxShadow(
          color: const Color(0xFFE8AA45).withValues(alpha: 0.3),
          blurRadius: 10,
          offset: const Offset(0, 0),
        ),
        paywallPremiumCard = BoxShadow(
          color: const Color(0xFFE8AA45).withValues(alpha: 0.8),
          blurRadius: 10,
          offset: const Offset(0, 0),
        );

  final BoxShadow small;
  final BoxShadow big;
  final BoxShadow card;
  final BoxShadow profileCard;
  final BoxShadow iconButton;
  final BoxShadow premiumCard;
  final BoxShadow paywallPremiumCard;
}
