// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class AppAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final double borderWidth;
  final Color borderColor;
  final IconData fallbackIcon;

  const AppAvatar({
    super.key,
    required this.imageUrl,
    this.size = 32.0,
    this.borderWidth = 1.0,
    this.borderColor = const Color(0xFFCCC3D9), // outline variant
    this.fallbackIcon = Icons.storefront,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(
          fallbackIcon,
          size: size * 0.5,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
