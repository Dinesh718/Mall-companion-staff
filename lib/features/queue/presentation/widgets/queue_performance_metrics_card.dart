// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/performance_metrics_entity.dart';
import '../../../../core/themes/app_colors.dart';

class QueuePerformanceMetricsCard extends StatelessWidget {
  final PerformanceMetricsEntity performance;

  const QueuePerformanceMetricsCard({
    super.key,
    required this.performance,
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
            'Performance',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textNavy,
            ),
          ),
          const SizedBox(height: 20.0),
          // Completion Rate
          _buildProgressMeter(
            title: 'Completion Rate',
            valueText: '${(performance.completionRate * 100).toInt()}%',
            progress: performance.completionRate,
            color: AppColors.primary,
            subtitle: performance.completionRateLabel,
          ),
          const SizedBox(height: 20.0),
          // Cancellation Rate
          _buildProgressMeter(
            title: 'Cancellation',
            valueText: '${(performance.cancellationRate * 100).toInt()}%',
            progress: performance.cancellationRate,
            color: AppColors.error,
            subtitle: performance.cancellationRateLabel,
          ),
          const SizedBox(height: 24.0),
          // Stability Indicator
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.1),
              ),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  performance.isStable ? Icons.verified_rounded : Icons.info_outline_rounded,
                  color: AppColors.primary,
                  size: 18.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11.0,
                        height: 1.4,
                        color: AppColors.onSurfaceVariant,
                      ),
                      children: [
                        const TextSpan(text: 'System is '),
                        TextSpan(
                          text: performance.isStable ? 'Stable' : 'Spiked',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: performance.stabilityMessage.replaceAll(RegExp(r'^System is Stable|^System is Spiked'), '')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressMeter({
    required String title,
    required String valueText,
    required double progress,
    required Color color,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            Text(
              valueText,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(99.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFEFF4FF),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8.0,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 10.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: color.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
