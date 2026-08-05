import 'package:equatable/equatable.dart';
import '../../domain/entities/emergency_hub_entity.dart';

abstract class EmergencyHubState extends Equatable {
  const EmergencyHubState();

  @override
  List<Object?> get props => [];
}

class EmergencyHubInitial extends EmergencyHubState {
  const EmergencyHubInitial();
}

class EmergencyHubLoading extends EmergencyHubState {
  const EmergencyHubLoading();
}

class EmergencyHubLoaded extends EmergencyHubState {
  final EmergencyHubEntity hubData;

  const EmergencyHubLoaded({required this.hubData});

  @override
  List<Object?> get props => [hubData];
}

class EmergencyHubError extends EmergencyHubState {
  final String message;

  const EmergencyHubError({required this.message});

  @override
  List<Object?> get props => [message];
}
