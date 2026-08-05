import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/emergency_guideline_entity.dart';

class GuidelineGrid extends StatelessWidget {
  final List<EmergencyGuidelineEntity> guidelines;

  const GuidelineGrid({
    super.key,
    required this.guidelines,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16.0),
      borderRadius: 12.0, // rounded-xl
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 3.5, // roughly matches the height needed
        ),
        itemCount: guidelines.length,
        itemBuilder: (context, index) {
          final guideline = guidelines[index];
          return Row(
            children: [
              Icon(
                _getIconData(guideline.iconName),
                color: AppColors.primary,
                size: 20.0, // text-sm size approx for icon
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  guideline.title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0, // text-sm
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'spa':
        return Icons.spa_rounded;
      case 'record_voice_over':
        return Icons.record_voice_over_rounded;
      case 'no_transportation':
        return Icons.no_transfer_rounded; // close match to no_transportation
      case 'directions_run':
        return Icons.directions_run_rounded;
      default:
        return Icons.info_outline;
    }
  }
}
