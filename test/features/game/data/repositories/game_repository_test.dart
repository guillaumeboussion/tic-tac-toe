import 'package:flutter_test/flutter_test.dart' hide Finder;
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';

import 'package:tic_tac_toe_app/constants/internal_storage_store_names.dart';
import 'package:tic_tac_toe_app/core/data/local/internal_storage_service.dart';
import 'package:tic_tac_toe_app/features/game/data/repositories/game_repository.dart';
import 'package:tic_tac_toe_app/features/game/domain/entities/game_entity.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';

class MockInternalStorageService extends Mock
    implements InternalStorageService {}

void main() {
  setUpAll(() {
    registerFallbackValue(Finder());
  });

  group('[GameRepository]', () {
    late MockInternalStorageService mockInternalStorageService;
    late GameRepository repository;

    setUp(() {
      mockInternalStorageService = MockInternalStorageService();
      repository = GameRepository(mockInternalStorageService);

      reset(mockInternalStorageService);
    });

    group('[getTrophiesCount]', () {
      test(
        'given database returns trophy count record, when getting trophies count, should parse and return correct count',
        () async {
          // Arrange
          final mockRecord = {
            1: {'count': 150},
          };
          when(
            () => mockInternalStorageService.getOne(
              storeName: InternalStorageStoreNames.trophiesCountStore,
            ),
          ).thenAnswer((_) async => mockRecord);

          // Act
          final result = await repository.getTrophiesCount();

          // Assert
          expect(result, 150);
          verify(
            () => mockInternalStorageService.getOne(
              storeName: InternalStorageStoreNames.trophiesCountStore,
            ),
          ).called(1);
        },
      );

      test(
        'given database returns null, when getting trophies count, should return 0',
        () async {
          // Arrange
          when(
            () => mockInternalStorageService.getOne(
              storeName: InternalStorageStoreNames.trophiesCountStore,
            ),
          ).thenAnswer((_) async => null);

          // Act
          final result = await repository.getTrophiesCount();

          // Assert
          expect(result, 0);
        },
      );

      test(
        'given database returns record without count field, when getting trophies count, should return 0',
        () async {
          // Arrange
          final mockRecord = {
            1: {'invalid': 'data'},
          };
          when(
            () => mockInternalStorageService.getOne(
              storeName: InternalStorageStoreNames.trophiesCountStore,
            ),
          ).thenAnswer((_) async => mockRecord);

          // Act
          final result = await repository.getTrophiesCount();

          // Assert
          expect(result, 0);
        },
      );
    });

    group('[getGameHistory]', () {
      test(
        'given database returns game records, when getting game history, should parse and return list of GameEntity',
        () async {
          // Arrange
          final timestamp1 = DateTime(2024, 1, 15, 10, 30);
          final timestamp2 = DateTime(2024, 1, 14, 9, 15);

          final mockRecords = [
            {
              1: {
                'id': 'game-1',
                'timestamp': timestamp1.toIso8601String(),
                'partyTime': 45000000,
                'opponent': 'ai',
                'result': 'victory',
                'trophiesWon': 10,
              },
            },
            {
              2: {
                'id': 'game-2',
                'timestamp': timestamp2.toIso8601String(),
                'partyTime': 30000000,
                'opponent': 'friend',
                'result': 'defeat',
                'trophiesWon': null,
              },
            },
          ];

          when(
            () => mockInternalStorageService.get(
              storeName: InternalStorageStoreNames.gameStore,
              finder: any(named: 'finder'),
            ),
          ).thenAnswer((_) async => mockRecords);

          // Act
          final result = await repository.getGameHistory();

          // Assert
          expect(result, hasLength(2));

          expect(result[0].id, 'game-1');
          expect(result[0].timestamp, timestamp1);
          expect(result[0].partyTime, const Duration(microseconds: 45000000));
          expect(result[0].opponent, GameOpponent.ai);
          expect(result[0].result, GameResult.victory);
          expect(result[0].trophiesWon, 10);

          expect(result[1].id, 'game-2');
          expect(result[1].timestamp, timestamp2);
          expect(result[1].partyTime, const Duration(microseconds: 30000000));
          expect(result[1].opponent, GameOpponent.friend);
          expect(result[1].result, GameResult.defeat);
          expect(result[1].trophiesWon, isNull);

          verify(
            () => mockInternalStorageService.get(
              storeName: InternalStorageStoreNames.gameStore,
              finder: any(named: 'finder'),
            ),
          ).called(1);
        },
      );

      test(
        'given database returns empty list, when getting game history, should return empty list',
        () async {
          // Arrange
          when(
            () => mockInternalStorageService.get(
              storeName: InternalStorageStoreNames.gameStore,
              finder: any(named: 'finder'),
            ),
          ).thenAnswer((_) async => []);

          // Act
          final result = await repository.getGameHistory();

          // Assert
          expect(result, isEmpty);
        },
      );
    });

    group('[updateTrophiesCount]', () {
      test(
        'given no existing record, when updating trophies count, should create new record',
        () async {
          // Arrange
          when(
            () => mockInternalStorageService.getOne(
              storeName: InternalStorageStoreNames.trophiesCountStore,
            ),
          ).thenAnswer((_) async => null);
          when(
            () => mockInternalStorageService.storeOne(
              value: any(named: 'value'),
              storeName: InternalStorageStoreNames.trophiesCountStore,
            ),
          ).thenAnswer((_) async => {});

          // Act
          await repository.updateTrophiesCount(100);

          // Assert
          verify(
            () => mockInternalStorageService.storeOne(
              value: {'count': 100},
              storeName: InternalStorageStoreNames.trophiesCountStore,
            ),
          ).called(1);
          verifyNever(
            () => mockInternalStorageService.updateOne(
              value: any(named: 'value'),
              finder: any(named: 'finder'),
              storeName: any(named: 'storeName'),
            ),
          );
        },
      );

      test(
        'given existing record, when updating trophies count, should update existing record',
        () async {
          // Arrange
          final existingRecord = {
            5: {'count': 50},
          };
          when(
            () => mockInternalStorageService.getOne(
              storeName: InternalStorageStoreNames.trophiesCountStore,
            ),
          ).thenAnswer((_) async => existingRecord);
          when(
            () => mockInternalStorageService.updateOne(
              value: {'count': 200},
              finder: any(named: 'finder'),
              storeName: InternalStorageStoreNames.trophiesCountStore,
            ),
          ).thenAnswer((_) async => 1);

          // Act
          await repository.updateTrophiesCount(200);

          // Assert
          verify(
            () => mockInternalStorageService.updateOne(
              value: {'count': 200},
              finder: any(named: 'finder'),
              storeName: InternalStorageStoreNames.trophiesCountStore,
            ),
          ).called(1);
          verifyNever(
            () => mockInternalStorageService.storeOne(
              value: any(named: 'value'),
              storeName: any(named: 'storeName'),
            ),
          );
        },
      );
    });

    group('[addGameToHistory]', () {
      test(
        'given game entity, when adding to history, should store game data correctly',
        () async {
          // Arrange
          final timestamp = DateTime(2025, 1, 15, 14, 30);
          final game = GameEntity(
            id: 'game-123',
            timestamp: timestamp,
            partyTime: const Duration(seconds: 60),
            opponent: GameOpponent.ai,
            result: GameResult.victory,
            trophiesWon: 15,
          );

          when(
            () => mockInternalStorageService.storeOne(
              value: any(named: 'value'),
              storeName: InternalStorageStoreNames.gameStore,
            ),
          ).thenAnswer((_) async => {});

          // Act
          await repository.addGameToHistory(game);

          // Assert
          verify(
            () => mockInternalStorageService.storeOne(
              value: {
                'id': 'game-123',
                'timestamp': timestamp.toIso8601String(),
                'partyTime': 60000000,
                'opponent': 'ai',
                'result': 'victory',
                'trophiesWon': 15,
              },
              storeName: InternalStorageStoreNames.gameStore,
            ),
          ).called(1);
        },
      );
    });
  });
}
