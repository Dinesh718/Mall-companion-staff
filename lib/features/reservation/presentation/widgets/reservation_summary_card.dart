import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/reservation_summary_entity.dart';

class ReservationSummaryCard extends StatelessWidget {
  final ReservationSummaryEntity summary;

  const ReservationSummaryCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          _buildKpiCard(
            icon: Icons.calendar_today_rounded,
            iconColor: AppColors.primary,
            label: 'Today',
            value: summary.totalReservations.toString(),
            trend: '+12%',
          ),
          const SizedBox(width: 16.0),
          _buildKpiCard(
            icon: Icons.upcoming_rounded,
            iconColor: AppColors.secondary,
            label: 'Upcoming',
            value: summary.upcomingReservations.toString(),
          ),
          const SizedBox(width: 16.0),
          _buildKpiCard(
            icon: Icons.how_to_reg_rounded,
            iconColor: const Color(0xFF813800), // Tertiary
            label: 'Checked In',
            value: '4', // Mocked as entity lacks this field currently
          ),
          const SizedBox(width: 16.0),
          _buildKpiCard(
            icon: Icons.check_circle_rounded,
            iconColor: AppColors.success,
            label: 'Completed',
            value: summary.completedReservations.toString(),
          ),
          const SizedBox(width: 16.0),
          _buildKpiCard(
            icon: Icons.cancel_rounded,
            iconColor: AppColors.error,
            label: 'Cancelled',
            value: summary.cancelledReservations.toString(),
          ),
          const SizedBox(width: 16.0),
          _buildKpiCard(
            icon: Icons.person_off_rounded,
            iconColor: AppColors.outline,
            label: 'No Shows',
            value: '0', // Mocked as entity lacks this field currently
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    String? trend,
  }) {
    return Container(
      width: 140.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.white.withAlpha(128)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withAlpha(12),
            blurRadius: 15.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 24.0),
              if (trend != null)
                Row(
                  children: [
                    const Icon(Icons.trending_up_rounded, color: AppColors.success, size: 12.0),
                    const SizedBox(width: 4.0),
                    Text(
                      trend,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
