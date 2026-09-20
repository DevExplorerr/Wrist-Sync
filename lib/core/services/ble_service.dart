import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:wrist_sync/core/widgets/app_snackbar.dart';

import '../utils/permission_manager.dart';

class BleService extends GetxService {
  // Reactive UI States
  final RxBool isBluetoothOn = false.obs;
  final RxBool isScanning = false.obs;
  final RxList<ScanResult> scanResults = <ScanResult>[].obs;

  // Active Connection States
  final Rx<BluetoothDevice?> connectedDevice = Rx<BluetoothDevice?>(null);
  final Rx<BluetoothConnectionState> connectionState =
      BluetoothConnectionState.disconnected.obs;

  StreamSubscription? _adapterStateSub;
  StreamSubscription? _scanResultsSub;
  StreamSubscription? _isScanningSub;
  StreamSubscription? _connectionStateSub;

  @override
  void onInit() {
    super.onInit();
    _initBluetoothAdapter();
  }

  void _initBluetoothAdapter() {
    // 1. Monitor the physical Bluetooth radio (On/Off)
    _adapterStateSub = FlutterBluePlus.adapterState.listen((state) {
      isBluetoothOn.value = (state == BluetoothAdapterState.on);
      if (state == BluetoothAdapterState.off) {
        // Attempt to prompt the user to turn it on (Android only)
        FlutterBluePlus.turnOn().catchError((_) {
          AppSnackbar.showError(
            title: 'Bluetooth Disabled',
            message: 'Please enable Bluetooth in your system settings to connect a watch.',
          );
        });
      }
    });

    // 2. Sync GetX state with the native scanning boolean
    _isScanningSub = FlutterBluePlus.isScanning.listen((scanning) {
      isScanning.value = scanning;
    });
  }

  Future<void> startScan({String? deviceTypeFilter}) async {
    // Validate hardware readiness before hitting native APIs
    bool hasPermissions = await PermissionManager.requestBlePermissions();
    if (!hasPermissions) {
      AppSnackbar.showError(
        title: 'Permissions Required',
        message: 'Location and Nearby Devices must be granted.',
      );
      return;
    }

    if (!isBluetoothOn.value) {
      AppSnackbar.showError(
        title: 'Bluetooth is Off',
        message: 'Turn on Bluetooth before scanning.',
      );
      return;
    }

    // Reset previous scan data
    scanResults.clear();
    _scanResultsSub?.cancel();

    // Listen to the live stream of discovered peripheral packets
    _scanResultsSub = FlutterBluePlus.scanResults.listen(
      (results) {
        // Filter out "ghost" devices that have no broadcast name
        final validDevices = results
            .where(
              (r) =>
                  r.device.advName.isNotEmpty ||
                  r.device.platformName.isNotEmpty,
            )
            .toList();

        // Sort by signal strength (RSSI) so the closest watch is at the top
        validDevices.sort((a, b) => b.rssi.compareTo(a.rssi));
        scanResults.assignAll(validDevices);
      },
      onError: (e) =>
          AppSnackbar.showError(title: 'Scan Error', message: e.toString()),
    );

    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      AppSnackbar.showError(
        title: 'Failed to Scan',
        message: 'Could not initialize the Bluetooth radio.',
      );
    }
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
  }

  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      stopScan(); // The radio must stop scanning before negotiating a GATT connection
      AppSnackbar.showInfo(
        title: 'Pairing',
        message: 'Connecting to ${device.platformName}...',
      );

      await device.connect(
        timeout: const Duration(seconds: 15),
        license: License.nonprofit,
      );
      connectedDevice.value = device;

      // Monitor the connection in case the watch goes out of range or dies
      _connectionStateSub?.cancel();
      _connectionStateSub = device.connectionState.listen((state) {
        connectionState.value = state;
        if (state == BluetoothConnectionState.disconnected) {
          connectedDevice.value = null;
        }
      });

      return true;
    } catch (e) {
      AppSnackbar.showError(
        title: 'Connection Failed',
        message: 'Could not establish a connection to the watch.',
      );
      return false;
    }
  }

  Future<void> disconnectDevice() async {
    if (connectedDevice.value != null) {
      await connectedDevice.value!.disconnect();
      connectedDevice.value = null;
    }
  }

  @override
  void onClose() {
    _adapterStateSub?.cancel();
    _scanResultsSub?.cancel();
    _isScanningSub?.cancel();
    _connectionStateSub?.cancel();
    super.onClose();
  }
}
