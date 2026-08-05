import 'package:flutter/material.dart';
import '../../domain/entities/resolution_time_entity.dart';
import '../../../../core/presentation/widgets/charts/progress_bar.dart';
import '../../../../core/themes/app_colors.dart';

class ResolutionTimeAnalysisCard extends StatelessWidget {
  final List<ResolutionTimeEntity> resolutionTimes;

  const ResolutionTimeAnalysisCard({
    super.key,
    required this.resolutionTimes,
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
          const Text(
            'Resolution Time Analysis',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 24.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: resolutionTimes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
            itemBuilder: (context, index) {
              final item = resolutionTimes[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.categoryName,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onSurface,
                        ),
                      ),
                      Text(
                        '${item.averageTimeMinutes}m',
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C3AED), // primary
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  ProgressBar(
                    value: item.percentage,
                    trackColor: const Color(0xFFE0E3E5), // surface-variant
                    progressColor: Color(int.parse('0xFF${item.colorHex}')),
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
