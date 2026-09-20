import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrist_sync/core/constants/app_colors.dart';
import 'package:wrist_sync/core/widgets/app_button.dart';
import 'package:wrist_sync/core/widgets/app_card.dart';
import 'package:wrist_sync/core/widgets/app_header.dart';
import 'package:wrist_sync/core/widgets/app_icon_badge.dart';
import 'package:wrist_sync/features/home/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: "Smart Watch App", showBackButton: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const .all(20.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Connect, customize, and manage your watch',
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _buildHeroCard(context),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildActionTile(
                      context,
                      title: 'My Watches',
                      subtitle: 'View & Manage Devices',
                      icon: Icons.watch_rounded,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionTile(
                      context,
                      title: 'Watch Faces',
                      subtitle: 'Explore New Faces Styles',
                      icon: Icons.palette_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildHelpCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      backgroundColor: theme.colorScheme.primary,
      padding: const .all(20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Connect Your Watch',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pair your smart watch to get started',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  text: "Connect Now >",
                  onPressed: controller.navigateToSelection,
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: .circular(12),
              child: Image.asset(
                'assets/images/app_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIconBadge(icon: icon),
          const SizedBox(height: 16),
          Text(title, style: textTheme.bodyLarge),
          const SizedBox(height: 4),
          Text(subtitle, style: textTheme.bodySmall, maxLines: 2),
        ],
      ),
    );
  }

  Widget _buildHelpCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      onTap: () {},
      child: Row(
        children: [
          Icon(Icons.info_outline, color: textTheme.bodySmall?.color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text('Need help connecting?', style: textTheme.bodyLarge),
                Text('View the quick setup guide.', style: textTheme.bodySmall),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: textTheme.bodySmall?.color,
          ),
        ],
      ),
    );
  }
}
