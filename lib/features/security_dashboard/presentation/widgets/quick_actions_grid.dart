import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.1,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12.0),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.1, // Adjusted based on design
          children: [
            _buildActionCard(
              icon: Icons.assignment_outlined,
              iconColor: AppColors.primary,
              iconBgColor: AppColors.primary.withAlpha(25),
              title: 'View Incidents',
              badgeText: '3 Active',
              badgeColor: AppColors.primary,
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.emergency_share_outlined,
              iconColor: AppColors.error,
              iconBgColor: AppColors.error.withAlpha(25),
              title: 'Emergency Resp.',
              badgeText: '1 Pending',
              badgeColor: AppColors.error,
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.map_outlined,
              iconColor: AppColors.secondary,
              iconBgColor: AppColors.secondary.withAlpha(25),
              title: 'Patrol Route',
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.verified_user_outlined,
              iconColor: AppColors.tertiary,
              iconBgColor: AppColors.tertiary.withAlpha(25),
              title: 'Visitor Verify',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required VoidCallback onTap,
    String? badgeText,
    Color? badgeColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest, // roughly surface-container-high
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppColors.surfaceVariant),
          ),
          child: Stack(
            children: [
              if (badgeText != null && badgeColor != null)
                Positioned(
                  top: 12.0,
                  right: 12.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: iconColor, size: 32.0),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
