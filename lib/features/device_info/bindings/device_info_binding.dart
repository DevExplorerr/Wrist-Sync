import 'package:get/get.dart';
import 'package:wrist_sync/features/device_info/controller/device_info_controller.dart';

class DeviceInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeviceInfoController>(() => DeviceInfoController());
  }
}
