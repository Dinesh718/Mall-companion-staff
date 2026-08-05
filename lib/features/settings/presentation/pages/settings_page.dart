import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../widgets/settings_hero_card.dart';
import '../widgets/settings_action_grid.dart';
import '../widgets/settings_logout_card.dart';
import '../widgets/shared_settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(const LoadSettingsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.stitchBackground,
      appBar: AppBar(
        backgroundColor: AppColors.stitchBackground,
        elevation: 0,
        scrolledUnderElevation: 4.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            Text(
              'MAINTENANCE STAFF',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.primary),
            onPressed: () {},
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading || state is SettingsInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is SettingsError) {
            return _buildErrorState(context, state.message);
          } else if (state is SettingsLoaded) {
            final settings = state.settings;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<SettingsBloc>().add(const RefreshSettingsRequested());
              },
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.all(20.0), // container-padding
                  child: Column(
                    children: [
                      SettingsHeroCard(
                        accountSummary: settings.accountSummary,
                        onViewProfile: () {
                          // TODO: Navigate to Profile
                        },
                      ),
                      
                      SettingsSectionCard(
                        title: 'Notifications',
                        children: [
                          const SettingsSectionSubHeader(title: 'General'),
                          SettingsSwitchTile(
                            title: 'Push Notifications',
                            value: settings.notificationPreferences.pushNotifications,
                            onChanged: (val) {},
                          ),
                          SettingsSwitchTile(
                            title: 'Maintenance Reminders',
                            value: settings.notificationPreferences.maintenanceReminders,
                            onChanged: (val) {},
                          ),
                          const Divider(color: AppColors.outlineVariant, height: 32.0),
                          const SettingsSectionSubHeader(title: 'Operational'),
                          SettingsSwitchTile(
                            title: 'Ticket Assignment Alerts',
                            value: settings.notificationPreferences.ticketAssignmentAlerts,
                            onChanged: (val) {},
                          ),
                          SettingsSwitchTile(
                            title: 'Emergency Alerts',
                            value: settings.notificationPreferences.emergencyAlerts,
                            onChanged: (val) {},
                          ),
                        ],
                      ),
                      
                      SettingsSectionCard(
                        title: 'Security & Privacy',
                        children: [
                          SettingsNavigationTile(
                            icon: Icons.lock,
                            title: 'Change Password',
                            onTap: () {},
                          ),
                          SettingsNavigationTile(
                            icon: Icons.fingerprint,
                            title: 'Biometric Login',
                            onTap: () {},
                          ),
                          SettingsNavigationTile(
                            icon: Icons.gavel,
                            title: 'Privacy Policy',
                            onTap: () {},
                          ),
                          SettingsNavigationTile(
                            icon: Icons.description,
                            title: 'Terms & Conditions',
                            onTap: () {},
                          ),
                          SettingsValueTile(
                            title: 'Two-Factor Authentication',
                            value: '',
                            customValueWidget: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: const Text(
                                'COMING SOON',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SettingsSectionCard(
                        title: 'App Preferences',
                        children: [
                          SettingsValueTile(
                            title: 'Language',
                            value: '',
                            customValueWidget: _buildPreferenceChip(settings.appPreferences.language),
                          ),
                          SettingsValueTile(
                            title: 'Date & Time Format',
                            value: '',
                            customValueWidget: _buildPreferenceChip(settings.appPreferences.dateTimeFormat),
                          ),
                          SettingsValueTile(
                            title: 'Theme',
                            value: '',
                            customValueWidget: _buildPreferenceChip(settings.appPreferences.theme, showChevron: true),
                          ),
                          SettingsValueTile(
                            title: 'Text Size',
                            value: '',
                            customValueWidget: _buildPreferenceChip(settings.appPreferences.textSize, showChevron: true),
                          ),
                        ],
                      ),
                      
                      SettingsSectionCard(
                        title: 'Work Preferences',
                        backgroundColor: AppColors.surfaceBright,
                        border: Border.all(color: AppColors.primary.withAlpha(12)), // 5% primary
                        children: [
                          SettingsValueTile(
                            title: 'Default Assigned Zone',
                            value: settings.workPreferences.defaultAssignedZone,
                            valueColor: AppColors.primary,
                          ),
                          SettingsValueTile(
                            title: 'Default Shift',
                            value: settings.workPreferences.defaultShift,
                            valueColor: AppColors.primary,
                          ),
                          SettingsValueTile(
                            title: 'Auto Refresh',
                            value: settings.workPreferences.autoRefresh,
                            valueColor: AppColors.primary,
                          ),
                          SettingsValueTile(
                            title: 'Offline Sync',
                            value: '',
                            customValueWidget: Row(
                              children: [
                                Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.only(right: 4.0),
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Text(
                                  'Active',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SettingsValueTile(
                            title: 'Offline Cache',
                            value: settings.workPreferences.offlineCacheStatus,
                            valueColor: AppColors.onSurfaceVariant,
                          ),
                        ],
                      ),
                      
                      const SettingsActionGrid(),
                      
                      SettingsSectionCard(
                        title: 'About Application',
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                SettingsValueTile(
                                  title: 'App Version',
                                  value: settings.aboutApp.appVersion,
                                ),
                                SettingsValueTile(
                                  title: 'Build Number',
                                  value: settings.aboutApp.buildNumber,
                                ),
                                SettingsValueTile(
                                  title: 'Last Sync',
                                  value: settings.aboutApp.lastSync,
                                ),
                                SettingsValueTile(
                                  title: 'Environment',
                                  value: '',
                                  customValueWidget: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary.withAlpha(25), // 10% secondary
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                    child: Text(
                                      settings.aboutApp.environment.toUpperCase(),
                                      style: const TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SettingsSectionCard(
                        title: 'Connected Device',
                        children: [
                          SettingsValueTile(
                            title: 'Current Device',
                            value: settings.connectedDevice.currentDevice,
                          ),
                          SettingsValueTile(
                            title: 'Last Login',
                            value: settings.connectedDevice.lastLogin,
                          ),
                          SettingsValueTile(
                            title: 'Device Status',
                            value: '',
                            customValueWidget: Row(
                              children: [
                                Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.only(right: 4.0),
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Text(
                                  'Secure',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SettingsSectionCard(
                        title: 'Permissions',
                        children: [
                          SettingsValueTile(
                            title: 'Camera',
                            value: settings.permissions.cameraAllowed ? 'Allowed' : 'Denied',
                            valueColor: AppColors.primary,
                          ),
                          SettingsValueTile(
                            title: 'Location',
                            value: settings.permissions.locationAllowed ? 'Allowed' : 'Denied',
                            valueColor: AppColors.primary,
                          ),
                          SettingsValueTile(
                            title: 'Bluetooth',
                            value: settings.permissions.bluetoothAllowed ? 'Allowed' : 'Denied',
                            valueColor: AppColors.primary,
                          ),
                          SettingsValueTile(
                            title: 'Notifications',
                            value: settings.permissions.notificationsAllowed ? 'Allowed' : 'Denied',
                            valueColor: AppColors.primary,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16.0),
                      
                      SettingsLogoutCard(
                        onLogout: () {
                          // TODO: Logout logic
                        },
                      ),
                      
                      const SizedBox(height: 80.0), // Bottom padding
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPreferenceChip(String text, {bool showChevron = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer.withAlpha(25), // 10%
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          if (showChevron) ...[
            const SizedBox(width: 4.0),
            const Icon(Icons.expand_more, color: AppColors.primary, size: 16.0),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 60.0),
          const SizedBox(height: 16.0),
          const Text(
            'Failed to load settings',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            message,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: AppColors.outline,
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () => context.read<SettingsBloc>().add(const LoadSettingsRequested()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
