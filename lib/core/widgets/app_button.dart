import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isOutlined) {
      return OutlinedButton(
        onPressed: isLoading ? () {} : onPressed,
        child: _buildChild(theme),
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      child: _buildChild(theme),
    );
  }

  Widget _buildChild(ThemeData theme) {
    if (isLoading) {
      return LoadingAnimationWidget.staggeredDotsWave(
        color: isOutlined
            ? theme.colorScheme.primary
            : theme.colorScheme.primary,
        size: 24,
      );
    }
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: isOutlined
            ? theme.colorScheme.secondary
            : theme.colorScheme.primary,
      ),
    );
  }
}
