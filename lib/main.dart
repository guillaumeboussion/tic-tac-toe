import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tic_tac_toe_app/app.dart';
import 'package:tic_tac_toe_app/core/data/local/internal_database_service.dart';
import 'package:tic_tac_toe_app/core/data/local/ios_android_internal_database_service.dart'
    as ios_android;
import 'package:tic_tac_toe_app/core/data/local/web_internal_database_service.dart'
    as web;
import 'package:tic_tac_toe_app/core/data/local/shared_prefs_service.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/reporting_service_provider.dart';

void main() async {
  final reportingService = ReportingService();
  final sharedPrefsService = SharedPrefsService();
  final dbService = kIsWeb
      ? web.InternalDatabaseService()
      : ios_android.InternalDatabaseService();

  runZonedGuarded(
    () async {
      SentryWidgetsFlutterBinding.ensureInitialized();

      await sharedPrefsService.initialize();
      await reportingService.initialize();
      await dbService.initialize();

      runApp(
        ProviderScope(
          overrides: [
            reportingServiceProvider.overrideWithValue(reportingService),
            internalDatabaseServiceProvider.overrideWithValue(dbService),
            sharedPrefsServiceProvider.overrideWithValue(sharedPrefsService),
          ],
          child: const TicTacToeApp(),
        ),
      );
    },
    (exception, stackTrace) async {
      await reportingService.captureException(
        exception,
        stackTrace: stackTrace,
      );
    },
  );
}
