// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class OffersRecentActivity extends StatelessWidget {
  const OffersRecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textNavy,
            ),
          ),
          const SizedBox(height: 16.0),

          // Timeline Container Card
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: AppColors.outlineVariant.withOpacity(0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1F2937).withOpacity(0.03),
                  blurRadius: 16.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Vertical line timeline indicator
                Positioned(
                  left: 20.0,
                  top: 20.0,
                  bottom: 20.0,
                  width: 2.0,
                  child: Container(
                    color: const Color(0xFFDEE8FF), // surface-container-high
                  ),
                ),

                // List of items
                Column(
                  children: [
                    _buildActivityItem(
                      icon: Icons.add_circle_outline_rounded,
                      iconColor: AppColors.primary,
                      iconBgColor: AppColors.primary.withOpacity(0.08),
                      title: 'Offer Created',
                      description: 'New Seasonal Collection Launch',
                      timeAgo: '2h ago',
                      subDetails: 'Status: Draft • By: Sarah Jenkins',
                      hasDivider: true,
                    ),
                    const SizedBox(height: 16.0),
                    _buildActivityItem(
                      icon: Icons.check_circle_outline_rounded,
                      iconColor: const Color(0xFF22C55E),
                      iconBgColor: const Color(0xFFECFDF5),
                      title: 'Campaign Activated',
                      description: 'Weekend Flash Sale',
                      timeAgo: '5h ago',
                      subDetails: 'Now visible to all app users in "Luxury" segment.',
                      hasDivider: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String description,
    required String timeAgo,
    required String subDetails,
    required bool hasDivider,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Dot icon container
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3.0,
            ),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20.0,
          ),
        ),
        const SizedBox(width: 16.0),

        // Activity Details
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: hasDivider ? 16.0 : 0.0),
            decoration: BoxDecoration(
              border: hasDivider
                  ? Border(
                      bottom: BorderSide(
                        color: AppColors.outlineVariant.withOpacity(0.2),
                        width: 1.0,
                      ),
                    )
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            color: AppColors.onSurface,
                          ),
                          children: [
                            TextSpan(
                              text: '$title: ',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: description),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      timeAgo,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  subDetails,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
