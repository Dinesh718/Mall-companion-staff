import 'package:flutter/material.dart';
import '../../domain/entities/profile_entity.dart';
import '../../../../core/themes/app_colors.dart';

class EmergencyInfoCard extends StatelessWidget {
  final ProfileEntity profile;

  const EmergencyInfoCard({
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
          const Text(
            'Emergency Information',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFFBA1A1A), // error color
            ),
          ),
          const SizedBox(height: 16.0),
          _buildInfoRow('Blood Group', profile.contact.bloodGroup, hasBorder: true),
          _buildInfoRow('Emergency Contact', profile.contact.emergencyContactName, hasBorder: true),
          _buildInfoRow(
            'First Aid Certified', 
            profile.contact.isFirstAidCertified ? 'Yes' : 'No', 
            hasBorder: false, 
            valueColor: profile.contact.isFirstAidCertified ? const Color(0xFF16A34A) : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {required bool hasBorder, Color? valueColor}) {
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
              color: valueColor ?? const Color(0xFF191C1E),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthorizedEquipmentCard extends StatelessWidget {
  final ProfileEntity profile;

  const AuthorizedEquipmentCard({
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
          const Text(
            'Authorized Equipment',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: profile.assignment.authorizedEquipment.map((equipment) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: AppColors.secondaryFixed,
                  borderRadius: BorderRadius.circular(9999.0),
                  border: Border.all(color: AppColors.secondary.withAlpha(25)),
                ),
                child: Text(
                  equipment,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
