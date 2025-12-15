import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/gradients.dart';

class AppColorsData {
  const AppColorsData({
    required this.primaryText,
    required this.secondaryText,
    required this.descriptionText,
    required this.primaryColor,
    required this.secondaryColor,
    required this.inputText,
    required this.inputBorder,
    required this.secondaryInputBorder,
    required this.playerOneColor,
    required this.playerOneTextColor,
    required this.playerTwoColor,
    required this.playerTwoTextColor,
    required this.borderPrimaryLight,
    required this.friendOpponentColor,
    required this.trophyColor,
    required this.error,
    required this.success,
    required this.warning,
    required this.buttons,
    required this.gradients,
  });

  factory AppColorsData.light() => AppColorsData(
    primaryColor: const Color(0xFF202B3D),
    secondaryColor: const Color(0xFF1D283A),
    inputText: const Color.fromARGB(255, 161, 175, 194),
    inputBorder: const Color(0xFF32517A),
    secondaryInputBorder: const Color(0xFF54467B),
    playerOneColor: const Color(0xFF3A82F6),
    playerOneTextColor: const Color(0xFF3A82F6),
    playerTwoColor: const Color(0xFFA855F7),
    playerTwoTextColor: const Color(0xFFD8B4FE),
    primaryText: const Color(0xFFFFFFFF),
    secondaryText: const Color(0xFF60A4FA),
    descriptionText: const Color(0xFF9CA3AF),
    borderPrimaryLight: const Color(0xFFE8E6EA),
    friendOpponentColor: const Color(0xFFFB923A),
    trophyColor: const Color(0xFFFBBF24),
    error: const Color.fromARGB(255, 209, 93, 93),
    success: const Color.fromARGB(255, 92, 209, 125),
    warning: const Color.fromARGB(255, 255, 116, 36),
    buttons: ButtonColorsData.light(),
    gradients: AppGradientsData.light(),
  );

  final Color primaryColor;
  final Color secondaryColor;
  final Color inputText;
  final Color inputBorder;
  final Color secondaryInputBorder;
  final Color playerOneColor;
  final Color playerOneTextColor;
  final Color playerTwoColor;
  final Color playerTwoTextColor;
  final Color friendOpponentColor;
  final Color secondaryText;
  final Color primaryText;
  final Color descriptionText;
  final Color borderPrimaryLight;
  final Color trophyColor;

  final Color error;
  final Color success;
  final Color warning;

  final ButtonColorsData buttons;

  final AppGradientsData gradients;
}

class ButtonColorsData {
  final Color primaryBackground;
  final Color primaryForeground;
  final Color secondaryBackground;
  final Color secondaryForeground;

  const ButtonColorsData({
    required this.primaryBackground,
    required this.primaryForeground,
    required this.secondaryBackground,
    required this.secondaryForeground,
  });

  factory ButtonColorsData.light() => const ButtonColorsData(
    primaryBackground: Color(0xFFD15D5D),
    primaryForeground: Color(0xFFFFFFFF),
    secondaryBackground: Color(0xFFFFFFFF),
    secondaryForeground: Color(0xFFD15D5D),
  );
}
