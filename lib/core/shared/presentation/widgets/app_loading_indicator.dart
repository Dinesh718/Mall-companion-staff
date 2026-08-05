import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class AppLoadingIndicator extends StatelessWidget {
  final double strokeWidth;
  final Color color;

  const AppLoadingIndicator({
    super.key,
    this.strokeWidth = 4.0,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
