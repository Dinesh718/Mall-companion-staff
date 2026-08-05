import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_info_card.dart';
import '../../domain/entities/reservation_statistics_entity.dart';
import 'occupancy_chart.dart';

class ReservationInsightCard extends StatelessWidget {
  final ReservationStatisticsEntity statistics;

  const ReservationInsightCard({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Insights',
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: 'Inter',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        AppInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Peak Hour',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontFamily: 'Inter',
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        statistics.peakHour,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Avg Party Size',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontFamily: 'Inter',
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        statistics.averagePartySize.toStringAsFixed(1),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const Divider(color: AppColors.outlineVariant, height: 1),
              const SizedBox(height: 24.0),
              Text(
                'Hourly Occupancy',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 16.0),
              OccupancyChart(occupancyData: statistics.hourlyOccupancy),
            ],
          ),
        ),
      ],
    );
  }
}
