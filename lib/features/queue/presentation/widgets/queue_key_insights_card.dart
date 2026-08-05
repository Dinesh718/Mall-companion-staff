// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/insight_entity.dart';
import '../../../../core/themes/app_colors.dart';

class QueueKeyInsightsCard extends StatelessWidget {
  final List<InsightEntity> insights;

  const QueueKeyInsightsCard({
    super.key,
    required this.insights,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Key Insights',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textNavy,
            ),
          ),
          const SizedBox(height: 20.0),
          ...insights.map((insight) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  // Left color bar indicator
                  Container(
                    width: 4.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Color(int.parse('0xFF${insight.colorHex}')),
                      borderRadius: BorderRadius.circular(99.0),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  // Icon
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F3FF),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      _getIcon(insight.type),
                      color: Color(int.parse('0xFF${insight.colorHex}')),
                      size: 18.0,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  // Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          insight.title,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textNavy,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          insight.description,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            color: AppColors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type.toLowerCase()) {
      case 'peak_activity':
        return Icons.schedule_rounded;
      case 'wait_improvement':
        return Icons.bolt_rounded;
      case 'vip_handling':
        return Icons.star_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }
}
