import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Total animation time is 2 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Sequence: Hold normal size -> Shrink slightly -> Zoom massively
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 40),   // Pause
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.85).chain(CurveTween(curve: Curves.easeOut)), weight: 20), // Shrink
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 50.0).chain(CurveTween(curve: Curves.easeInCubic)), weight: 40), // Zoom
    ]).animate(_controller);

    // Fade out during the final zoom phase
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 80), // Stay visible
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20), // Fade out at the end
    ]).animate(_controller);

    // Start animation and navigate when done
    _controller.forward().then((_) {
      Get.off(() => const LoginScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}