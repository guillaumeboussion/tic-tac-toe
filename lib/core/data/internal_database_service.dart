import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

final internalDatabaseServiceProvider = Provider((ref) => InternalDatabaseService());

class InternalDatabaseService {
  Database? _database;
  String? _databasePath;

  Future<void> initialize() async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    await appDirectory.create(recursive: true);

    _databasePath = '${appDirectory.path}/app.db';
    _database = await databaseFactoryIo.openDatabase(_databasePath!);
  }

  Future<void> deleteDatabase() async {
    if (_database != null) {
      await _database!.close();
    }

    if (_databasePath != null) {
      await databaseFactoryIo.deleteDatabase(_databasePath!);
    }
  }

  Database get database {
    if (_database == null) {
      throw Exception('Database not initialized. Call initialize() first.');
    }

    return _database!;
  }
}
