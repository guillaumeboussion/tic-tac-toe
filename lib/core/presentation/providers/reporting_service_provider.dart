import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportingServiceProvider = Provider((ref) => ReportingService());

class ReportingService {
  ReportingService();

  static const silentExceptions = [
    TimeoutException,
    PathNotFoundException,
  ];

  Future<void> initialize() async {
    // Should initialize Sentry or any other reporting service here
  }

  Future<void> captureException(exception, {required StackTrace stackTrace}) async {
    if (kReleaseMode && !silentExceptions.contains(exception.runtimeType)) {
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}
