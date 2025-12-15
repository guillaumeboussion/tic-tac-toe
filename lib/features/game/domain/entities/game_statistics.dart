import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_statistics.freezed.dart';

@freezed
class GameStatistics with _$GameStatistics {
  const factory GameStatistics({
    required int totalGames,
    required int wins,
    required int losses,
    required int draws,
    required int totalTrophies,
  }) = _GameStatistics;

  const GameStatistics._();

  factory GameStatistics.empty() => const GameStatistics(
    totalGames: 0,
    wins: 0,
    losses: 0,
    draws: 0,
    totalTrophies: 0,
  );
}
