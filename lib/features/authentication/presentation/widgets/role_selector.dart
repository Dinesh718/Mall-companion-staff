// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class RoleSelector extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String> onRoleChanged;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final roles = [
      _RoleItem('Admin', Icons.admin_panel_settings_rounded),
      _RoleItem('Security', Icons.security_rounded),
      _RoleItem('Maint.', Icons.construction_rounded),
      _RoleItem('Store', Icons.storefront_rounded),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Access Role',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: roles.map((role) {
                final isActive = selectedRole == role.name;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Material(
                    color: isActive ? AppColors.primaryContainer : Colors.transparent,
                    borderRadius: BorderRadius.circular(9999.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(9999.0),
                      onTap: () => onRoleChanged(role.name),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999.0),
                          border: isActive
                              ? Border.all(
                                  color: AppColors.primary.withOpacity(0.1),
                                  width: 2.0,
                                )
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              role.icon,
                              size: 18.0,
                              color: isActive
                                  ? AppColors.onPrimaryContainer
                                  : AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              role.name,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14.0,
                                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                                color: isActive
                                    ? AppColors.onPrimaryContainer
                                    : AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _RoleItem {
  final String name;
  final IconData icon;

  _RoleItem(this.name, this.icon);
}
