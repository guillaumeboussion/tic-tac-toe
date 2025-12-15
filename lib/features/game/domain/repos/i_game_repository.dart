import 'package:tic_tac_toe_app/features/game/domain/entities/game_entity.dart';

abstract class IGameRepository {
  Future<int> getTrophiesCount();
  Future<void> updateTrophiesCount(int newCount);
  Future<List<GameEntity>> getGameHistory();
  Future<void> addGameToHistory(GameEntity game);
}
