import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/charts/weekly_activity_bar_chart.dart';
import '../../../../core/themes/app_colors.dart';

class WeeklyActivityCard extends StatelessWidget {
  final List<double> weeklyActivity;

  const WeeklyActivityCard({
    super.key,
    required this.weeklyActivity,
  });

  @override
  Widget build(BuildContext context) {
    if (weeklyActivity.length != 7) return const SizedBox();

    final labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final maxIndex = weeklyActivity.indexOf(weeklyActivity.reduce((a, b) => a > b ? a : b));

    final data = List.generate(7, (index) {
      return WeeklyActivityData(
        label: labels[index],
        value: weeklyActivity[index],
        isHighlight: index == maxIndex, // highlight the day with max activity
      );
    });

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.08),
            blurRadius: 20.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Activity',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 32.0),
          WeeklyActivityBarChart(
            data: data,
            height: 128.0,
            baseColor: const Color(0xFFE0E3E5), // surface-variant
            highlightGradient: const [Color(0xFF7C3AED), Color(0xFF316BF3)], // violet-blue
          ),
        ],
      ),
    );
  }
}
