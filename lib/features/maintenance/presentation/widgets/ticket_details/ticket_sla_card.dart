import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../maintenance/domain/entities/ticket_details_entity.dart';

class TicketSlaCard extends StatelessWidget {
  final TicketSlaEntity sla;

  const TicketSlaCard({super.key, required this.sla});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSlaItem(
            icon: Icons.access_time_rounded,
            label: 'Reported',
            value: sla.reportedTime,
          ),
          Container(
            height: 40.0,
            width: 1.0,
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
          _buildSlaItem(
            icon: Icons.flag_rounded,
            label: 'Due By',
            value: sla.dueTime,
          ),
          Container(
            height: 40.0,
            width: 1.0,
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
          _buildSlaItem(
            icon: Icons.timer_outlined,
            label: 'Time Left',
            value: sla.timeRemaining,
            isHighlight: true,
            isBreached: sla.isBreached,
          ),
        ],
      ),
    );
  }

  Widget _buildSlaItem({
    required IconData icon,
    required String label,
    required String value,
    bool isHighlight = false,
    bool isBreached = false,
  }) {
    final valueColor = isHighlight
        ? (isBreached ? AppColors.error : AppColors.primary)
        : AppColors.onSurface;

    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 14.0,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(width: 4.0),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
