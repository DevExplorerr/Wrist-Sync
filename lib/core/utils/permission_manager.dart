import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static Future<bool> requestBlePermissions() async {
    if (!Platform.isAndroid) return false;

    // Requesting core permissions simultaneously
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    // Verify all essential permissions are granted
    bool isScanGranted = statuses[Permission.bluetoothScan]?.isGranted ?? false;
    bool isConnectGranted =
        statuses[Permission.bluetoothConnect]?.isGranted ?? false;
    bool isLocationGranted = statuses[Permission.location]?.isGranted ?? false;

    return isScanGranted && isConnectGranted && isLocationGranted;
  }
}
