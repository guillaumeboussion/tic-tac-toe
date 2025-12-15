import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/data/internal_database_service.dart';
import 'package:tic_tac_toe_app/core/data/shared_prefs_service.dart';

final splashProvider = Provider<SplashService>((ref) {
  return SplashService(
    ref.read(sharedPrefsServiceProvider),
    ref.read(internalDatabaseService),
  );
});

class SplashService {
  final SharedPrefsService _sharedPrefsService;
  final InternalDatabaseService _internalDatabaseService;

  SplashService(
    this._sharedPrefsService,
    this._internalDatabaseService,
  );

  Future<void> initialize() async {
    await _sharedPrefsService.initialize();
    await _internalDatabaseService.initialize();
  }
}
