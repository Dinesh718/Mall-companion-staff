import 'dart:math';
import 'package:flutter/material.dart';

class PieChartData {
  final double value;
  final Color color;
  final String label;

  PieChartData({
    required this.value,
    required this.color,
    required this.label,
  });
}

class CategoryPieChart extends StatelessWidget {
  final List<PieChartData> data;
  final double strokeWidth;
  final Widget? centerWidget;

  const CategoryPieChart({
    super.key,
    required this.data,
    this.strokeWidth = 12.0,
    this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(128, 128),
          painter: _PieChartPainter(
            data: data,
            strokeWidth: strokeWidth,
          ),
        ),
        ?centerWidget,
      ],
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<PieChartData> data;
  final double strokeWidth;

  _PieChartPainter({
    required this.data,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final total = data.fold(0.0, (sum, item) => sum + item.value);
    if (total == 0) return;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    // Draw background circle
    final bgPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(rect.center, rect.width / 2, bgPaint);

    double startAngle = -pi / 2; // Start from top

    for (var item in data) {
      final sweepAngle = (item.value / total) * 2 * pi;
      
      if (item.value > 0) {
        final paint = Paint()
          ..color = item.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt; // Standard donut chart look

        canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
        
        // Add a small gap between segments
        startAngle += sweepAngle;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
