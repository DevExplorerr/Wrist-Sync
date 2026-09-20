import 'package:get/get.dart';

import '../../../core/services/ble_service.dart';
import '../../../routes/app_routes.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ScanController extends GetxController {
  final BleService bleService = Get.find<BleService>();
  late String deviceType;

  @override
  void onInit() {
    super.onInit();
    deviceType = Get.arguments?['deviceType'] ?? 'other_watch';
    _initiateScan();
  }

  void _initiateScan() {
    // In a production environment, you would use deviceType to filter specific UUIDs or manufacturer data.
    bleService.startScan();
  }

  Future<void> refreshScan() async {
    bleService.stopScan();
    await Future.delayed(const Duration(milliseconds: 500));
    bleService.startScan();
  }

  void connectToDevice(BluetoothDevice device) async {
    bool success = await bleService.connectToDevice(device);
    if (success) {
      Get.toNamed(AppRoutes.deviceInfo);
    }
  }

  @override
  void onClose() {
    bleService.stopScan();
    super.onClose();
  }
}
