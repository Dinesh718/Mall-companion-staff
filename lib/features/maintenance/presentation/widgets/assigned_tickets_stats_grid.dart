import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class AssignedTicketsStatsGrid extends StatelessWidget {
  final int assignedCount;
  final int criticalCount;
  final int inProgressCount;

  const AssignedTicketsStatsGrid({
    super.key,
    required this.assignedCount,
    required this.criticalCount,
    required this.inProgressCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              value: assignedCount.toString().padLeft(2, '0'),
              label: 'ASSIGNED',
              valueColor: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: _StatCard(
              value: criticalCount.toString().padLeft(2, '0'),
              label: 'CRITICAL',
              valueColor: AppColors.error,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: _StatCard(
              value: inProgressCount.toString().padLeft(2, '0'),
              label: 'IN PROGRESS',
              valueColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const _StatCard({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
