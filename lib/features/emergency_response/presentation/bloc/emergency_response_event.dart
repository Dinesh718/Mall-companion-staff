import 'package:equatable/equatable.dart';
import '../../domain/entities/emergency_filter_entity.dart';

abstract class EmergencyResponseEvent extends Equatable {
  const EmergencyResponseEvent();

  @override
  List<Object?> get props => [];
}

class LoadEmergenciesRequested extends EmergencyResponseEvent {
  const LoadEmergenciesRequested();
}

class FilterChanged extends EmergencyResponseEvent {
  final EmergencyFilterEntity filter;

  const FilterChanged({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class RefreshRequested extends EmergencyResponseEvent {
  const RefreshRequested();
}

class AcceptResponseRequested extends EmergencyResponseEvent {
  final String emergencyId;

  const AcceptResponseRequested({required this.emergencyId});

  @override
  List<Object?> get props => [emergencyId];
}
