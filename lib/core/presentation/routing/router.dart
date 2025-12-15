import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/presentation/routing/routes.dart';

final routerProvider = Provider(
  (ref) => AppRouter(),
);
