import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/emergency_contact_entity.dart';

class ContactListTile extends StatelessWidget {
  final EmergencyContactEntity contact;
  final bool isLast;
  final VoidCallback onCall;

  const ContactListTile({
    super.key,
    required this.contact,
    this.isLast = false,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: AppColors.outlineVariant.withAlpha(76), // border-outline-variant/30
                  width: 1.0,
                ),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                _getIconData(contact.iconName),
                color: AppColors.onSurfaceVariant,
                size: 24.0,
              ),
              const SizedBox(width: 12.0),
              Text(
                contact.name,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0, // font-label-lg
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          Material(
            color: AppColors.primary,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onCall,
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(8.0), // p-2 -> 8px
                child: Icon(
                  Icons.call_rounded,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'shield':
        return Icons.shield_rounded;
      case 'medical_information':
        return Icons.medical_information_rounded;
      case 'help_center':
        return Icons.help_center_rounded;
      default:
        return Icons.contact_phone_rounded;
    }
  }
}
