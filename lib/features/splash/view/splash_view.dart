import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wrist_sync/core/constants/app_colors.dart';
import 'package:wrist_sync/features/splash/controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SizedBox(
        width: .infinity,
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Spacer(),
            ClipRRect(
              borderRadius: .circular(12),
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 180,
                height: 180,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'WristSync',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: .bold,
                fontFamily: 'Rubik',
                letterSpacing: 1.5,
              ),
            ),
            const Spacer(),
            LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.accent,
              size: 45,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
