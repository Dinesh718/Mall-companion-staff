// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_timeline_step_entity.dart';
import '../../domain/entities/queue_timeline_step_status.dart';

class QueueTimelineWidget extends StatelessWidget {
  final List<QueueTimelineStepEntity> steps;

  const QueueTimelineWidget({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        // Vertical Timeline Line
        Positioned(
          left: 22.0,
          top: 12.0,
          bottom: 12.0,
          child: Container(
            width: 2.0,
            color: AppColors.outlineVariant.withOpacity(0.3),
          ),
        ),

        // Timeline steps list
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: steps.length,
          separatorBuilder: (context, index) => const SizedBox(height: 32.0),
          itemBuilder: (context, index) {
            final step = steps[index];
            return _TimelineStepRow(step: step);
          },
        ),
      ],
    );
  }
}

class _TimelineStepRow extends StatelessWidget {
  final QueueTimelineStepEntity step;

  const _TimelineStepRow({required this.step});

  @override
  Widget build(BuildContext context) {
    final double opacity = step.status == QueueTimelineStepStatus.future ? 0.4 : 1.0;

    return Opacity(
      opacity: opacity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Timeline Indicator Circle
          _buildIndicatorCircle(),
          const SizedBox(width: 20.0),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  step.title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: step.status == QueueTimelineStepStatus.current
                        ? FontWeight.bold
                        : FontWeight.w600,
                    color: step.status == QueueTimelineStepStatus.current
                        ? AppColors.primary
                        : AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  step.subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorCircle() {
    switch (step.status) {
      case QueueTimelineStepStatus.completed:
        return Container(
          width: 44.0,
          height: 44.0,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 20.0,
          ),
        );

      case QueueTimelineStepStatus.current:
        return Stack(
          alignment: Alignment.center,
          children: [
            // Glow Effect
            Container(
              width: 52.0,
              height: 52.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryGradientStart.withOpacity(0.2),
                    AppColors.primaryGradientEnd.withOpacity(0.2),
                  ],
                ),
              ),
            ),
            // Main Active Gradient Circle
            Container(
              width: 44.0,
              height: 44.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.hourglass_empty_rounded,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ],
        );

      case QueueTimelineStepStatus.future:
        return Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.outlineVariant,
              width: 2.0,
            ),
          ),
          child: const Icon(
            Icons.radio_button_unchecked_rounded,
            color: AppColors.onSurfaceVariant,
            size: 20.0,
          ),
        );
    }
  }
}
