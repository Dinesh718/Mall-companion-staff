import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../reservation/domain/entities/reservation_details_entity.dart';

class SpecialRequestsSection extends StatelessWidget {
  final ReservationDetailsEntity details;

  const SpecialRequestsSection({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    if (details.specialRequestTags.isEmpty) return const SizedBox.shrink();

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
          Row(
            children: [
              const Icon(
                Icons.stars_rounded,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Special Requests',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: details.specialRequestTags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(color: AppColors.outlineVariant.withAlpha(51)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getIconForTag(tag),
                      size: 20.0,
                      color: AppColors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      tag,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _getIconForTag(String tag) {
    final lowerTag = tag.toLowerCase();
    if (lowerTag.contains('window')) return Icons.window_rounded;
    if (lowerTag.contains('birthday') || lowerTag.contains('cake')) return Icons.cake_rounded;
    return Icons.star_rounded;
  }
}
