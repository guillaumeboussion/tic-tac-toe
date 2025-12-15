import 'package:sembast/sembast.dart';

abstract class IInternalDatabaseService {
  Future<void> initialize();
  Future<void> deleteDatabase();
  Database get database;
}
