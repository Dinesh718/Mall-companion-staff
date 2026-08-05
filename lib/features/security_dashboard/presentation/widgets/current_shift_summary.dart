import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/security_dashboard_entity.dart';

class CurrentShiftSummary extends StatelessWidget {
  final ShiftSummaryEntity shiftSummary;

  const CurrentShiftSummary({
    super.key,
    required this.shiftSummary,
  });

  @override
  Widget build(BuildContext context) {
    final startTime = DateFormat('hh:mm a').format(shiftSummary.shiftStart);
    final endTime = DateFormat('hh:mm a').format(shiftSummary.shiftEnd);
    
    final remaining = shiftSummary.remainingTime;
    final hours = remaining.inHours;
    final minutes = remaining.inMinutes.remainder(60);
    final remainingText = '${hours}h ${minutes}m';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.surfaceVariant.withAlpha(128)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: AppColors.onSurfaceVariant,
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Shift',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    '$startTime - $endTime',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Remaining: $remainingText',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.timer_outlined,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
