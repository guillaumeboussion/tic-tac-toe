import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe_app/constants/assets.dart';
import 'package:tic_tac_toe_app/constants/route_paths.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/core/presentation/routing/routes.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/game_opponent.dart';
import 'package:tic_tac_toe_app/features/game/presentation/components/select_game_type_widget.dart';
import 'package:tic_tac_toe_app/features/game/presentation/components/trophy_counter_widget.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final _player1Controller = TextEditingController();
  final _player2Controller = TextEditingController();
  late AnimationController _shadowController;
  late AnimationController _buttonController;
  late AnimationController _sparkleController;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();

    _shadowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _shadowAnimation = Tween<double>(begin: 4.0, end: 8.0).animate(
      CurvedAnimation(parent: _shadowController, curve: Curves.easeInOut),
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _sparkleController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _shadowController.dispose();
    _buttonController.dispose();
    _sparkleController.dispose();
    _player1Controller.dispose();
    _player2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final spacing = AppTheme.of(context).spacing;
    final typography = AppTheme.of(context).typography;
    final l10n = ref.watch(l10nProvider);

    return Scaffold(
      backgroundColor: colors.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            top: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.3,
              child: Lottie.asset(Assets.lottieSparkles),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.big,
                    vertical: spacing.regular,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TrophyCounterWidget(),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: colors.primaryText.withValues(alpha: 0.6),
                        ),
                        onPressed: () =>
                            context.router.pushNamed(RoutePaths.settings),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: spacing.big),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.page_title_tic_tac_toe,
                            style: typography.page.xxlBoldTitle.copyWith(
                              fontWeight: FontWeight.w900,
                              color: colors.primaryText,
                              shadows: [
                                Shadow(
                                  color: Colors.blue.withValues(alpha: 0.6),
                                  blurRadius: _shadowAnimation.value * 5,
                                ),
                                Shadow(
                                  color: Colors.blue.withValues(alpha: 0.6),
                                  blurRadius: _shadowAnimation.value * 5,
                                ),
                                Shadow(
                                  color: Colors.blue.withValues(alpha: 0.6),
                                  blurRadius: _shadowAnimation.value * 5,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spacing.xs),
                          AppText.smallBody(
                            l10n.ultimate_edition,
                            color: colors.secondaryText,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: spacing.semiHuge),
                          AppText.mediumBoldBody(
                            l10n.select_game_mode,
                            color: colors.primaryText,
                          ),
                          SizedBox(height: spacing.big),
                          SelectGameOpponentWidget(
                            gameOpponent: GameOpponent.ai,
                            onTap: () => context.router.push(
                              GameRoute(opponentParam: 'ai'),
                            ),
                          ),
                          SizedBox(height: spacing.big),
                          SelectGameOpponentWidget(
                            gameOpponent: GameOpponent.friend,
                            onTap: () => context.router.push(
                              GameRoute(opponentParam: 'friend'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
