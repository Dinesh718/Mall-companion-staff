// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_summary_entity.dart';

class QueuePreviewCard extends StatelessWidget {
  final QueueSummaryEntity summary;

  const QueuePreviewCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            children: [
              const Icon(
                Icons.analytics_outlined,
                color: AppColors.primary,
                size: 24.0,
              ),
              const SizedBox(width: 8.0),
              const Expanded(
                child: Text(
                  "Today's Queue Summary",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Divider(color: AppColors.outlineVariant, height: 1.0, thickness: 0.5),
          const SizedBox(height: 20.0),

          // 3-Column Metrics Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricColumn(
                Icons.groups_rounded,
                '${summary.waitingCount}',
                'Waiting',
              ),
              _buildDivider(),
              _buildMetricColumn(
                Icons.schedule_rounded,
                '${summary.avgWaitTimeMinutes}m',
                'Avg. Wait',
              ),
              _buildDivider(),
              _buildMetricColumn(
                Icons.countertops_rounded,
                '${summary.servingCount}',
                'Active',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricColumn(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24.0,
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40.0,
      width: 1.0,
      color: AppColors.outlineVariant.withOpacity(0.3),
    );
  }
}
