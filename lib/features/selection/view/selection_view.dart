import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrist_sync/core/widgets/app_button.dart';
import 'package:wrist_sync/core/widgets/app_header.dart';
import 'package:wrist_sync/features/selection/controller/selection_controller.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon_badge.dart';

class SelectionView extends GetView<SelectionController> {
  const SelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: const AppHeader(title: 'Choose Your Watch'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const .symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              const SizedBox(height: 30),
              AppCard(
                padding: const .all(20),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.watch, color: theme.colorScheme.primary),
                        const SizedBox(width: 10),
                        Text('Select Your Watch', style: textTheme.titleMedium),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choose your smartwatch brand to continue pairing',
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    _buildDeviceRow(
                      context,
                      icon: Icons.watch_outlined,
                      title: 'Smart Watches',
                      subtitle: 'Connect Fitpro Smart Watch and other Huawei smartwatches.',
                      onTap: () => controller.selectDeviceType('smart_watch'),
                    ),
                    const SizedBox(height: 16),
                    _buildDeviceRow(
                      context,
                      icon: Icons.watch_later_outlined,
                      title: 'Other Watches',
                      subtitle: 'Connect compatible Bluetooth smartwatches from other brands.',
                      onTap: () => controller.selectDeviceType('other_watch'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return AppCard(
      onTap: onTap,
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              AppIconBadge(
                icon: icon,
                backgroundColor: theme.colorScheme.primary,
                iconColor: theme.colorScheme.secondary,
              ),
              const SizedBox(width: 12),
              Text(title, style: textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 12),
          Text(subtitle, style: textTheme.bodyMedium?.copyWith(height: 1.3)),
          const SizedBox(height: 16),
          AppButton(text: "Continue >", onPressed: onTap),
        ],
      ),
    );
  }
}
