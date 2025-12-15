import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';
import 'package:tic_tac_toe_app/constants/internal_storage_store_names.dart';
import 'package:tic_tac_toe_app/core/data/internal_storage_service.dart';
import 'package:tic_tac_toe_app/features/game/domain/entities/game_entity.dart';
import 'package:tic_tac_toe_app/features/game/domain/repos/i_game_repository.dart';

final gameRepositoryProvider = Provider<IGameRepository>((ref) {
  final internalStorageService = ref.watch(internalStorageServiceProvider);
  return GameRepository(internalStorageService);
});

class GameRepository implements IGameRepository {
  final InternalStorageService _internalStorageService;

  GameRepository(this._internalStorageService);

  @override
  Future<int> getTrophiesCount() async {
    final countResult = await _internalStorageService.getOne(
      storeName: InternalStorageStoreNames.trophiesCountStore,
    );

    if (countResult == null) {
      return 0;
    }

    // Extract the count value from the database record
    final record = countResult.values.first;
    return (record['count'] as int?) ?? 0;
  }

  /// Updates the trophies count in the internal storage.
  ///
  /// This method either creates a new record with the provided [newCount] if no
  /// existing record is found, or updates the existing record with the new count value.
  @override
  Future<void> updateTrophiesCount(int newCount) async {
    final existingRecord = await _internalStorageService.getOne(
      storeName: InternalStorageStoreNames.trophiesCountStore,
    );

    if (existingRecord == null) {
      await _internalStorageService.storeOne(
        value: {'count': newCount},
        storeName: InternalStorageStoreNames.trophiesCountStore,
      );
    } else {
      final recordKey = existingRecord.keys.first;
      await _internalStorageService.updateOne(
        value: {'count': newCount},
        finder: Finder(filter: Filter.byKey(recordKey)),
        storeName: InternalStorageStoreNames.trophiesCountStore,
      );
    }
  }

  /// Retrieves the game history from internal storage.
  ///
  /// Returns a list of [GameEntity] objects sorted in descending order by their
  /// key (newest games first). The games are fetched from the internal storage
  /// game store and deserialized from JSON format.
  ///
  /// Returns an empty list if no game history is found.
  @override
  Future<List<GameEntity>> getGameHistory() async {
    final records = await _internalStorageService.get(
      storeName: InternalStorageStoreNames.gameStore,
      finder: Finder(sortOrders: [SortOrder(Field.key, false)]),
    );

    return records.map((record) {
      final data = record.values.first;
      return GameEntity.fromJson(Map<String, dynamic>.from(data));
    }).toList();
  }

  @override
  Future<void> addGameToHistory(GameEntity game) async {
    await _internalStorageService.storeOne(
      value: game.toJson(),
      storeName: InternalStorageStoreNames.gameStore,
    );
  }
}
