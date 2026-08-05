import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class AssignedTicketsHeader extends StatelessWidget {
  final int assignedCount;
  final int criticalCount;
  final int inProgressCount;

  const AssignedTicketsHeader({
    super.key,
    required this.assignedCount,
    required this.criticalCount,
    required this.inProgressCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 32.0,
            ),
          ),
          const SizedBox(width: 16.0),
          
          // Center Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Assigned Tickets',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  '$assignedCount Assigned • $criticalCount Critical • $inProgressCount In Progress',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // Notification Bell
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                color: AppColors.onSurfaceVariant,
                iconSize: 28.0,
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
