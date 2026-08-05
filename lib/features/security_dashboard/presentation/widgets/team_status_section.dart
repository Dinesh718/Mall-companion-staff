import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/security_dashboard_entity.dart';

class TeamStatusSection extends StatelessWidget {
  final TeamStatusEntity teamStatus;

  const TeamStatusSection({
    super.key,
    required this.teamStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Team Status',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: _buildStatusCard(
                value: teamStatus.available.toString().padLeft(2, '0'),
                label: 'Available',
                valueColor: AppColors.secondary,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _buildStatusCard(
                value: teamStatus.responding.toString().padLeft(2, '0'),
                label: 'Responding',
                valueColor: AppColors.primary,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _buildStatusCard(
                value: teamStatus.offDuty.toString().padLeft(2, '0'),
                label: 'Off Duty',
                valueColor: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusCard({
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.surfaceVariant),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 4.0),
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
    );
  }
}
