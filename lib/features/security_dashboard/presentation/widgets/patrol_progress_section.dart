import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/security_dashboard_entity.dart';

class PatrolProgressSection extends StatelessWidget {
  final PatrolProgressEntity patrolProgress;

  const PatrolProgressSection({
    super.key,
    required this.patrolProgress,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercentage = patrolProgress.progressPercentage;
    final formattedETA = DateFormat('HH:mm').format(patrolProgress.estimatedCompletionTime);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.surfaceVariant),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.route,
                    color: AppColors.primary,
                    size: 24.0,
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    'Today\'s Patrol',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              Text(
                'ETA End: $formattedETA',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            height: 12.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      width: constraints.maxWidth * (progressPercentage / 100),
                      height: 12.0,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${patrolProgress.completedCheckpoints} of ${patrolProgress.totalCheckpoints} Checkpoints completed',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                '${progressPercentage.toInt()}%',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.only(top: 12.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.surfaceVariant.withAlpha(128)),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                  size: 18.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurface,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Next Checkpoint: ',
                          style: TextStyle(color: AppColors.onSurfaceVariant),
                        ),
                        TextSpan(text: patrolProgress.nextCheckpoint),
                      ],
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
