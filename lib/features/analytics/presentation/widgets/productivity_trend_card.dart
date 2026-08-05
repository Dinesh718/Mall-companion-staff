import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/charts/trend_chart.dart';
import '../../../../core/themes/app_colors.dart';

class ProductivityTrendCard extends StatelessWidget {
  final List<double> trendData;

  const ProductivityTrendCard({
    super.key,
    required this.trendData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Productivity Trend',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'CURRENT MONTH',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.05,
                      color: AppColors.outline,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.trending_up_rounded,
                    color: Color(0xFF0051D5), // secondary
                    size: 16.0,
                  ),
                  const SizedBox(width: 4.0),
                  const Text(
                    '12%',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0051D5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          TrendChart(
            data: trendData,
            lineColor: const Color(0xFF7C3AED), // primary
            gradientColors: [
              const Color(0xFF7C3AED).withValues(alpha: 0.2),
              const Color(0xFF7C3AED).withValues(alpha: 0.0),
            ],
            height: 150.0,
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildXAxisLabel('WEEK 1'),
              _buildXAxisLabel('WEEK 2'),
              _buildXAxisLabel('WEEK 3'),
              _buildXAxisLabel('CURRENT'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildXAxisLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Work Sans',
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        color: AppColors.outline,
      ),
    );
  }
}
