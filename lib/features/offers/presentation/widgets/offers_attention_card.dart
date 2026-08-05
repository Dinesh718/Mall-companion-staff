// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class OffersAttentionCard extends StatelessWidget {
  const OffersAttentionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                'Requires Attention',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textNavy,
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(99.0),
                ),
                child: const Text(
                  '2 ALERTS',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Alert 1 (Amber)
          _buildAlertCard(
            context: context,
            icon: Icons.warning_amber_rounded,
            title: 'Expires Tomorrow',
            subtitle: 'Weekend Flash Sale (Nike Flagship)',
            actionText: 'Extend',
            cardBgColor: const Color(0xFFFFFBEB).withOpacity(0.5), // amber-50/50
            iconBgColor: const Color(0xFFFEF3C7), // amber-100
            iconColor: const Color(0xFFD97706), // amber-600
            textColor: const Color(0xFF92400E), // amber-800
          ),
          const SizedBox(height: 12.0),

          // Alert 2 (Blue)
          _buildAlertCard(
            context: context,
            icon: Icons.pending_actions_rounded,
            title: 'Awaiting Publication',
            subtitle: 'Back to School Campaign v2',
            actionText: 'Publish',
            cardBgColor: const Color(0xFFEFF6FF).withOpacity(0.5), // blue-50/50
            iconBgColor: const Color(0xFFDBEAFE), // blue-100
            iconColor: const Color(0xFF2563EB), // blue-600
            textColor: const Color(0xFF1E40AF), // blue-800
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required Color cardBgColor,
    required Color iconBgColor,
    required Color iconColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: iconColor.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.02),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Action "$actionText" clicked (mock)'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text(
              actionText,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
