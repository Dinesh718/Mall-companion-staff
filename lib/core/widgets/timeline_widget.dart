import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class TimelineNodeData {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isCurrent;

  const TimelineNodeData({
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.isCurrent = false,
  });
}

class TimelineWidget extends StatelessWidget {
  final String header;
  final List<TimelineNodeData> nodes;

  const TimelineWidget({
    super.key,
    required this.header,
    required this.nodes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.outlineVariant.withAlpha(51)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 4.0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 22.0, // title-lg
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: AppColors.surfaceVariant,
                    width: 2.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0), // equivalent to ml-3 + padding
                child: Column(
                  children: List.generate(nodes.length, (index) {
                    final node = nodes[index];
                    final isLast = index == nodes.length - 1;
                    
                    Color dotColor = AppColors.surfaceVariant;
                    if (node.isCurrent) {
                      dotColor = AppColors.primary;
                    }

                    return Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 24.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Dot
                          Positioned(
                            left: -29.0, // align over border
                            top: 2.0,
                            child: Container(
                              width: 16.0,
                              height: 16.0,
                              decoration: BoxDecoration(
                                color: dotColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.surface, width: 2.0),
                              ),
                            ),
                          ),
                          // Content
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                node.title,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16.0,
                                  fontWeight: node.isCurrent ? FontWeight.w500 : FontWeight.w400,
                                  color: AppColors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                node.subtitle,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.outline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
