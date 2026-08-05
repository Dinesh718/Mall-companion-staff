import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../reservation/domain/entities/timeline_event_entity.dart';

class ActivityTimeline extends StatelessWidget {
  final List<TimelineEventEntity> timeline;

  const ActivityTimeline({super.key, required this.timeline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.outlineVariant.withAlpha(76)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withAlpha(12),
            blurRadius: 15.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Activity Timeline',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 24.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: timeline.length,
            itemBuilder: (context, index) {
              final event = timeline[index];
              final isLast = index == timeline.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: 24.0,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          if (!isLast)
                            Positioned(
                              top: 16.0,
                              bottom: 0,
                              child: Container(
                                width: 2.0,
                                color: AppColors.surfaceContainer,
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.only(top: 4.0),
                            width: 16.0,
                            height: 16.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: event.isPrimary ? AppColors.primary : AppColors.outlineVariant,
                              boxShadow: event.isPrimary
                                  ? [
                                      BoxShadow(
                                        color: AppColors.primary.withAlpha(25),
                                        spreadRadius: 4.0,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              event.subtitle,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
