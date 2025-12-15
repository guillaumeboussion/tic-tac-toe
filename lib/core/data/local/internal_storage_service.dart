import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';
import 'package:tic_tac_toe_app/core/data/local/internal_database_service.dart';
import 'package:tic_tac_toe_app/core/data/typedefs.dart';

final internalStorageServiceProvider = Provider(
  (ref) => InternalStorageService(
    database: ref.read(internalDatabaseServiceProvider).database,
  ),
);

typedef DatabaseRecord = Map<int, Map<String, Object?>>;

class InternalStorageService {
  final Database _database;

  InternalStorageService({required Database database}) : _database = database;

  Future<void> clearStore(String storeName) async {
    await intMapStoreFactory.store(storeName).drop(_database);
  }

  Future<void> replaceAll({
    required JsonArray value,
    required String storeName,
  }) async {
    final store = intMapStoreFactory.store(storeName);

    await store.drop(_database);
    await store.addAll(_database, value);
  }

  Future<List<DatabaseRecord>> get({
    required String storeName,
    Finder? finder,
  }) async {
    final store = intMapStoreFactory.store(storeName);
    final result = <DatabaseRecord>[];

    final find = await store.find(_database, finder: finder);

    if (find.isNotEmpty) {
      for (final element in find) {
        result.add({element.key: element.value});
      }
    }

    return result;
  }

  Future<int> count({required String storeName}) async {
    final store = intMapStoreFactory.store(storeName);

    return store.count(_database);
  }

  Future<DatabaseRecord?> getOne({
    required String storeName,
    Finder? finder,
  }) async {
    final store = intMapStoreFactory.store(storeName);

    final result = await store.findFirst(_database, finder: finder);

    if (result != null) {
      return <int, Map<String, Object?>>{result.key: result.value};
    }

    return null;
  }

  Future<void> updateOne({
    required Json value,
    required Finder finder,
    required String storeName,
  }) async {
    final store = intMapStoreFactory.store(storeName);

    await store.update(_database, value, finder: finder);
  }

  Future<void> storeOne({
    required Json value,
    required String storeName,
  }) async {
    final store = intMapStoreFactory.store(storeName);

    await store.add(_database, value);
  }

  Future<void> deleteOne({
    required Finder finder,
    required String storeName,
  }) async {
    final store = intMapStoreFactory.store(storeName);

    await store.delete(_database, finder: finder);
  }
}
