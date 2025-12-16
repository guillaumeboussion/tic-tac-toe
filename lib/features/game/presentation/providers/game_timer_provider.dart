import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameTimerProvider =
    NotifierProvider.autoDispose<GameTimerNotifier, Duration>(() {
      return GameTimerNotifier();
    });

class GameTimerNotifier extends AutoDisposeNotifier<Duration> {
  Timer? _timer;

  @override
  Duration build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return Duration.zero;
  }

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
}
