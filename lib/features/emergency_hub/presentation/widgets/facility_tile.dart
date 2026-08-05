import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/emergency_facility_entity.dart';

class FacilityTile extends StatelessWidget {
  final EmergencyFacilityEntity facility;
  final VoidCallback onViewOnMap;

  const FacilityTile({
    super.key,
    required this.facility,
    required this.onViewOnMap,
  });

  @override
  Widget build(BuildContext context) {
    Color iconBgColor;
    Color iconColor;

    switch (facility.name) {
      case 'First Aid Station':
        iconBgColor = AppColors.secondaryContainer;
        iconColor = AppColors.onSecondaryContainer;
        break;
      case 'Security Office':
        iconBgColor = AppColors.primaryContainer;
        iconColor = AppColors.onPrimaryContainer;
        break;
      case 'Emergency Exit':
        iconBgColor = AppColors.tertiaryContainer;
        iconColor = AppColors.onTertiaryContainer;
        break;
      default:
        iconBgColor = AppColors.surfaceVariant;
        iconColor = AppColors.onSurfaceVariant;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      _getIconData(facility.iconName),
                      color: iconColor,
                      size: 20.0,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          facility.name,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0, // label-lg
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          facility.locationDetails,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0, // text-sm
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onViewOnMap,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'View on Map',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0, // label-md
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'medical_services':
        return Icons.medical_services_rounded;
      case 'local_police':
        return Icons.local_police_rounded;
      case 'exit_to_app':
        return Icons.exit_to_app_rounded;
      default:
        return Icons.place_rounded;
    }
  }
}
