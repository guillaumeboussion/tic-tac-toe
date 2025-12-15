import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/scaffold.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/l10n/app_localizations.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/features/settings/presentation/providers/locale_provider.dart';

@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final l10n = ref.read(l10nProvider);
    final currentLocale = ref.watch(selectedL10n);

    return AppScaffold(
      titleText: l10n.settings,
      body: Padding(
        padding: EdgeInsets.all(theme.spacing.big),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.mediumBoldBody(l10n.language, color: theme.colors.primaryText),
            SizedBox(height: theme.spacing.regular),
            AppText.smallBody(
              '${l10n.current_language}: ${_getLanguageName(currentLocale, l10n)}',
              color: theme.colors.secondaryText,
            ),
            SizedBox(height: theme.spacing.big),
            ...supportedLocales.map(
              (locale) => Padding(
                padding: EdgeInsets.only(bottom: theme.spacing.regular),
                child: _LocaleOptionTile(
                  locale: locale,
                  isSelected: currentLocale.languageCode == locale.languageCode,
                  onTap: () {
                    ref.read(localeProvider).setLocale(locale);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(Locale locale, AppLocalizations l10n) {
    switch (locale.languageCode) {
      case 'en':
        return l10n.english;
      case 'fr':
        return l10n.french;
      default:
        return locale.languageCode;
    }
  }
}

class _LocaleOptionTile extends ConsumerWidget {
  final Locale locale;
  final bool isSelected;
  final VoidCallback onTap;

  const _LocaleOptionTile({required this.locale, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final l10n = ref.read(l10nProvider);

    final languageName = locale.languageCode == 'en' ? l10n.english : l10n.french;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(theme.spacing.regular),
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.playerOneColor.withValues(alpha: 0.2) : theme.colors.secondaryColor,
          borderRadius: theme.radius.small.asBorderRadius,
          border: Border.all(
            color: isSelected ? theme.colors.playerOneColor : theme.colors.inputBorder.withValues(alpha: 0.5),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? theme.colors.playerOneColor : theme.colors.descriptionText,
            ),
            SizedBox(width: theme.spacing.regular),
            AppText.mediumBody(
              languageName,
              color: theme.colors.primaryText,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
