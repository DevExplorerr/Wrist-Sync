import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrist_sync/core/constants/app_colors.dart';

class AppSnackbar {
  static void showSuccess({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.shade800,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
  }

  static void showError({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      duration: const Duration(seconds: 4),
    );
  }

  static void showInfo({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.info_outline, color: AppColors.accent),
      duration: const Duration(seconds: 3),
    );
  }
}
