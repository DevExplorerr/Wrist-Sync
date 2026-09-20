import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surface, 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          // Inherit the global border color you defined for TextFields
          color: theme.inputDecorationTheme.enabledBorder?.borderSide.color ?? Colors.grey.shade300,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}