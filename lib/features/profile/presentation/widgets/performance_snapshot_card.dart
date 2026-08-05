import 'package:flutter/material.dart';
import '../../domain/entities/profile_entity.dart';
import '../../../../core/themes/app_colors.dart';

class PerformanceSnapshotCard extends StatelessWidget {
  final ProfileEntity profile;

  const PerformanceSnapshotCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final perf = profile.performance;
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(37, 99, 235, 0.08),
            blurRadius: 15.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PERFORMANCE SNAPSHOT',
            style: TextStyle(
              fontFamily: 'Work Sans',
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.05,
              color: Color(0xFF4A4455),
            ),
          ),
          const SizedBox(height: 16.0),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.8,
            children: [
              _buildMetricCard(
                label: 'COMPLETED',
                value: perf.ticketsCompleted.toString(),
                valueColor: AppColors.primary,
                borderColor: AppColors.primary,
              ),
              _buildMetricCard(
                label: 'RESOLUTION',
                value: '${perf.averageResolutionTimeMinutes}m',
                valueColor: AppColors.secondary,
                borderColor: AppColors.secondary,
              ),
              _buildMetricCard(
                label: 'ATTENDANCE',
                value: '${perf.attendancePercentage}%',
                valueColor: const Color(0xFF4E4E58), // tertiary
                borderColor: const Color(0xFF4E4E58),
              ),
              _buildMetricCard(
                label: 'RATING',
                value: perf.rating.toString(),
                valueColor: const Color(0xFFCA8A04), // yellow-600
                borderColor: const Color(0xFFEAB308), // yellow-500
                icon: Icons.star_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String label,
    required String value,
    required Color valueColor,
    required Color borderColor,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F6), // surface-container-low
        borderRadius: BorderRadius.circular(12.0),
        border: Border(
          left: BorderSide(color: borderColor, width: 4.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Work Sans',
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.05,
              color: Color(0xFF4A4455),
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 4.0),
                Icon(icon, color: borderColor, size: 14.0),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
