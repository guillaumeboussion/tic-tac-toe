import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';
import 'package:tic_tac_toe_app/core/data/internal_database_service.dart';
import 'package:tic_tac_toe_app/core/data/typedefs.dart';

final internalStorageServiceProvider = Provider((ref) => InternalStorageService(ref: ref));

typedef DatabaseRecord = Map<int, Map<String, Object?>>;

class InternalStorageService {
  final Ref _ref;

  InternalStorageService({required Ref ref}) : _ref = ref;

  Future<void> clearStore(String storeName) async {
    final database = _ref.read(internalDatabaseServiceProvider).database;
    await intMapStoreFactory.store(storeName).drop(database);
  }

  Future<void> replaceAll({required JsonArray value, required String storeName}) async {
    final store = intMapStoreFactory.store(storeName);
    final database = _ref.read(internalDatabaseServiceProvider).database;

    await store.drop(database);
    await store.addAll(database, value);
  }

  Future<List<DatabaseRecord>> get({required String storeName, Finder? finder}) async {
    final store = intMapStoreFactory.store(storeName);
    final result = <DatabaseRecord>[];

    final database = _ref.read(internalDatabaseServiceProvider).database;
    final find = await store.find(database, finder: finder);

    if (find.isNotEmpty) {
      for (final element in find) {
        result.add({element.key: element.value});
      }
    }

    return result;
  }

  Future<int> count({required String storeName}) async {
    final store = intMapStoreFactory.store(storeName);
    final database = _ref.read(internalDatabaseServiceProvider).database;

    return store.count(database);
  }

  Future<DatabaseRecord?> getOne({required String storeName, Finder? finder}) async {
    final store = intMapStoreFactory.store(storeName);
    final database = _ref.read(internalDatabaseServiceProvider).database;

    final result = await store.findFirst(database, finder: finder);

    if (result != null) {
      return <int, Map<String, Object?>>{result.key: result.value};
    }

    return null;
  }

  Future<void> updateOne({required Json value, required Finder finder, required String storeName}) async {
    final store = intMapStoreFactory.store(storeName);
    final database = _ref.read(internalDatabaseServiceProvider).database;

    await store.update(database, value, finder: finder);
  }

  Future<void> storeOne({required Json value, required String storeName}) async {
    final store = intMapStoreFactory.store(storeName);
    final database = _ref.read(internalDatabaseServiceProvider).database;

    await store.add(database, value);
  }

  Future<void> deleteOne({required Finder finder, required String storeName}) async {
    final store = intMapStoreFactory.store(storeName);
    final database = _ref.read(internalDatabaseServiceProvider).database;

    await store.delete(database, finder: finder);
  }
}
