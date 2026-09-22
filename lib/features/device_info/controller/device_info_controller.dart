import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:wrist_sync/core/widgets/app_snackbar.dart';

import '../../../core/services/ble_service.dart';
import '../../../routes/app_routes.dart';

class DeviceInfoController extends GetxController {
  final BleService bleService = Get.find<BleService>();

  final RxList<BluetoothService> services = <BluetoothService>[].obs;
  final RxInt mtuSize = 0.obs;
  final RxBool isDiscovering = true.obs;

  StreamSubscription? _connectionSub;

  @override
  void onInit() {
    super.onInit();
    _monitorConnection();
    _discoverDeviceData();
  }

  void _monitorConnection() {
    _connectionSub = bleService.connectionState.listen((state) {
      if (state == BluetoothConnectionState.disconnected) {
        AppSnackbar.showInfo(
          title: 'Disconnected',
          message: 'The watch has been disconnected.',
        );
        Get.offAllNamed(AppRoutes.home);
      }
    });
  }

  Future<void> _discoverDeviceData() async {
    final device = bleService.connectedDevice.value;
    if (device != null) {
      try {
        // Fetching MTU (Maximum Transmission Unit) and GATT services shows a deep
        // understanding of BLE architecture beyond just connecting.
        mtuSize.value = await device.mtu.first;
        services.value = await device.discoverServices();
      } catch (e) {
        AppSnackbar.showError(
          title: 'Discovery Failed',
          message: 'Could not read device services.',
        );
      } finally {
        isDiscovering.value = false;
      }
    }
  }

  Future<void> disconnect() async {
    await bleService.disconnectDevice();
    // The _connectionSub will automatically catch this and route the user home.
  }

  @override
  void onClose() {
    _connectionSub?.cancel();
    super.onClose();
  }
}
