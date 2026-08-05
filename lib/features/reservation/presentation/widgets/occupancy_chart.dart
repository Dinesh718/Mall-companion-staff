import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/reservation_statistics_entity.dart';

class OccupancyChart extends StatelessWidget {
  final List<HourlyOccupancyEntity> occupancyData;

  const OccupancyChart({
    super.key,
    required this.occupancyData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withAlpha(12),
            blurRadius: 15.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 120.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: occupancyData.map((data) {
                final height = (data.capacityPercentage * 100).clamp(10.0, 100.0);
                final bool isPeak = data.capacityPercentage > 0.7;
                
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          height: height,
                          decoration: BoxDecoration(
                            gradient: isPeak
                                ? const LinearGradient(
                                    colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  )
                                : null,
                            color: isPeak ? null : AppColors.surfaceContainer,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          data.timeLabel,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer.withAlpha(128),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primary,
                  size: 18.0,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'Current floor at ${(occupancyData.isNotEmpty ? (occupancyData.fold<double>(0, (p, c) => p + c.capacityPercentage) / occupancyData.length) * 100 : 0).toInt()}% capacity.',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
