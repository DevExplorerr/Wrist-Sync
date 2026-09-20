import 'package:get/get.dart';
import 'package:wrist_sync/features/home/bindings/home_binding.dart';
import 'package:wrist_sync/features/home/view/home_view.dart';
import 'package:wrist_sync/features/onboarding/controller/onboarding_controller.dart';
import 'package:wrist_sync/features/onboarding/view/onboarding_view.dart';
import 'package:wrist_sync/features/scan/bindings/scan_binding.dart';
import 'package:wrist_sync/features/scan/view/scan_view.dart';
import 'package:wrist_sync/features/selection/binding/selection_binding.dart';
import 'package:wrist_sync/features/selection/view/selection_view.dart';
import 'package:wrist_sync/features/splash/controller/splash_controller.dart';
import 'package:wrist_sync/features/splash/view/splash_view.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OnboardingController());
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.selection,
      page: () => const SelectionView(),
      binding: SelectionBinding(),
    ),
    GetPage(
      name: AppRoutes.scan,
      page: () => const ScanView(),
      binding: ScanBinding(),
    ),
  ];
}
