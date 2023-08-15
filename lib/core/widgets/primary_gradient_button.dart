import 'package:flutter/material.dart';

import '../config/theme/app_colors.dart';

class PrimaryGradientButton extends StatelessWidget {
  const PrimaryGradientButton({
    super.key,
    required this.label,
    required this.onPress,
  });

  final String label;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: AppColors.primaryButtonGradient,
          ),
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(label,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
