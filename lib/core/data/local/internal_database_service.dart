import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/domain/interfaces/i_internal_database_service.dart';

/// Platform-agnostic provider for internal database service.
/// This provider must be overridden in main.dart with the appropriate
/// platform-specific implementation:
/// - For iOS/Android: use iosAndroidInternalDatabaseServiceProvider
/// - For Web: use webInternalDatabaseServiceProvider
final internalDatabaseServiceProvider = Provider<IInternalDatabaseService>(
  (ref) => throw UnimplementedError(
    'internalDatabaseServiceProvider must be overridden with a platform-specific implementation',
  ),
);
