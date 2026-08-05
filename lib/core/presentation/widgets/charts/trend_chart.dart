import 'package:flutter/material.dart';

class TrendChart extends StatelessWidget {
  final List<double> data;
  final Color lineColor;
  final List<Color> gradientColors;
  final double height;
  final bool animate;

  const TrendChart({
    super.key,
    required this.data,
    required this.lineColor,
    required this.gradientColors,
    this.height = 150.0,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _TrendChartPainter(
          data: data,
          lineColor: lineColor,
          gradientColors: gradientColors,
        ),
      ),
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final List<Color> gradientColors;

  _TrendChartPainter({
    required this.data,
    required this.lineColor,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxData = data.reduce((a, b) => a > b ? a : b);
    final minData = data.reduce((a, b) => a < b ? a : b);
    final range = maxData - minData == 0 ? 1.0 : maxData - minData;

    final path = Path();
    final fillPath = Path();

    final stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      // Padding top and bottom by 10%
      final y = size.height - ((data[i] - minData) / range) * (size.height * 0.8) - (size.height * 0.1);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        final prevX = (i - 1) * stepX;
        final prevY = size.height - ((data[i - 1] - minData) / range) * (size.height * 0.8) - (size.height * 0.1);

        // Smooth curve
        final controlPointX = prevX + (x - prevX) / 2;
        path.cubicTo(controlPointX, prevY, controlPointX, y, x, y);
        fillPath.cubicTo(controlPointX, prevY, controlPointX, y, x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    // Draw Fill
    final paintFill = Paint()
      ..shader = LinearGradient(
        colors: gradientColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(fillPath, paintFill);

    // Draw Line
    final paintLine = Paint()
      ..color = lineColor
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paintLine);

    // Draw Last Point Dot
    final lastX = size.width;
    final lastY = size.height - ((data.last - minData) / range) * (size.height * 0.8) - (size.height * 0.1);

    final dotPaint = Paint()..color = lineColor;
    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(lastX, lastY), 6.0, dotPaint);
    canvas.drawCircle(Offset(lastX, lastY), 6.0, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
