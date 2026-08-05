import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../reservation/domain/entities/reservation_details_entity.dart';

class CustomerInsightsBanner extends StatelessWidget {
  final ReservationDetailsEntity details;

  const CustomerInsightsBanner({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEFF4FF), Colors.white],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.primary.withAlpha(25)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.insights_rounded,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details.insightTitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  details.insightDescription,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.outlineVariant,
          ),
        ],
      ),
    );
  }
}
