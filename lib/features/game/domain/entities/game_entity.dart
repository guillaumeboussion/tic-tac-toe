import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';

part 'game_entity.freezed.dart';
part 'game_entity.g.dart';

@freezed
class GameEntity with _$GameEntity {
  const factory GameEntity({
    required String id,
    required GameResult result,
    required DateTime timestamp,
    required int? trophiesWon,
    required Duration partyTime,
    required GameOpponent opponent,
  }) = _GameEntity;

  factory GameEntity.fromJson(Map<String, dynamic> json) =>
      _$GameEntityFromJson(json);
}
