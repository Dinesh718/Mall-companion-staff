import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 22.0, // title-lg
          fontWeight: FontWeight.w600, // semibold
          color: AppColors.onSurface,
        ),
      ),
    );
  }
}
