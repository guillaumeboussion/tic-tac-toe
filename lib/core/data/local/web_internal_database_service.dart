import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:tic_tac_toe_app/core/domain/interfaces/i_internal_database_service.dart';

final webInternalDatabaseServiceProvider = Provider(
  (ref) => InternalDatabaseService(),
);

class InternalDatabaseService implements IInternalDatabaseService {
  Database? _database;
  String? _databasePath;

  @override
  Future<void> initialize() async {
    _databasePath = 'games';
    _database = await databaseFactoryWeb.openDatabase(_databasePath!);
  }

  @override
  Future<void> deleteDatabase() async {
    if (_database != null) {
      await _database!.close();
    }

    if (_databasePath != null) {
      await databaseFactoryIo.deleteDatabase(_databasePath!);
    }
  }

  @override
  Database get database {
    if (_database == null) {
      throw Exception('Database not initialized. Call initialize() first.');
    }

    return _database!;
  }
}
