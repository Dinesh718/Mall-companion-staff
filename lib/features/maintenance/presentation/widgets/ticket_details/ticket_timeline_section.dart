import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../reservation/domain/entities/timeline_event_entity.dart';

class TicketTimelineSection extends StatelessWidget {
  final List<TimelineEventEntity> timeline;

  const TicketTimelineSection({super.key, required this.timeline});

  @override
  Widget build(BuildContext context) {
    if (timeline.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Timeline',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
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
              final isFirst = index == 0;

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
                              top: 24.0,
                              bottom: -24.0,
                              child: Container(
                                width: 2.0,
                                color: AppColors.outlineVariant,
                              ),
                            ),
                          Positioned(
                            top: 6.0,
                            child: Container(
                              width: 16.0,
                              height: 16.0,
                              decoration: BoxDecoration(
                                color: isFirst ? AppColors.primary : AppColors.primary.withValues(alpha: 0.4),
                                shape: BoxShape.circle,
                                boxShadow: isFirst
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primary.withValues(alpha: 0.1),
                                          spreadRadius: 4,
                                        )
                                      ]
                                    : null,
                              ),
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
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14.0,
                                fontWeight: isFirst ? FontWeight.bold : FontWeight.w500,
                                color: isFirst ? AppColors.onSurface : AppColors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              event.subtitle,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                color: isFirst ? AppColors.onSurfaceVariant : AppColors.onSurfaceVariant.withValues(alpha: 0.7),
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
