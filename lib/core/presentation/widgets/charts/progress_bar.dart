import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final Color trackColor;
  final Color progressColor;
  final double height;

  const ProgressBar({
    super.key,
    required this.value,
    required this.trackColor,
    required this.progressColor,
    this.height = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                width: constraints.maxWidth * value.clamp(0.0, 1.0),
                height: height,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
