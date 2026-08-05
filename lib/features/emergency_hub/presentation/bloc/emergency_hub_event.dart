import 'package:equatable/equatable.dart';

abstract class EmergencyHubEvent extends Equatable {
  const EmergencyHubEvent();

  @override
  List<Object?> get props => [];
}

class LoadEmergencyHubDataRequested extends EmergencyHubEvent {
  const LoadEmergencyHubDataRequested();
}

class RefreshEmergencyHubDataRequested extends EmergencyHubEvent {
  const RefreshEmergencyHubDataRequested();
}
