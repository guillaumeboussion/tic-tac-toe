import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/constants/shared_prefs_keys.dart';
import 'package:tic_tac_toe_app/core/data/local/shared_prefs_data_type.dart';
import 'package:tic_tac_toe_app/core/data/local/shared_prefs_service.dart';
import 'package:tic_tac_toe_app/features/settings/domain/repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider<ISettingsRepository>((ref) {
  final sharedPrefsService = ref.watch(sharedPrefsServiceProvider);
  return SettingsRepository(sharedPrefsService);
});

class SettingsRepository implements ISettingsRepository {
  final SharedPrefsService _sharedPrefsService;

  SettingsRepository(this._sharedPrefsService);

  @override
  Future<Locale?> getLocale() async {
    final localeString =
        await _sharedPrefsService.restoreData(
              key: SharedPrefsKeys.localeKey,
              dataType: SharedPrefsDataType.string,
            )
            as String?;

    if (localeString == null) return null;
    return Locale(localeString);
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await _sharedPrefsService.saveData(
      key: SharedPrefsKeys.localeKey,
      value: locale.languageCode,
      dataType: SharedPrefsDataType.string,
    );
  }
}
