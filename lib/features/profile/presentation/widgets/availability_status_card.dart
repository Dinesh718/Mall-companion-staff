import 'package:flutter/material.dart';
import '../../domain/entities/profile_entity.dart';
import '../../../../core/themes/app_colors.dart';

class AvailabilityStatusCard extends StatelessWidget {
  final ProfileEntity profile;

  const AvailabilityStatusCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(37, 99, 235, 0.08),
            blurRadius: 15.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CURRENT STATUS',
                style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.05,
                  color: Color(0xFF4A4455), // on-surface-variant
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7), // green-100
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Text(
                  '🟢 On Duty',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF15803D), // green-700
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _buildInfoRow(
            icon: Icons.calendar_today,
            iconColor: AppColors.primary,
            iconBg: AppColors.primaryFixed,
            label: "Today's Schedule",
            value: profile.currentTask,
          ),
          const SizedBox(height: 12.0),
          _buildInfoRow(
            icon: Icons.schedule,
            iconColor: AppColors.secondary,
            iconBg: AppColors.secondaryFixed,
            label: "Shift Hours",
            value: profile.shiftHours,
          ),
          const SizedBox(height: 12.0),
          _buildInfoRow(
            icon: Icons.assignment,
            iconColor: AppColors.primary,
            iconBg: AppColors.primaryFixed,
            label: "Assigned Tickets",
            value: profile.activeTicketsCount.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Icon(icon, color: iconColor, size: 20.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.05,
                  color: Color(0xFF4A4455),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1E), // on-surface
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
