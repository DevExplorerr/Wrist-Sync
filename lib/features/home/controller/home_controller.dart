import 'package:get/get.dart';
import 'package:wrist_sync/routes/app_routes.dart';

class HomeController extends GetxController {
  void navigateToSelection() {
    Get.toNamed(AppRoutes.selection);
  }
}