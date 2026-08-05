// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class SpecialNotesCard extends StatelessWidget {
  final String? notes;

  const SpecialNotesCard({
    super.key,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    if (notes == null || notes!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.04), // soft tint background
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.2),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vertical Accent Line
          Container(
            width: 4.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(width: 16.0),
          const Icon(
            Icons.sticky_note_2_rounded,
            color: AppColors.primary,
            size: 24.0,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Special Notes',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '"$notes"',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    color: AppColors.onSurface,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
