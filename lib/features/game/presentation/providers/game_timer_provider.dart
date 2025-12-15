import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameTimerProvider =
    StateNotifierProvider.autoDispose<GameTimerNotifier, Duration>((ref) {
  return GameTimerNotifier();
});

class GameTimerNotifier extends StateNotifier<Duration> {
  GameTimerNotifier() : super(Duration.zero);

  Timer? _timer;

  void start() {
    reset();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = Duration(seconds: state.inSeconds + 1);
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void reset() {
    stop();
    state = Duration.zero;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
