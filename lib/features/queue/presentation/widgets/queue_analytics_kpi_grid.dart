// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/queue_analytics_summary_entity.dart';
import '../../../../core/themes/app_colors.dart';

class QueueAnalyticsKpiGrid extends StatelessWidget {
  final QueueAnalyticsSummaryEntity summary;

  const QueueAnalyticsKpiGrid({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      childAspectRatio: 1.25,
      children: [
        _buildKpiCard(
          icon: Icons.groups_rounded,
          iconBgColor: AppColors.primary.withOpacity(0.1),
          iconColor: AppColors.primary,
          title: "TODAY'S VISITORS",
          value: '${summary.todayVisitors}',
          badgeText: '↑ ${(summary.todayVisitorsChange * 100).toInt()}%',
          badgeColor: const Color(0xFFE8F5E9),
          badgeTextColor: const Color(0xFF2E7D32),
        ),
        _buildKpiCard(
          icon: Icons.timer_rounded,
          iconBgColor: AppColors.darkBlue.withOpacity(0.1),
          iconColor: AppColors.darkBlue,
          title: 'AVG SERVICE',
          value: '${summary.avgServiceTimeMinutes}m',
          badgeText: '↓ ${(summary.avgServiceTimeChange.abs() * 100).toInt()}%',
          badgeColor: const Color(0xFFE8F5E9),
          badgeTextColor: const Color(0xFF2E7D32),
        ),
        _buildKpiCard(
          icon: Icons.person_off_rounded,
          iconBgColor: AppColors.error.withOpacity(0.1),
          iconColor: AppColors.error,
          title: 'CANCELLED',
          value: '${summary.cancelledCount}',
          badgeText: '${summary.cancelledChange < 0 ? "" : "+"}${(summary.cancelledChange * 100).toInt()}%',
          badgeColor: AppColors.error.withOpacity(0.1),
          badgeTextColor: AppColors.error,
        ),
        _buildKpiCard(
          icon: Icons.trending_up_rounded,
          iconBgColor: AppColors.warning.withOpacity(0.1),
          iconColor: AppColors.warning,
          title: 'PEAK HOUR',
          value: summary.peakHour,
          badgeText: summary.peakHourLabel,
          badgeColor: AppColors.warning.withOpacity(0.15),
          badgeTextColor: AppColors.warning,
        ),
      ],
    );
  }

  Widget _buildKpiCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String value,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(99.0),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    color: badgeTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textNavy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
