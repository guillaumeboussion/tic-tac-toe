import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final reportingServiceProvider = Provider((ref) => ReportingService());

class ReportingService {
  ReportingService();

  static const silentExceptions = [TimeoutException, PathNotFoundException];

  Future<void> initialize() async {
    await SentryFlutter.init((options) {
      options.environment = kReleaseMode ? 'production' : 'development';
      options.dsn = const String.fromEnvironment('SENTRY_DSN');
      options.tracesSampleRate = 0.5;
    });
  }

  Future<void> captureException(
    exception, {
    required StackTrace stackTrace,
  }) async {
    if (!silentExceptions.contains(exception.runtimeType)) {
      if (!kReleaseMode) {
        debugPrintStack(stackTrace: stackTrace);
      }

      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }
}
