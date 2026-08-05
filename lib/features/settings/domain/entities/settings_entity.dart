import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final AccountSummaryEntity accountSummary;
  final NotificationPreferencesEntity notificationPreferences;
  final SecurityPrivacyEntity securityPrivacy;
  final AppPreferencesEntity appPreferences;
  final WorkPreferencesEntity workPreferences;
  final AboutAppEntity aboutApp;
  final ConnectedDeviceEntity connectedDevice;
  final PermissionsEntity permissions;

  const SettingsEntity({
    required this.accountSummary,
    required this.notificationPreferences,
    required this.securityPrivacy,
    required this.appPreferences,
    required this.workPreferences,
    required this.aboutApp,
    required this.connectedDevice,
    required this.permissions,
  });

  @override
  List<Object?> get props => [
        accountSummary,
        notificationPreferences,
        securityPrivacy,
        appPreferences,
        workPreferences,
        aboutApp,
        connectedDevice,
        permissions,
      ];
}

class AccountSummaryEntity extends Equatable {
  final String name;
  final String employeeId;
  final String role;
  final String avatarUrl;
  final String assignedZone;
  final String currentShift;
  final String lastSync;

  const AccountSummaryEntity({
    required this.name,
    required this.employeeId,
    required this.role,
    required this.avatarUrl,
    required this.assignedZone,
    required this.currentShift,
    required this.lastSync,
  });

  @override
  List<Object?> get props => [
        name,
        employeeId,
        role,
        avatarUrl,
        assignedZone,
        currentShift,
        lastSync,
      ];
}

class NotificationPreferencesEntity extends Equatable {
  final bool pushNotifications;
  final bool maintenanceReminders;
  final bool ticketAssignmentAlerts;
  final bool emergencyAlerts;

  const NotificationPreferencesEntity({
    required this.pushNotifications,
    required this.maintenanceReminders,
    required this.ticketAssignmentAlerts,
    required this.emergencyAlerts,
  });

  @override
  List<Object?> get props => [
        pushNotifications,
        maintenanceReminders,
        ticketAssignmentAlerts,
        emergencyAlerts,
      ];
}

class SecurityPrivacyEntity extends Equatable {
  final bool hasBiometricLogin;
  final bool twoFactorAuthEnabled;

  const SecurityPrivacyEntity({
    required this.hasBiometricLogin,
    required this.twoFactorAuthEnabled,
  });

  @override
  List<Object?> get props => [hasBiometricLogin, twoFactorAuthEnabled];
}

class AppPreferencesEntity extends Equatable {
  final String language;
  final String dateTimeFormat;
  final String theme;
  final String textSize;

  const AppPreferencesEntity({
    required this.language,
    required this.dateTimeFormat,
    required this.theme,
    required this.textSize,
  });

  @override
  List<Object?> get props => [language, dateTimeFormat, theme, textSize];
}

class WorkPreferencesEntity extends Equatable {
  final String defaultAssignedZone;
  final String defaultShift;
  final String autoRefresh;
  final bool offlineSyncActive;
  final String offlineCacheStatus;

  const WorkPreferencesEntity({
    required this.defaultAssignedZone,
    required this.defaultShift,
    required this.autoRefresh,
    required this.offlineSyncActive,
    required this.offlineCacheStatus,
  });

  @override
  List<Object?> get props => [
        defaultAssignedZone,
        defaultShift,
        autoRefresh,
        offlineSyncActive,
        offlineCacheStatus,
      ];
}

class AboutAppEntity extends Equatable {
  final String appVersion;
  final String buildNumber;
  final String lastSync;
  final String environment;

  const AboutAppEntity({
    required this.appVersion,
    required this.buildNumber,
    required this.lastSync,
    required this.environment,
  });

  @override
  List<Object?> get props => [appVersion, buildNumber, lastSync, environment];
}

class ConnectedDeviceEntity extends Equatable {
  final String currentDevice;
  final String lastLogin;
  final bool isSecure;

  const ConnectedDeviceEntity({
    required this.currentDevice,
    required this.lastLogin,
    required this.isSecure,
  });

  @override
  List<Object?> get props => [currentDevice, lastLogin, isSecure];
}

class PermissionsEntity extends Equatable {
  final bool cameraAllowed;
  final bool locationAllowed;
  final bool bluetoothAllowed;
  final bool notificationsAllowed;

  const PermissionsEntity({
    required this.cameraAllowed,
    required this.locationAllowed,
    required this.bluetoothAllowed,
    required this.notificationsAllowed,
  });

  @override
  List<Object?> get props => [
        cameraAllowed,
        locationAllowed,
        bluetoothAllowed,
        notificationsAllowed,
      ];
}
