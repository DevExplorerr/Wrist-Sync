import 'package:get/get.dart';
import 'package:wrist_sync/features/scan/controller/scan_controller.dart';

class ScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanController>(() => ScanController());
  }
}
