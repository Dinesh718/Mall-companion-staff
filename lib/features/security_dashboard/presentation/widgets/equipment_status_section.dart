import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/security_dashboard_entity.dart';

class EquipmentStatusSection extends StatelessWidget {
  final EquipmentStatusEntity equipmentStatus;

  const EquipmentStatusSection({
    super.key,
    required this.equipmentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Equipment Status',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppColors.surfaceVariant),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildEquipmentItem(
                  'Radio',
                  equipmentStatus.isRadioActive,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _buildEquipmentItem(
                  'Body Cam',
                  equipmentStatus.isBodyCamActive,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _buildEquipmentItem(
                  'GPS',
                  equipmentStatus.isGpsActive,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentItem(String name, bool isActive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: isActive ? Colors.green : AppColors.error,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Text(
              isActive ? 'Active' : 'Inactive',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
