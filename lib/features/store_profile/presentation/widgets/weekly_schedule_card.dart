// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_info_card.dart';
import '../../../../core/shared/presentation/widgets/app_section_header.dart';
import '../../../../core/shared/presentation/widgets/app_status_chip.dart';
import '../../domain/entities/store_entity.dart';

class WeeklyScheduleCard extends StatelessWidget {
  final StoreEntity store;

  const WeeklyScheduleCard({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    // List of days in chronological order
    final daysOrder = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return AppInfoCard(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          const AppSectionHeader(
            title: 'Store Hours',
            icon: Icon(
              Icons.calendar_today_rounded,
              color: AppColors.primary,
              size: 24.0,
            ),
            horizontalPadding: 0.0,
          ),
          const SizedBox(height: 20.0),

          // Rows list
          ...daysOrder.map((day) {
            final hours = store.weeklyHours[day] ?? 'Closed';
            final isClosed = hours.toLowerCase() == 'closed';
            // Highlighting Friday exactly like the Stitch design
            final isHighlighted = day == 'Friday';

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              decoration: BoxDecoration(
                color: isHighlighted ? AppColors.primary.withOpacity(0.05) : Colors.transparent,
                borderRadius: BorderRadius.circular(16.0),
                border: isHighlighted
                    ? Border.all(
                        color: AppColors.primary.withOpacity(0.1),
                        width: 1.0,
                      )
                    : null,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 96.0,
                    child: Text(
                      day,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                        color: isHighlighted ? AppColors.primary : AppColors.textNavy,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      hours,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: isHighlighted ? FontWeight.w500 : FontWeight.normal,
                        color: isHighlighted ? AppColors.textNavy : AppColors.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  AppStatusChip(
                    label: isClosed ? 'CLOSED' : 'OPEN',
                    textColor: isClosed ? AppColors.textGray : const Color(0xFF047857),
                    backgroundColor: isClosed ? const Color(0xFFE8DFEF) : const Color(0xFFECFDF5),
                    borderColor: isClosed ? AppColors.outlineVariant : const Color(0xFFD1FAE5),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
