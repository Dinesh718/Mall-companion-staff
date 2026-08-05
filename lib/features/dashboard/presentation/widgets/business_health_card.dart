// ignore_for_file: deprecated_member_use

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/store_dashboard_entity.dart';

class BusinessHealthCard extends StatelessWidget {
  final StoreDashboardEntity dashboard;

  const BusinessHealthCard({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F2937).withOpacity(0.05),
              blurRadius: 12.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title + Action Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Business Health',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontFamily: 'Inter',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textNavy,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Detailed Report (mock)'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text(
                    'DETAILED REPORT',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // Progress Indicators Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProgressRing(
                  percentage: dashboard.trafficPercentage,
                  label: 'Store Traffic',
                  colors: [const Color(0xFF7B2FF7), const Color(0xFF3B82F6)],
                ),
                _buildProgressRing(
                  percentage: dashboard.revenueTargetPercentage,
                  label: 'Rev. Target',
                  colors: [const Color(0xFF6B4DA9), const Color(0xFFBA9AFD)],
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // Footer grid
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.outlineVariant.withOpacity(0.3),
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'CSAT SCORE',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurfaceVariant,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '${dashboard.csatScore}/5.0',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontFamily: 'Inter',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textNavy,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1.0,
                    height: 36.0,
                    color: AppColors.outlineVariant.withOpacity(0.3),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'AVG. QUEUE',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurfaceVariant,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '${dashboard.avgQueueTimeMinutes} min',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontFamily: 'Inter',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textNavy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRing({
    required int percentage,
    required String label,
    required List<Color> colors,
  }) {
    return Column(
      children: [
        SizedBox(
          width: 96.0,
          height: 96.0,
          child: CustomPaint(
            painter: _GradientCircularProgressPainter(
              progress: percentage / 100,
              colors: colors,
            ),
            child: Center(
              child: Text(
                '$percentage%',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textNavy,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final double progress;
  final List<Color> colors;

  _GradientCircularProgressPainter({
    required this.progress,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 10) / 2;

    final backgroundPaint = Paint()
      ..color = const Color(0xFFF3EBFA) // surface-container-high
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawCircle(center, radius, backgroundPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    final progressPaint = Paint()
      ..shader = SweepGradient(
        colors: colors,
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
