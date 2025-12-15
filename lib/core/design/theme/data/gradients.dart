import 'package:flutter/rendering.dart';

class AppGradientsData {
  const AppGradientsData({
    required this.splashScreen,
    required this.primary,
    required this.premium,
  });

  factory AppGradientsData.light() => const AppGradientsData(
        splashScreen: LinearGradient(
          colors: [
            Color.fromARGB(255, 17, 17, 17),
            Color.fromARGB(255, 17, 17, 17),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.525],
        ),
        primary: LinearGradient(
          colors: [
            Color(0xFFEDA39F),
            Color(0xFFD15D5D),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.topRight,
          stops: [0, 0.625],
        ),
        premium: LinearGradient(
          colors: [
            Color(0xFFE9A53C), // 0%
            Color(0xFFF2BF62), // 30%
            Color(0xFFF1C869), // 50%
            Color(0xFFEBB651), // 73%
            Color(0xFFF1C46A), // 82%
            Color(0xFFEBA844), // 100%
          ],
          stops: [
            0.0, // 0%
            0.3, // 30%
            0.5, // 50%
            0.73, // 73%
            0.82, // 82%
            1.0, // 100%
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );

  final Gradient splashScreen;
  final Gradient primary;
  final Gradient premium;
}
