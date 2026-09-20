import 'package:get/get.dart';
import 'package:wrist_sync/routes/app_routes.dart';

class SelectionController extends GetxController {
  void selectDeviceType(String type) {
    Get.toNamed(AppRoutes.scan, arguments: {'deviceType': type});
  }
}
