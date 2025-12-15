import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/features/game/data/repositories/game_repository.dart';
import 'package:tic_tac_toe_app/features/game/domain/entities/game_entity.dart';
import 'package:tic_tac_toe_app/features/game/domain/entities/game_statistics.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';

final gameHistoryProvider = FutureProvider<List<GameEntity>>((ref) async {
  final repository = ref.watch(gameRepositoryProvider);
  final history = await repository.getGameHistory();
  return history..sort((a, b) => b.timestamp.compareTo(a.timestamp));
});

final gameStatisticsProvider = FutureProvider<GameStatistics>((ref) async {
  final repository = ref.watch(gameRepositoryProvider);
  final history = await repository.getGameHistory();
  final trophyCount = await repository.getTrophiesCount();

  int wins = 0;
  int losses = 0;
  int draws = 0;

  for (final game in history) {
    switch (game.result) {
      case GameResult.victory:
        wins++;
        break;
      case GameResult.defeat:
        losses++;
        break;
      case GameResult.draw:
        draws++;
        break;
    }
  }

  return GameStatistics(
    totalGames: history.length,
    wins: wins,
    losses: losses,
    draws: draws,
    totalTrophies: trophyCount,
  );
});
