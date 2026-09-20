import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrist_sync/core/theme/app_theme.dart';
import 'package:wrist_sync/routes/app_pages.dart';
import 'package:wrist_sync/routes/app_routes.dart';

void main() {
  runApp(const WristSync());
}

class WristSync extends StatelessWidget {
  const WristSync({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wrist Sync',
      debugShowCheckedModeBanner: false,
      defaultTransition: .cupertino,
      theme: AppTheme.appTheme,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash
    );
  }
}
