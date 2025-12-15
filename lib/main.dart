import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tic_tac_toe_app/app.dart';
import 'package:tic_tac_toe_app/core/data/internal_database_service.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/reporting_service_provider.dart';

void main() async {
  final reportingService = ReportingService();
  final dbService = InternalDatabaseService();

  runZonedGuarded(
    () async {
      SentryWidgetsFlutterBinding.ensureInitialized();

      await reportingService.initialize();
      await dbService.initialize();

      runApp(
        ProviderScope(
          overrides: [
            reportingServiceProvider.overrideWithValue(reportingService),
            internalDatabaseServiceProvider.overrideWithValue(dbService),
          ],
          child: const TicTacToeApp(),
        ),
      );
    },
    (exception, stackTrace) async {
      await reportingService.captureException(exception, stackTrace: stackTrace);
    },
  );
}
