// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/staff_performance_entity.dart';
import '../../../../core/themes/app_colors.dart';

class StaffPerformanceCard extends StatelessWidget {
  final StaffPerformanceEntity staffPerformance;

  const StaffPerformanceCard({
    super.key,
    required this.staffPerformance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Staff Performance',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textNavy,
            ),
          ),
          const SizedBox(height: 20.0),
          // Active Staff
          _buildMetricRow(
            icon: Icons.engineering_rounded,
            iconColor: AppColors.primary,
            label: 'Active Staff',
            value: '${staffPerformance.activeStaffCount} Members',
          ),
          const SizedBox(height: 12.0),
          // Avg/Staff
          _buildMetricRow(
            icon: Icons.diversity_1_rounded,
            iconColor: AppColors.primary,
            label: 'Avg/Staff',
            value: '${staffPerformance.avgCustomersServedPerStaff} Customers',
          ),
          const SizedBox(height: 12.0),
          // Fastest
          _buildMetricRow(
            icon: Icons.rocket_launch_rounded,
            iconColor: AppColors.success,
            label: 'Fastest',
            value: '${staffPerformance.fastestServiceMinutes} Minutes',
          ),
          const SizedBox(height: 24.0),
          // Team Efficiency
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TEAM EFFICIENCY',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '${(staffPerformance.teamEfficiency * 100).toInt()}%',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(99.0),
                child: LinearProgressIndicator(
                  value: staffPerformance.teamEfficiency,
                  backgroundColor: const Color(0xFFEFF4FF),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 6.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF), // surface-container/30
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 20.0,
              ),
              const SizedBox(width: 12.0),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textNavy,
            ),
          ),
        ],
      ),
    );
  }
}
