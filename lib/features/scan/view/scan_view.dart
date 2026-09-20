import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:wrist_sync/features/scan/controller/scan_controller.dart';

import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon_badge.dart';
import '../../../core/widgets/app_button.dart';

class ScanView extends GetView<ScanController> {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const AppHeader(title: 'Add New Watch'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppCard(
                child: Row(
                  children: [
                    Obx(
                      () => AppIconBadge(
                        icon: controller.bleService.isScanning.value
                            ? Icons.bluetooth_searching
                            : Icons.bluetooth,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available Devices',
                            style: theme.textTheme.titleMedium,
                          ),
                          Obx(
                            () => Text(
                              controller.bleService.isScanning.value
                                  ? 'Scanning for nearby watches...'
                                  : 'Scan complete or stopped.',
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.bleService.scanResults.isEmpty) {
                  if (controller.bleService.isScanning.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return _buildEmptyState(context);
                }

                return RefreshIndicator(
                  onRefresh: controller.refreshScan,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    itemCount: controller.bleService.scanResults.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final result = controller.bleService.scanResults[index];
                      return _buildDeviceTile(context, result);
                    },
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => AppButton(
                  text: controller.bleService.isScanning.value
                      ? 'Scanning...'
                      : 'Rescan',
                  onPressed: controller.refreshScan,
                  isLoading: controller.bleService.isScanning.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.watch_off_outlined,
            size: 64,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            'No watches found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Ensure your device is powered on\nand within Bluetooth range.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceTile(BuildContext context, ScanResult result) {
    final theme = Theme.of(context);
    final device = result.device;
    final deviceName = device.platformName.isNotEmpty
        ? device.platformName
        : (device.advName.isNotEmpty ? device.advName : 'Unknown Device');

    return AppCard(
      onTap: () => controller.connectToDevice(device),
      child: Row(
        children: [
          AppIconBadge(
            icon: Icons.watch,
            backgroundColor: theme.colorScheme.primary,
            iconColor: theme.colorScheme.secondary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(deviceName, style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(device.remoteId.str, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${result.rssi} dBm',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: result.rssi > -60
                      ? Colors.green
                      : (result.rssi > -80 ? Colors.orange : Colors.red),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Icon(
                Icons.signal_cellular_alt,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
