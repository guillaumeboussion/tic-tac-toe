import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';

enum AppTextLevel {
  splashScreenDescription,
  xxlBoldTitle,
  xlBoldTitle,
  largeBoldTitle,
  largeBody,
  mediumBoldTitle,
  mediumBody,
  regularBoldBody,
  regularBody,
  mediumBoldBody,
  smallBody,
  smallBoldBody,
  xsBody,
  xxsBody,
  regularError,
}

class AppText extends ConsumerWidget {
  final String data;
  final AppTextLevel level;
  final TextAlign? alignment;
  final Color? color;
  final double? fontSize;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final int? maxLines;
  final bool? softWrap;
  final double? height;

  const AppText(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.level = AppTextLevel.regularBody,
    this.fontWeight,
    this.height,
    this.softWrap,
    this.alignment,
  });

  const AppText.splashScreenDescription(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.splashScreenDescription;

  const AppText.xxlBoldTitle(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.xxlBoldTitle;

  const AppText.xlBoldTitle(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.xlBoldTitle;

  const AppText.largeBoldTitle(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.largeBoldTitle;

  const AppText.largeBody(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.largeBody;

  const AppText.mediumBoldTitle(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.largeBoldTitle;

  const AppText.smallBody(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.smallBody;

  const AppText.smallBoldBody(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.smallBoldBody;

  const AppText.regularBody(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.regularBody;

  const AppText.regularBoldBody(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.regularBoldBody;

  const AppText.mediumBody(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.mediumBody;

  const AppText.mediumBoldBody(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.mediumBoldBody;

  const AppText.regularError(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.regularError;

  const AppText.xsBody(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.xsBody;

  const AppText.xxsBody(
    this.data, {
    super.key,
    this.color,
    this.overflow,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
    this.height,
    this.alignment,
  }) : level = AppTextLevel.xxsBody;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);

    final Color defaultColor = () {
      return switch (level) {
        AppTextLevel.splashScreenDescription => theme.colors.playerTwoColor,
        AppTextLevel.xxlBoldTitle => theme.colors.primaryText,
        AppTextLevel.xlBoldTitle => theme.colors.primaryText,
        AppTextLevel.largeBoldTitle => theme.colors.primaryText,
        AppTextLevel.largeBody => theme.colors.primaryText,
        AppTextLevel.mediumBoldTitle => theme.colors.primaryText,
        AppTextLevel.mediumBody => theme.colors.primaryText,
        AppTextLevel.mediumBoldBody => theme.colors.primaryText,
        AppTextLevel.regularError => theme.colors.primaryColor,
        AppTextLevel.regularBoldBody => theme.colors.primaryText,
        AppTextLevel.regularBody => theme.colors.primaryText,
        AppTextLevel.smallBody => theme.colors.primaryText,
        AppTextLevel.smallBoldBody => theme.colors.primaryText,
        AppTextLevel.xsBody => theme.colors.primaryText,
        AppTextLevel.xxsBody => theme.colors.primaryText,
      };
    }();

    final TextStyle style = () {
      return switch (level) {
        AppTextLevel.splashScreenDescription => theme.typography.page.splashScreenDescription,
        AppTextLevel.xxlBoldTitle => theme.typography.page.xxlBoldTitle,
        AppTextLevel.xlBoldTitle => theme.typography.page.xlBoldTitle,
        AppTextLevel.largeBoldTitle => theme.typography.page.largeBoldTitle,
        AppTextLevel.largeBody => theme.typography.page.largeBody,
        AppTextLevel.mediumBoldTitle => theme.typography.page.mediumBoldTitle,
        AppTextLevel.mediumBody => theme.typography.page.mediumBody,
        AppTextLevel.mediumBoldBody => theme.typography.page.mediumBoldBody,
        AppTextLevel.regularBody => theme.typography.page.regularBody,
        AppTextLevel.regularBoldBody => theme.typography.page.regularBoldBody,
        AppTextLevel.regularError => theme.typography.page.regularBody,
        AppTextLevel.smallBody => theme.typography.page.smallBody,
        AppTextLevel.smallBoldBody => theme.typography.page.smallBoldBody,
        AppTextLevel.xsBody => theme.typography.page.xsBody,
        AppTextLevel.xxsBody => theme.typography.page.xxsBody,
      };
    }();

    return Text(
      data,
      style: style.copyWith(
        color: color ?? defaultColor,
        fontSize: fontSize,
        fontWeight: fontWeight ?? style.fontWeight,
        height: height,
      ),
      softWrap: softWrap,
      textAlign: alignment ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
