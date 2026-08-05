import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import 'shared_settings_widgets.dart';

class SettingsActionGrid extends StatelessWidget {
  const SettingsActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'Help & Support',
      children: [
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          children: [
            _buildActionCard(
              context,
              icon: Icons.help_outline,
              label: 'Help Center',
              onTap: () {},
            ),
            _buildActionCard(
              context,
              icon: Icons.support_agent,
              label: 'Contact Admin',
              onTap: () {},
            ),
            _buildActionCard(
              context,
              icon: Icons.report_problem_outlined,
              label: 'Report Issue',
              onTap: () {},
            ),
            _buildActionCard(
              context,
              icon: Icons.rate_review_outlined,
              label: 'Feedback',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 28.0),
            const SizedBox(height: 8.0),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
