import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';

class MockSettingsRepository implements SettingsRepository {
  @override
  Future<SettingsEntity> getSettings() async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate network latency

    return const SettingsEntity(
      accountSummary: AccountSummaryEntity(
        name: 'Alex Rivera',
        employeeId: 'MC-8842',
        role: 'Maintenance Staff',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA7FNR2owehf7hZundXUKG-S1QJE_wtOoGwSFukGowLXuwBTG_tBYVcyajJUf-HG7LC7AZ8mkZUFIC0leM0q2hiJjo46Q_WomSYttCqJ9VOR9HxGjPmffIacoipAA45huBiOpFWuVg6B1nBOzko7cUh5DqT6f6GxIsv6knUOPJv1-O64_gWNd6gcyytobxOdKG1arqOS3mhRF5_DlHWMRQ88AdAcLkF3W4-pz4OOZDNVhkxb8LmR7wu',
        assignedZone: 'Lumina Plaza, Zone A',
        currentShift: 'Morning Shift (06:00 - 14:00)',
        lastSync: '2 min ago',
      ),
      notificationPreferences: NotificationPreferencesEntity(
        pushNotifications: true,
        maintenanceReminders: false,
        ticketAssignmentAlerts: true,
        emergencyAlerts: true,
      ),
      securityPrivacy: SecurityPrivacyEntity(
        hasBiometricLogin: true, // Will be controlled by actual device settings later
        twoFactorAuthEnabled: false,
      ),
      appPreferences: AppPreferencesEntity(
        language: 'English',
        dateTimeFormat: '24h',
        theme: 'System',
        textSize: 'Standard',
      ),
      workPreferences: WorkPreferencesEntity(
        defaultAssignedZone: 'Zone A',
        defaultShift: 'Morning',
        autoRefresh: '5m',
        offlineSyncActive: true,
        offlineCacheStatus: 'Updated 2 min ago',
      ),
      aboutApp: AboutAppEntity(
        appVersion: '2.4.0',
        buildNumber: '1082',
        lastSync: '2m ago',
        environment: 'Production',
      ),
      connectedDevice: ConnectedDeviceEntity(
        currentDevice: 'iPhone 15 Pro',
        lastLogin: 'Today, 08:15 AM',
        isSecure: true,
      ),
      permissions: PermissionsEntity(
        cameraAllowed: true,
        locationAllowed: true,
        bluetoothAllowed: true,
        notificationsAllowed: true,
      ),
    );
  }
}
