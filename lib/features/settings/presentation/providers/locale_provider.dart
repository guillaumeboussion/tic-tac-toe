import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/features/settings/data/repositories/settings_repository.dart';
import 'package:tic_tac_toe_app/features/settings/domain/repositories/settings_repository.dart';

final localeProvider = Provider<LocaleProvider>((ref) {
  final settingsRepository = ref.watch(settingsRepositoryProvider);
  return LocaleProvider(settingsRepository, ref);
});

class LocaleProvider {
  final ISettingsRepository _settingsRepository;
  final Ref _ref;

  LocaleProvider(this._settingsRepository, this._ref);

  Future<void> initialize() async {
    await _loadLocale();
  }

  Future<void> _loadLocale() async {
    final savedLocale = await _settingsRepository.getLocale();

    _ref.read(selectedL10n.notifier).state =
        savedLocale ?? Locale(WidgetsBinding.instance.platformDispatcher.locale.languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    if (supportedLocales.contains(locale)) {
      await _settingsRepository.saveLocale(locale);
      _ref.read(selectedL10n.notifier).state = locale;
    }
  }
}
