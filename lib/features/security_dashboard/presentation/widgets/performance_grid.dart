import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/security_dashboard_entity.dart';

class PerformanceGrid extends StatelessWidget {
  final PerformanceSummaryEntity performance;

  const PerformanceGrid({
    super.key,
    required this.performance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today\'s Performance',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12.0),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.6, // Adjusted based on design
          children: [
            _buildPerformanceCard(
              icon: Icons.check_circle_outline,
              color: AppColors.secondary,
              value: performance.incidentsResolved.toString(),
              label: 'Resolved',
            ),
            _buildPerformanceCard(
              icon: Icons.timer_outlined,
              color: AppColors.primary,
              value: '${performance.averageResponseTimeMinutes.toStringAsFixed(1)}m',
              label: 'Avg Resp.',
            ),
            _buildPerformanceCard(
              icon: Icons.security_outlined,
              color: AppColors.tertiary,
              value: '${performance.patrolAccuracyPercentage.toInt()}%',
              label: 'Patrol Accuracy',
            ),
            _buildPerformanceCard(
              icon: Icons.visibility_outlined,
              color: AppColors.onSurface,
              value: performance.securityChecks.toString(),
              label: 'Security Checks',
              borderColor: AppColors.secondary, // design uses border-secondary/10
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceCard({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: (borderColor ?? color).withAlpha(25), // 10% opacity
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 4.0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24.0, // headline-lg is 32 in css, but 24-28 might fit better in flutter grid
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                  color: color,
                ),
              ),
              const SizedBox(height: 2.0),
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
        ],
      ),
    );
  }
}
