import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/assistance_service_entity.dart';

class AssistanceServiceCard extends StatelessWidget {
  final AssistanceServiceEntity service;
  final VoidCallback onTap;

  const AssistanceServiceCard({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      borderRadius: 8.0, // rounded-lg
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // p-4
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getIconData(service.iconName),
                          color: AppColors.secondary,
                          size: 24.0,
                        ),
                        const SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.title,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0, // label-md
                                fontWeight: FontWeight.w600, // semibold
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              service.subtitle,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10.0,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 16.0),
                    Row(
                      children: [
                        if (service.badgeText.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              service.badgeText,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 8.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onPrimaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4.0),
                        ],
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.onSurfaceVariant,
                          size: 20.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'child_care':
        return Icons.child_care_rounded;
      case 'support_agent':
        return Icons.support_agent_rounded;
      case 'info':
        return Icons.info_outline_rounded;
      case 'accessible':
        return Icons.accessible_rounded;
      default:
        return Icons.help_outline;
    }
  }
}
