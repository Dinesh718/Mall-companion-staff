import 'package:equatable/equatable.dart';
import '../../domain/entities/incident_filter_entity.dart';

abstract class IncidentManagementEvent extends Equatable {
  const IncidentManagementEvent();

  @override
  List<Object?> get props => [];
}

class LoadIncidentsRequested extends IncidentManagementEvent {
  const LoadIncidentsRequested();
}

class FilterChanged extends IncidentManagementEvent {
  final IncidentFilterEntity filter;

  const FilterChanged({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class RefreshIncidentsRequested extends IncidentManagementEvent {
  const RefreshIncidentsRequested();
}
