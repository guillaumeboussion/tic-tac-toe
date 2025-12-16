// Mock classes using mocktail
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tic_tac_toe_app/features/game/domain/repos/i_game_repository.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/ai_player_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_state_provider.dart';
import 'package:tic_tac_toe_app/features/game/presentation/providers/game_timer_provider.dart';

class MockGameStateNotifier extends AutoDisposeNotifier<GameState>
    with Mock
    implements GameStateNotifier {
  @override
  GameState build() {
    return super.noSuchMethod(Invocation.method(#build, [])) as GameState;
  }
}

class MockGameTimerNotifier extends AutoDisposeNotifier<Duration>
    with Mock
    implements GameTimerNotifier {
  @override
  Duration build() {
    return super.noSuchMethod(Invocation.method(#build, [])) as Duration;
  }
}

class MockIGameRepository extends Mock implements IGameRepository {}

class MockAIPlayer extends Mock implements AIPlayerProvider {}
