// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double iconSize;
  final double borderRadius;
  final BoxBorder? border;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.size = 48.0,
    this.iconSize = 24.0,
    this.borderRadius = 12.0,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
