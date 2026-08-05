import 'package:flutter/material.dart';
import '../../domain/entities/profile_entity.dart';
import '../../../../core/themes/app_colors.dart';

class DocumentsCard extends StatelessWidget {
  final ProfileEntity profile;

  const DocumentsCard({
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
            'Documents',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16.0),
          ...profile.documents.map((doc) => _buildDocumentTile(doc)),
        ],
      ),
    );
  }

  Widget _buildDocumentTile(dynamic doc) {
    // Assuming doc has title, iconName, and isVerified.
    // Map iconName string to IconData roughly.
    IconData iconData = Icons.insert_drive_file;
    if (doc.iconName == 'badge') iconData = Icons.badge;
    if (doc.iconName == 'verified_user') iconData = Icons.verified_user;
    if (doc.iconName == 'school') iconData = Icons.school;

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F6), // surface-container-low
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconData, color: AppColors.primary, size: 24.0),
              const SizedBox(width: 12.0),
              Text(
                doc.title,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1E),
                ),
              ),
            ],
          ),
          if (doc.isVerified)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7), // green-100
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Text(
                'VERIFIED',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF15803D), // green-700
                ),
              ),
            ),
        ],
      ),
    );
  }
}
