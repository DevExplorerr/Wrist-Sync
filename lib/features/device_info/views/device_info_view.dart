import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrist_sync/features/device_info/controller/device_info_controller.dart';

import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';

class DeviceInfoView extends GetView<DeviceInfoController> {
  const DeviceInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final device = controller.bleService.connectedDevice.value;

    if (device == null) {
      return const Scaffold(body: Center(child: Text('No device connected.')));
    }

    final deviceName = device.platformName.isNotEmpty
        ? device.platformName
        : (device.advName.isNotEmpty ? device.advName : 'Unknown Watch');

    return Scaffold(
      appBar: const AppHeader(title: 'Device Details'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Hero Image
                    Image.asset(
                      'assets/logo.png',
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),
                    Text(deviceName, style: theme.textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bluetooth_connected,
                            color: Colors.green,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Connected',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Hardware Details Card
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hardware Information',
                            style: theme.textTheme.titleMedium,
                          ),
                          const Divider(height: 30),
                          _buildInfoRow(
                            context,
                            'MAC Address',
                            device.remoteId.str,
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => _buildInfoRow(
                              context,
                              'MTU Size',
                              controller.mtuSize.value == 0
                                  ? 'Reading...'
                                  : '${controller.mtuSize.value} bytes',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => _buildInfoRow(
                              context,
                              'GATT Services',
                              controller.isDiscovering.value
                                  ? 'Discovering...'
                                  : '${controller.services.length} services available',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Disconnect Button Pinned to Bottom
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppButton(
                text: 'Disconnect Watch',
                isOutlined: true,
                onPressed: controller.disconnect,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.disabledColor,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
