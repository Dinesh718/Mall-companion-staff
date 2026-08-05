import 'package:flutter/material.dart';
import '../../domain/entities/profile_entity.dart';
import '../../../../core/themes/app_colors.dart';

class ContactInfoCard extends StatelessWidget {
  final ProfileEntity profile;

  const ContactInfoCard({
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
            'Contact Information',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildContactRow(Icons.call, 'MOBILE', profile.contact.phone),
          const SizedBox(height: 16.0),
          _buildContactRow(Icons.mail, 'EMAIL', profile.contact.email),
          const SizedBox(height: 16.0),
          _buildContactRow(
            Icons.contact_emergency,
            'EMERGENCY CONTACT',
            profile.contact.emergencyContactName,
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF4A4455), size: 24.0),
        const SizedBox(width: 16.0),
        Column(
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
                fontWeight: FontWeight.bold,
                color: Color(0xFF191C1E),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
