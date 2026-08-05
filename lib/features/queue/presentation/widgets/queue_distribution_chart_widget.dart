// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/queue_status_distribution_entity.dart';
import '../../../../core/themes/app_colors.dart';

class QueueDistributionChartWidget extends StatelessWidget {
  final List<QueueStatusDistributionEntity> distribution;
  final int totalUsers;

  const QueueDistributionChartWidget({
    super.key,
    required this.distribution,
    required this.totalUsers,
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
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Queue Distribution',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textNavy,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert_rounded, color: AppColors.onSurfaceVariant),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 360;
              return Flex(
                direction: isSmall ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Chart
                  SizedBox(
                    width: 160.0,
                    height: 160.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(160.0, 160.0),
                          painter: _DonutChartPainter(distribution: distribution),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$totalUsers',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 24.0,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textNavy,
                              ),
                            ),
                            const Text(
                              'TOTAL USERS',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 9.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24.0, height: 24.0),
                  // Legend
                  Expanded(
                    flex: isSmall ? 0 : 1,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 12.0,
                        mainAxisExtent: 36.0,
                      ),
                      itemCount: distribution.length,
                      itemBuilder: (context, index) {
                        final item = distribution[index];
                        final color = Color(int.parse('0xFF${item.colorHex}'));
                        return Row(
                          children: [
                            Container(
                              width: 10.0,
                              height: 10.0,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.status,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${item.count}',
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textNavy,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final List<QueueStatusDistributionEntity> distribution;

  _DonutChartPainter({required this.distribution});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    const strokeWidth = 20.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    double total = 0;
    for (final item in distribution) {
      total += item.count;
    }

    if (total == 0) {
      paint.color = Colors.grey.shade200;
      canvas.drawCircle(center, radius - strokeWidth / 2, paint);
      return;
    }

    double startAngle = -pi / 2;

    for (final item in distribution) {
      if (item.count == 0) continue;
      final sweepAngle = (item.count / total) * 2 * pi;
      paint.color = Color(int.parse('0xFF${item.colorHex}'));

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
