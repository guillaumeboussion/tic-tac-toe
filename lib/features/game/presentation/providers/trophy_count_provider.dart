import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/features/game/data/repositories/game_repository.dart';

final trophyCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(gameRepositoryProvider);
  return repository.getTrophiesCount();
});
