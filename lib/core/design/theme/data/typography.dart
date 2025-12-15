import 'package:flutter/rendering.dart';

abstract class TypographyConstants {
  static const regular = 'Orbitron';
}

class AppTypographyData {
  const AppTypographyData({required this.page, required this.button});

  factory AppTypographyData.regular() => AppTypographyData(
    page: PageTypographyData.regular(),
    button: ButtonTypographyData.regular(),
  );

  final PageTypographyData page;
  final ButtonTypographyData button;
}

class PageTypographyData implements TypographyConstants {
  const PageTypographyData({
    required this.splashScreenDescription,
    required this.xxlBoldTitle,
    required this.xlBoldTitle,
    required this.largeBoldTitle,
    required this.largeBody,
    required this.mediumBoldTitle,
    required this.mediumBoldBody,
    required this.mediumBody,
    required this.regularBody,
    required this.regularBoldBody,
    required this.smallBody,
    required this.smallBoldBody,
    required this.xsBody,
    required this.xxsBody,
    required this.inputText,
  });

  factory PageTypographyData.regular() => const PageTypographyData(
    splashScreenDescription: TextStyle(
      fontSize: 24,
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w500,
    ),
    xxlBoldTitle: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w700,
      fontSize: 36,
      height: 1.15,
    ),
    xlBoldTitle: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 1.15,
    ),
    largeBoldTitle: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w500,
      fontSize: 24,
      height: 1.15,
    ),
    largeBody: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      height: 1.15,
    ),
    mediumBoldTitle: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      height: 1.15,
    ),
    smallBody: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.1,
    ),
    xsBody: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.1,
    ),
    xxsBody: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontSize: 10,
      height: 1.1,
    ),
    smallBoldBody: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.1,
    ),
    regularBody: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.1,
    ),
    regularBoldBody: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.1,
    ),
    mediumBody: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      height: 1.1,
    ),
    mediumBoldBody: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w700,
      fontSize: 18,
      height: 1.1,
    ),
    inputText: TextStyle(
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
  );

  final TextStyle splashScreenDescription;
  final TextStyle xxlBoldTitle;
  final TextStyle xlBoldTitle;
  final TextStyle largeBoldTitle;
  final TextStyle largeBody;
  final TextStyle mediumBoldTitle;
  final TextStyle mediumBody;
  final TextStyle mediumBoldBody;
  final TextStyle regularBody;
  final TextStyle regularBoldBody;
  final TextStyle smallBody;
  final TextStyle smallBoldBody;
  final TextStyle xsBody;
  final TextStyle xxsBody;
  final TextStyle inputText;
}

class ButtonTypographyData {
  const ButtonTypographyData({
    required this.primary,
    required this.secondary,
    required this.secondaryBold,
    required this.text,
  });

  factory ButtonTypographyData.regular() => const ButtonTypographyData(
    primary: TextStyle(
      fontSize: 16,
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w700,
      height: 1.25,
    ),
    secondary: TextStyle(
      fontSize: 16,
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w500,
      height: 1.25,
    ),
    secondaryBold: TextStyle(
      fontSize: 16,
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w700,
      height: 1.25,
    ),
    text: TextStyle(
      fontSize: 14,
      fontFamily: TypographyConstants.regular,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
  );

  final TextStyle primary;
  final TextStyle secondary;
  final TextStyle secondaryBold;
  final TextStyle text;
}
