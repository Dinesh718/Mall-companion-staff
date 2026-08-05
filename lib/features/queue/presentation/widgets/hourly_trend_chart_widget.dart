// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/hourly_queue_trend_entity.dart';
import '../../../../core/themes/app_colors.dart';

class HourlyTrendChartWidget extends StatelessWidget {
  final List<HourlyQueueTrendEntity> trends;

  const HourlyTrendChartWidget({
    super.key,
    required this.trends,
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
                  'Hourly Trend',
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
              Row(
                children: [
                  _buildLegendItem(AppColors.primary, 'Today', isSolid: true),
                  const SizedBox(width: 12.0),
                  _buildLegendItem(AppColors.outline.withOpacity(0.5), 'Average', isSolid: false),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            height: 180.0,
            child: trends.isEmpty
                ? const Center(child: Text('No data available'))
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        size: Size(constraints.maxWidth, 180.0),
                        painter: _TrendChartPainter(trends: trends),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 12.0),
          // Hour Labels row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: trends.map((t) {
              final isPeak = _isPeak(t);
              return Expanded(
                child: Center(
                  child: Text(
                    t.hourLabel,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10.0,
                      fontWeight: isPeak ? FontWeight.bold : FontWeight.w500,
                      color: isPeak ? AppColors.primary : AppColors.onSurfaceVariant.withOpacity(0.6),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  bool _isPeak(HourlyQueueTrendEntity item) {
    if (trends.isEmpty) return false;
    final maxToday = trends.map((e) => e.todayCount).reduce(max);
    return item.todayCount == maxToday && maxToday > 0;
  }

  Widget _buildLegendItem(Color color, String label, {required bool isSolid}) {
    return Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  final List<HourlyQueueTrendEntity> trends;

  _TrendChartPainter({required this.trends});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Draw background horizontal grid lines (3 lines)
    final gridPaint = Paint()
      ..color = AppColors.outlineVariant.withOpacity(0.2)
      ..strokeWidth = 1.0;

    canvas.drawLine(const Offset(0, 10.0), Offset(width, 10.0), gridPaint);
    canvas.drawLine(Offset(0, height / 2), Offset(width, height / 2), gridPaint);
    canvas.drawLine(Offset(0, height - 10.0), Offset(width, height - 10.0), gridPaint);

    final maxVal = max(
      trends.map((e) => max(e.todayCount, e.averageCount)).reduce(max),
      10,
    ).toDouble();

    final pointsCount = trends.length;
    final stepX = width / (pointsCount - 1);

    // Calculate Today's coordinates
    final todayPoints = <Offset>[];
    final averagePoints = <Offset>[];

    for (int i = 0; i < pointsCount; i++) {
      final x = i * stepX;
      final yToday = height - 10.0 - (trends[i].todayCount / maxVal) * (height - 20.0);
      final yAvg = height - 10.0 - (trends[i].averageCount / maxVal) * (height - 20.0);
      todayPoints.add(Offset(x, yToday));
      averagePoints.add(Offset(x, yAvg));
    }

    // 1. Draw Area Gradient under Today's Trend
    final areaPath = Path()
      ..moveTo(0, height);
    
    _addSmoothPathTo(areaPath, todayPoints);
    areaPath.lineTo(width, height);
    areaPath.close();

    final gradientPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0x336100D6),
          Color(0x006100D6),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(0, 0, width, height));

    canvas.drawPath(areaPath, gradientPaint);

    // 2. Draw Average Trend Line
    final avgPaint = Paint()
      ..color = AppColors.outline.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final avgPath = Path();
    _addSmoothPathTo(avgPath, averagePoints);
    canvas.drawPath(avgPath, avgPaint);

    // 3. Draw Today's Trend Line
    final todayPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final todayPath = Path();
    _addSmoothPathTo(todayPath, todayPoints);
    canvas.drawPath(todayPath, todayPaint);

    // 4. Draw Peak Marker Circle
    final maxTodayIndex = _getPeakIndex();
    if (maxTodayIndex != -1) {
      final peakPoint = todayPoints[maxTodayIndex];
      
      final markerShadow = Paint()
        ..color = AppColors.primary.withOpacity(0.3)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(peakPoint, 6.0, markerShadow);

      final markerOuter = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.fill;
      canvas.drawCircle(peakPoint, 4.0, markerOuter);

      final markerInner = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(peakPoint, 2.0, markerInner);
    }
  }

  void _addSmoothPathTo(Path path, List<Offset> points) {
    if (points.isEmpty) return;
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final xc = (p0.dx + p1.dx) / 2;
      final yc = (p0.dy + p1.dy) / 2;
      path.quadraticBezierTo(p0.dx, p0.dy, xc, yc);
    }
    path.lineTo(points.last.dx, points.last.dy);
  }

  int _getPeakIndex() {
    if (trends.isEmpty) return -1;
    int peakIndex = 0;
    int maxVal = trends[0].todayCount;
    for (int i = 1; i < trends.length; i++) {
      if (trends[i].todayCount > maxVal) {
        maxVal = trends[i].todayCount;
        peakIndex = i;
      }
    }
    return peakIndex;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
