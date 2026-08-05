import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  final Widget child;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final bool isVisible;

  const AppBadge({
    super.key,
    required this.child,
    required this.label,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible || label.isEmpty) return child;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -4.0,
          right: -4.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 16.0,
              minHeight: 16.0,
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
