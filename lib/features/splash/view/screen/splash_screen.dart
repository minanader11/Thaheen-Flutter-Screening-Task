import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/asset_paths.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../../../core/widgets/other/image_helper.dart';

class SplashScreen extends StatefulWidget {
  final Duration splashDuration;

  const SplashScreen({
    super.key,
    this.splashDuration = const Duration(milliseconds: 2400),
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _glowFade;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _loaderFade;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _glowFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeIn),
    );

    _logoScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _textFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.75, curve: Curves.easeIn),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _loaderFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.65, 1.0, curve: Curves.easeIn),
    );

    _controller.forward();
    _timer = Timer(widget.splashDuration, _navigateToCourses);
  }

  void _navigateToCourses() {
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(Routes.courses);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mirrors the tones defined in MyApp's `darkTheme` (0xFF121212 /
    // 0xFF1E1E1E / 0xFFE8E8E8) so splash matches the resolved app theme.
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF121212) : ColorManager.background;
    final surfaceColor = isDark ? const Color(0xFF1E1E1E) : ColorManager.surface;
    final textColor = isDark ? const Color(0xFFE8E8E8) : ColorManager.textPrimary;
    final mutedColor = isDark ? const Color(0xFFA8A8A8) : ColorManager.textMuted;
    final trackColor =
    isDark ? Colors.white.withOpacity(0.08) : ColorManager.surfaceElevated;
    final orbOpacityStart = isDark ? 0.10 : 0.16;
    final orbOpacityEnd = isDark ? 0.07 : 0.12;
    final logoShadowOpacity = isDark ? 0.28 : 0.18;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Soft brand-colored orbs, tuned per theme ───────
          Positioned(
            top: -90.h,
            right: -70.w,
            child: _GlowOrb(
              size: 240.r,
              color: ColorManager.primaryGradientStart
                  .withOpacity(orbOpacityStart),
            ),
          ),
          Positioned(
            bottom: -110.h,
            left: -80.w,
            child: _GlowOrb(
              size: 280.r,
              color:
              ColorManager.primaryGradientEnd.withOpacity(orbOpacityEnd),
            ),
          ),

          // ── Content ────────────────────────────────────────
          SafeArea(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(flex: 3),

                    // Logo on a theme-aware surface card
                    FadeTransition(
                      opacity: _logoFade,
                      child: ScaleTransition(
                        scale: _logoScale,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            FadeTransition(
                              opacity: _glowFade,
                              child: Container(
                                width: 190.r,
                                height: 190.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      ColorManager.primaryGradientStart
                                          .withOpacity(isDark ? 0.20 : 0.25),
                                      ColorManager.primaryGradientEnd
                                          .withOpacity(0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(22.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: surfaceColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.primary
                                        .withOpacity(logoShadowOpacity),
                                    blurRadius: 28.r,
                                    offset: Offset(0, 10.h),
                                  ),
                                ],
                              ),
                              child: ImageHelper(
                                height: 100.h,
                                width: 100.w,
                                imageType: ImageType.asset,
                                image: AssetPaths.thaheenLogo,
                                boxFit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 28.h),

                    // App name + tagline
                    SlideTransition(
                      position: _textSlide,
                      child: FadeTransition(
                        opacity: _textFade,
                        child: Column(
                          children: [
                            CustomText(
                              text: 'منصة ذهين',
                              style: TextStyles.headlineLarge.copyWith(
                                color: textColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            CustomText(
                              text: 'تعلّم بلا حدود',
                              style: TextStyles.bodyMedium.copyWith(
                                color: mutedColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(flex: 3),

                    // Slim gradient progress bar
                    FadeTransition(
                      opacity: _loaderFade,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40.h),
                        child: SizedBox(
                          width: 120.w,
                          height: 4.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: Stack(
                              children: [
                                Container(color: trackColor),
                                const _GradientLoaderBar(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Soft radial-gradient circle used for background depth.
class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0)],
        ),
      ),
    );
  }
}

/// Indeterminate progress bar filled with the brand gradient.
/// Colors are brand-constant across themes — only the track behind it
/// (passed from the parent) changes with light/dark.
class _GradientLoaderBar extends StatefulWidget {
  const _GradientLoaderBar();

  @override
  State<_GradientLoaderBar> createState() => _GradientLoaderBarState();
}

class _GradientLoaderBarState extends State<_GradientLoaderBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Align(
          alignment: Alignment(
            -1 +
                4 *
                    (_controller.value < 0.5
                        ? _controller.value
                        : 1 - _controller.value),
            0,
          ),
          child: FractionallySizedBox(
            widthFactor: 0.4,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ColorManager.primaryGradientStart,
                    ColorManager.primaryGradientEnd,
                  ],
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        );
      },
    );
  }
}