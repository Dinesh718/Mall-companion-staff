import 'package:flutter/material.dart';
import '../../domain/entities/milestone_entity.dart';
import '../../../../core/themes/app_colors.dart';

class RecentMilestonesCard extends StatelessWidget {
  final List<MilestoneEntity> milestones;

  const RecentMilestonesCard({
    super.key,
    required this.milestones,
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
            'Recent Milestones',
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
            itemCount: milestones.length,
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  height: 1.0,
                  color: const Color(0xFFE0E3E5).withValues(alpha: 0.5), // divider
                ),
              );
            },
            itemBuilder: (context, index) {
              final item = milestones[index];
              return Row(
                children: [
                  Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: Color(int.parse('0xFF${item.iconBgHex}')),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getIconData(item.iconName),
                      color: Color(int.parse('0xFF${item.iconColorHex}')),
                      size: 24.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12.0,
                            color: AppColors.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'military_tech':
        return Icons.military_tech_rounded;
      case 'emoji_events':
        return Icons.emoji_events_rounded;
      case 'schedule':
        return Icons.schedule_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}
