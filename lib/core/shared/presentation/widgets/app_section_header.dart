// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class AppSectionHeader extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Widget? trailing;
  final double horizontalPadding;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
    this.horizontalPadding = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconWidget = icon;
    final trailingWidget = trailing;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconWidget != null) ...[
                iconWidget,
                const SizedBox(width: 8.0),
              ],
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: 'Inter',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textNavy,
                ),
              ),
            ],
          ),
          // ignore: use_null_aware_elements
          if (trailingWidget != null) trailingWidget,
        ],
      ),
    );
  }
}
