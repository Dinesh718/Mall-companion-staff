// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class QueueAnalyticsFilterBar extends StatelessWidget {
  final String activeRange;
  final ValueChanged<String> onRangeChanged;
  final VoidCallback onCalendarTap;
  final VoidCallback onFiltersTap;

  const QueueAnalyticsFilterBar({
    super.key,
    required this.activeRange,
    required this.onRangeChanged,
    required this.onCalendarTap,
    required this.onFiltersTap,
  });

  @override
  Widget build(BuildContext context) {
    final ranges = ['Today', 'Yesterday', 'This Week'];

    return Row(
      children: [
        // 1. Horizontally scrollable capsule options to prevent overflow on small screens
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                // Date options capsule
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F3FF),
                    borderRadius: BorderRadius.circular(99.0),
                    border: Border.all(
                      color: AppColors.outlineVariant.withOpacity(0.3),
                    ),
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: ranges.map((r) {
                      final isSelected = activeRange.toLowerCase() == r.toLowerCase();
                      return GestureDetector(
                        onTap: () => onRangeChanged(r),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(99.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            r,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 8.0),

                // Calendar Button
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F3FF),
                    borderRadius: BorderRadius.circular(99.0),
                    border: Border.all(
                      color: AppColors.outlineVariant.withOpacity(0.3),
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.onSurfaceVariant,
                      size: 20.0,
                    ),
                    onPressed: onCalendarTap,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 8.0),

        // 2. Fixed trailing Filters button
        TextButton.icon(
          onPressed: onFiltersTap,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: const Icon(
            Icons.tune_rounded,
            size: 18.0,
          ),
          label: const Text(
            'Filters',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}