// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_entity.dart';

class QueueInfoCard extends StatelessWidget {
  final QueueEntity queueItem;

  const QueueInfoCard({
    super.key,
    required this.queueItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Queue Information',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              Icon(
                Icons.assignment_outlined,
                color: AppColors.onSurfaceVariant.withOpacity(0.7),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          // Details List
          _buildItem(
            Icons.format_list_numbered_rounded,
            'Position',
            _getPositionString(queueItem.position ?? 4),
          ),
          _buildItem(
            Icons.directions_walk_rounded,
            'Service Type',
            queueItem.serviceType ?? 'Walk-in',
          ),
          _buildItem(
            Icons.verified_rounded,
            'Priority',
            queueItem.priority ?? 'Standard',
          ),
          _buildItem(
            Icons.token_rounded,
            'Token',
            queueItem.token,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: AppColors.outlineVariant.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getPositionString(int pos) {
    switch (pos) {
      case 1:
        return '1st in line';
      case 2:
        return '2nd in line';
      case 3:
        return '3rd in line';
      default:
        return '${pos}th in line';
    }
  }
}
