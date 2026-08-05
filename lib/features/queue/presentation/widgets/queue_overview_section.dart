// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_summary_entity.dart';

class QueueOverviewSection extends StatelessWidget {
  final QueueSummaryEntity summary;

  const QueueOverviewSection({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Queue Overview',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 2.0),
          const Text(
            'Real-time customer flow metrics',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16.0),

          // 2x2 Grid of overview metrics cards
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - 12.0) / 2;
              return Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  _OverviewCard(
                    width: cardWidth,
                    icon: Icons.person_rounded,
                    iconColor: AppColors.darkBlue,
                    iconBgColor: AppColors.darkBlue.withOpacity(0.1),
                    value: '${summary.waitingCount}',
                    label: 'Waiting',
                    trendText: '8%',
                    trendIcon: Icons.trending_up_rounded,
                    trendColor: AppColors.darkBlue,
                    subLabel: '+5 today',
                  ),
                  _OverviewCard(
                    width: cardWidth,
                    icon: Icons.restaurant_rounded,
                    iconColor: const Color(0xFF10B981),
                    iconBgColor: const Color(0xFF10B981).withOpacity(0.1),
                    value: '${summary.servingCount}',
                    label: 'Serving',
                    trendText: '2%',
                    trendIcon: Icons.trending_down_rounded,
                    trendColor: const Color(0xFF10B981),
                    subLabel: null,
                  ),
                  _OverviewCard(
                    width: cardWidth,
                    icon: Icons.verified_rounded,
                    iconColor: AppColors.primary,
                    iconBgColor: AppColors.primary.withOpacity(0.1),
                    value: '${summary.completedCount}',
                    label: 'Completed',
                    trendText: '14%',
                    trendIcon: Icons.trending_up_rounded,
                    trendColor: AppColors.primary,
                    subLabel: '+12 today',
                  ),
                  _OverviewCard(
                    width: cardWidth,
                    icon: Icons.cancel_rounded,
                    iconColor: AppColors.error,
                    iconBgColor: AppColors.error.withOpacity(0.1),
                    value: '${summary.cancelledCount}',
                    label: 'Cancelled',
                    trendText: '0%',
                    trendIcon: Icons.trending_flat_rounded,
                    trendColor: AppColors.error,
                    subLabel: null,
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

class _OverviewCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String value;
  final String label;
  final String trendText;
  final IconData trendIcon;
  final Color trendColor;
  final String? subLabel;

  const _OverviewCard({
    required this.width,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.value,
    required this.label,
    required this.trendText,
    required this.trendIcon,
    required this.trendColor,
    this.subLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 144.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Row: Icon and Trend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trendIcon,
                        size: 14.0,
                        color: trendColor,
                      ),
                      const SizedBox(width: 2.0),
                      Text(
                        trendText,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: trendColor,
                        ),
                      ),
                    ],
                  ),
                  if (subLabel != null) ...[
                    const SizedBox(height: 2.0),
                    Text(
                      subLabel!,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),

          // Bottom Row: Value and Label
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
