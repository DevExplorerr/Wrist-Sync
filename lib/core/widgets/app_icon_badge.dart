import 'package:flutter/material.dart';

class AppIconBadge extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;

  const AppIconBadge({
    super.key,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            theme.colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: iconColor ?? theme.colorScheme.primary,
        size: 24,
      ),
    );
  }
}
