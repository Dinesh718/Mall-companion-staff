// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class AppGradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double height;
  final double width;
  final double borderRadius;
  final List<Color>? gradientColors;

  const AppGradientButton({
    super.key,
    required this.child,
    this.onTap,
    this.height = 56.0,
    this.width = double.infinity,
    this.borderRadius = 16.0,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ??
        [
          AppColors.primaryGradientStart,
          AppColors.primaryGradientEnd,
        ];

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.3),
            blurRadius: 16.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
