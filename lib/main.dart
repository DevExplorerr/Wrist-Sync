import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'core/services/ble_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(BleService(), permanent: true);

  runApp(
    GetMaterialApp(
      title: 'WristSync',
      theme: AppTheme.appTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    ),
  );
}
