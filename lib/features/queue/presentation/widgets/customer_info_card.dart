// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_entity.dart';

class CustomerInfoCard extends StatelessWidget {
  final QueueEntity queueItem;

  const CustomerInfoCard({
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
                'Customer Information',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              Icon(
                Icons.person_rounded,
                color: AppColors.onSurfaceVariant.withOpacity(0.7),
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          // Profile row
          Row(
            children: [
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.3),
                    width: 2.0,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  queueItem.avatarUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.account_circle_rounded,
                    size: 60.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      queueItem.customerName,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.primary,
                            size: 14.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            'LOYALTY MEMBER',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 9.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          // Info Rows
          _buildInfoRow('Phone', queueItem.phoneNumber, isBlue: true),
          _buildInfoRow('Party Size', '${queueItem.partySize} Guests'),
          _buildInfoRow(
            'Contact Preference',
            queueItem.contactPreference ?? 'SMS',
            icon: Icons.sms_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBlue = false, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.outlineVariant.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16.0,
                  color: AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 6.0),
              ],
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: isBlue ? AppColors.secondary : AppColors.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
