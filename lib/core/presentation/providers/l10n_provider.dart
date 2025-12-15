import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/l10n/app_localizations.dart';

/// provider used to access the AppLocalizations object for the current locale
const supportedLocales = [
  Locale('en'),
  Locale('fr'),
];

final selectedL10n = StateProvider<Locale>((ref) {
  // By default the inital locale is the locale of the phone
  //
  // If the locale of the phone isn't implemented for the application we use the french version
  final phoneLocaleLanguage = Locale(WidgetsBinding.instance.platformDispatcher.locale.languageCode);

  return supportedLocales.contains(phoneLocaleLanguage) ? phoneLocaleLanguage : supportedLocales.first;
});

final l10nProvider = Provider<AppLocalizations>((ref) {
  // Watch the locale provider if it exists (will be available after settings are initialized)
  Locale? selectedLocale;
  try {
    // Try to get the locale from settings
    // This will be available after the localeProvider is initialized
    selectedLocale = ref.watch(selectedL10n);
  } catch (e) {
    // If settings aren't initialized yet, use device locale
    selectedLocale = null;
  }

  final deviceLocale = Locale(WidgetsBinding.instance.platformDispatcher.locale.languageCode);

  // Priority: saved locale > device locale > first supported locale
  final locale = selectedLocale ?? (supportedLocales.contains(deviceLocale) ? deviceLocale : supportedLocales.first);

  ref.state = lookupAppLocalizations(locale);

  // create an observer to update the state when device locale changes
  final observer = _LocaleObserver((locales) {
    if (selectedLocale == null) {
      // Only update from device if no saved locale preference
      final newDeviceLocale = Locale(WidgetsBinding.instance.platformDispatcher.locale.languageCode);
      final newLocale = supportedLocales.contains(newDeviceLocale) ? newDeviceLocale : supportedLocales.first;
      ref.state = lookupAppLocalizations(newLocale);
    }
  });

  final binding = WidgetsBinding.instance;
  binding.addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));

  return ref.state;
});

/// observer used to notify the caller when the locale changes
class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);

  final void Function(List<Locale>? locales) _didChangeLocales;

  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
