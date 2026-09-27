import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/asset_paths.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/widgets/other/image_helper.dart';

class SplashScreen extends StatefulWidget {
  final Duration splashDuration;

  const SplashScreen({
    super.key,
    this.splashDuration = const Duration(milliseconds: 2200),
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
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
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: ImageHelper(
                    height: 200.h,
                    width: 100.w,
                    imageType: ImageType.asset,
                    image: AssetPaths.thaheenLogo,
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorManager.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
