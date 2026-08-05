import 'package:equatable/equatable.dart';
import '../../domain/entities/incident_entity.dart';
import '../../domain/entities/incident_filter_entity.dart';
import '../../domain/entities/incident_overview_entity.dart';
import '../../domain/entities/incident_summary_entity.dart';

abstract class IncidentManagementState extends Equatable {
  const IncidentManagementState();

  @override
  List<Object?> get props => [];
}

class IncidentManagementInitial extends IncidentManagementState {
  const IncidentManagementInitial();
}

class IncidentManagementLoading extends IncidentManagementState {
  final IncidentFilterEntity filter;

  const IncidentManagementLoading({this.filter = IncidentFilterEntity.all});

  @override
  List<Object?> get props => [filter];
}

class IncidentManagementLoaded extends IncidentManagementState {
  final List<IncidentEntity> incidents;
  final IncidentOverviewEntity overview;
  final IncidentSummaryEntity summary;
  final IncidentFilterEntity currentFilter;

  const IncidentManagementLoaded({
    required this.incidents,
    required this.overview,
    required this.summary,
    required this.currentFilter,
  });

  @override
  List<Object?> get props => [incidents, overview, summary, currentFilter];

  IncidentManagementLoaded copyWith({
    List<IncidentEntity>? incidents,
    IncidentOverviewEntity? overview,
    IncidentSummaryEntity? summary,
    IncidentFilterEntity? currentFilter,
  }) {
    return IncidentManagementLoaded(
      incidents: incidents ?? this.incidents,
      overview: overview ?? this.overview,
      summary: summary ?? this.summary,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}

class IncidentManagementError extends IncidentManagementState {
  final String message;

  const IncidentManagementError({required this.message});

  @override
  List<Object?> get props => [message];
}
