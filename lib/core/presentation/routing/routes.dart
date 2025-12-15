import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/constants/route_paths.dart';
import 'package:tic_tac_toe_app/core/presentation/views/splash_page.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_result.dart';
import 'package:tic_tac_toe_app/features/game/presentation/views/game_history_page.dart';
import 'package:tic_tac_toe_app/features/game/presentation/views/game_page.dart';
import 'package:tic_tac_toe_app/features/game/presentation/views/game_result_page.dart';
import 'package:tic_tac_toe_app/features/game/presentation/views/home_page.dart';
import 'package:tic_tac_toe_app/features/settings/presentation/views/settings_page.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter() : super();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  late final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, path: RoutePaths.splash, initial: true),
    CustomRoute(
      page: HomeRoute.page,
      path: RoutePaths.home,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    AutoRoute(page: GameRoute.page, path: RoutePaths.game),
    CustomRoute(
      page: GameResultRoute.page,
      path: RoutePaths.gameResult,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      opaque: false,
    ),
    AutoRoute(page: SettingsRoute.page, path: RoutePaths.settings),
    AutoRoute(page: GameHistoryRoute.page, path: RoutePaths.gameHistory),
  ];
}
