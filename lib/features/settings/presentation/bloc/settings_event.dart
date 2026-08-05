import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettingsRequested extends SettingsEvent {
  const LoadSettingsRequested();
}

class RefreshSettingsRequested extends SettingsEvent {
  const RefreshSettingsRequested();
}

// In the future, we can add events for toggling preferences
// e.g., class TogglePushNotifications extends SettingsEvent { ... }
