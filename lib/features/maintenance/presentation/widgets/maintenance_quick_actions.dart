// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MaintenanceQuickActions extends StatelessWidget {
  const MaintenanceQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _QuickActionItem(
                  icon: Icons.assignment_outlined,
                  iconColor: const Color(0xFF6366F1), // Indigo
                  label: 'Assigned',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _QuickActionItem(
                  icon: Icons.error_outline_rounded,
                  iconColor: const Color(0xFFEF4444), // Red
                  label: 'High Priority',
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _QuickActionItem(
                  icon: Icons.pending_actions_rounded,
                  iconColor: const Color(0xFF3B82F6), // Blue
                  label: 'In Progress',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _QuickActionItem(
                  icon: Icons.refresh_rounded,
                  iconColor: const Color(0xFF111827), // Dark grey
                  label: 'Refresh Tickets',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: const Color(0xFFF3F4F6),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 28.0,
            ),
            const SizedBox(height: 12.0),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
