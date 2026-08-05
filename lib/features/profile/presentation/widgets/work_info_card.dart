import 'package:flutter/material.dart';
import '../../domain/entities/profile_entity.dart';
import '../../../../core/themes/app_colors.dart';

class WorkInfoCard extends StatelessWidget {
  final ProfileEntity profile;

  const WorkInfoCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final assignment = profile.assignment;
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
          const Text(
            'Work Information',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildInfoRow('Assigned Mall', assignment.mall, hasBorder: true),
          _buildInfoRow('Assigned Zone', assignment.zone, hasBorder: true),
          _buildInfoRow('Department', assignment.department, hasBorder: true),
          _buildInfoRow('Reporting Manager', assignment.reportingManager, hasBorder: true),
          _buildInfoRow('Employment Type', assignment.employmentType, hasBorder: false, isPrimary: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {required bool hasBorder, bool isPrimary = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: hasBorder
            ? const Border(
                bottom: BorderSide(
                  color: Color(0xFFECEEF0), // surface-container
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14.0,
              color: Color(0xFF4A4455), // on-surface-variant
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: isPrimary ? AppColors.primary : const Color(0xFF191C1E),
            ),
          ),
        ],
      ),
    );
  }
}
