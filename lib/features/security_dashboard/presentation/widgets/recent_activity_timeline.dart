import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/security_dashboard_entity.dart';

class RecentActivityTimeline extends StatelessWidget {
  final List<ActivityTimelineEntity> activities;

  const RecentActivityTimeline({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12.0),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            children: activities.asMap().entries.map((entry) {
              final index = entry.key;
              final activity = entry.value;
              final isLast = index == activities.length - 1;
              return _buildTimelineItem(activity, isLast);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(ActivityTimelineEntity activity, bool isLast) {
    // Determine colors based on status (Resolved, Completed, etc.)
    Color tagBgColor;
    Color tagTextColor;
    Color nodeColor;

    if (activity.status.toLowerCase() == 'resolved') {
      tagBgColor = Colors.green.shade100;
      tagTextColor = Colors.green.shade700;
      nodeColor = AppColors.primary;
    } else {
      tagBgColor = Colors.blue.shade100;
      tagTextColor = Colors.blue.shade700;
      nodeColor = AppColors.surfaceVariant;
    }

    final formattedTime = DateFormat('hh:mm a').format(activity.time);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline Node & Line
          SizedBox(
            width: 24.0,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (!isLast)
                  Positioned.fill(
                    top: 16.0,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 2.0,
                        color: AppColors.primary.withAlpha(51),
                      ),
                    ),
                  ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: 16.0,
                    height: 16.0,
                    decoration: BoxDecoration(
                      color: nodeColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.background,
                        width: 4.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          activity.activity,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: tagBgColor,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Text(
                          activity.status.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: tagTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '$formattedTime • ${activity.description}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant.withAlpha(178),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
