import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe_app/constants/assets.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/l10n_provider.dart';
import 'package:tic_tac_toe_app/core/presentation/providers/splash_provider.dart';
import 'package:tic_tac_toe_app/core/presentation/routing/routes.dart';
import 'package:tic_tac_toe_app/features/game/presentation/views/home_page.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _lottieController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _contentOpacityAnimation;
  late Animation<double> _backgroundOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _lottieController = AnimationController(vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));

    _contentOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 40,
      ),
    ]).animate(_controller);

    _backgroundOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 80,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 20,
      ),
    ]).animate(_controller);

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Initialize services
    await ref.read(splashProvider).initialize();

    // Wait for splash animation duration
    await Future.delayed(const Duration(milliseconds: 2000));

    if (mounted) {
      await _controller.forward();

      if (mounted) {
        context.router.replace(const HomeRoute());
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final l10n = ref.read(l10nProvider);

    return Stack(
      children: [
        // Preload home page in the background so it's ready when splash fades
        const HomePage(),
        // Splash screen overlay
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _backgroundOpacityAnimation.value,
              child: Scaffold(
                backgroundColor: theme.colors.primaryColor,
                body: SafeArea(
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Column(
                            children: [
                              Opacity(
                                opacity: _contentOpacityAnimation.value,
                                child: Column(
                                  children: [
                                    Text(
                                      l10n.page_title_tic_tac_toe,
                                      style: theme.typography.page.xxlBoldTitle.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: theme.colors.primaryText,
                                        shadows: [
                                          Shadow(
                                            color: Colors.blue.withValues(alpha: 0.6),
                                            blurRadius: 30,
                                          ),
                                          Shadow(
                                            color: Colors.blue.withValues(alpha: 0.6),
                                            blurRadius: 30,
                                          ),
                                          Shadow(
                                            color: Colors.blue.withValues(alpha: 0.6),
                                            blurRadius: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: theme.spacing.semiSmall),
                                    AppText.largeBody(
                                      l10n.lets_play_together,
                                      color: theme.colors.secondaryText,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: theme.spacing.regular),
                            child: Column(
                              children: [
                                Opacity(
                                  opacity: _contentOpacityAnimation.value,
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      theme.colors.playerTwoColor,
                                      BlendMode.srcIn,
                                    ),
                                    child: Lottie.asset(
                                      Assets.lottieLoadingDots,
                                      width: 100,
                                      repeat: true,
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: _contentOpacityAnimation.value,
                                  child: AppText.smallBoldBody(
                                    l10n.loading_experience,
                                    color: theme.colors.playerTwoColor,
                                  ),
                                ),
                                SizedBox(height: theme.spacing.huge),
                                AppText.xxsBody(
                                  l10n.attribution,
                                  color: theme.colors.primaryText,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
