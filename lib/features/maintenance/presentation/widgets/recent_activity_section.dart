// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/maintenance_activity_entity.dart';

class RecentActivitySection extends StatelessWidget {
  final List<MaintenanceActivityEntity> activities;

  const RecentActivitySection({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
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
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final isLast = index == activities.length - 1;
                return _ActivityTimelineItem(
                  activity: activities[index],
                  isLast: isLast,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityTimelineItem extends StatelessWidget {
  final MaintenanceActivityEntity activity;
  final bool isLast;

  const _ActivityTimelineItem({
    required this.activity,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;
    
    if (activity.type == 'resolved') {
      iconData = Icons.check_rounded;
      iconColor = const Color(0xFF10B981); // Green
    } else {
      iconData = Icons.play_arrow_rounded;
      iconColor = const Color(0xFF8B5CF6); // Purple
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.0,
                    color: const Color(0xFFE5E7EB),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                  ),
                )
              else
                const SizedBox(height: 16.0), // Padding below the last item
            ],
          ),
          const SizedBox(width: 16.0),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    activity.subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
