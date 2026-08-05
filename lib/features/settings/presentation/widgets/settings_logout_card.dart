import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import 'shared_settings_widgets.dart';

class SettingsLogoutCard extends StatelessWidget {
  final VoidCallback? onLogout;

  const SettingsLogoutCard({
    super.key,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: '', // No title as per design, the content handles it
      backgroundColor: AppColors.errorContainer.withAlpha(12), // 5% opacity
      border: Border.all(color: AppColors.error.withAlpha(51)), // 20% opacity
      children: [
        Center(
          child: Column(
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: AppColors.errorContainer.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout,
                  color: AppColors.error,
                  size: 24.0,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Ready to leave?',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 8.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'You can sign in again at any time to resume your shifts and ticket assignments.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Logout from this device only.',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12.0,
                  color: AppColors.onSurfaceVariant.withAlpha(153),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: onLogout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    elevation: 4.0,
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
