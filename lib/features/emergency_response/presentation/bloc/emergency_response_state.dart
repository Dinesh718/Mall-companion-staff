import 'package:equatable/equatable.dart';
import '../../domain/entities/emergency_entity.dart';
import '../../domain/entities/emergency_filter_entity.dart';
import '../../domain/entities/emergency_overview_entity.dart';
import '../../domain/entities/emergency_summary_entity.dart';

abstract class EmergencyResponseState extends Equatable {
  const EmergencyResponseState();

  @override
  List<Object?> get props => [];
}

class EmergencyResponseInitial extends EmergencyResponseState {
  const EmergencyResponseInitial();
}

class EmergencyResponseLoading extends EmergencyResponseState {
  final EmergencyFilterEntity filter;

  const EmergencyResponseLoading({this.filter = EmergencyFilterEntity.all});

  @override
  List<Object?> get props => [filter];
}

class EmergencyResponseLoaded extends EmergencyResponseState {
  final List<EmergencyEntity> emergencies;
  final EmergencyOverviewEntity overview;
  final EmergencySummaryEntity summary;
  final EmergencyFilterEntity currentFilter;

  const EmergencyResponseLoaded({
    required this.emergencies,
    required this.overview,
    required this.summary,
    required this.currentFilter,
  });

  @override
  List<Object?> get props => [emergencies, overview, summary, currentFilter];

  EmergencyResponseLoaded copyWith({
    List<EmergencyEntity>? emergencies,
    EmergencyOverviewEntity? overview,
    EmergencySummaryEntity? summary,
    EmergencyFilterEntity? currentFilter,
  }) {
    return EmergencyResponseLoaded(
      emergencies: emergencies ?? this.emergencies,
      overview: overview ?? this.overview,
      summary: summary ?? this.summary,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}

class EmergencyResponseError extends EmergencyResponseState {
  final String message;

  const EmergencyResponseError({required this.message});

  @override
  List<Object?> get props => [message];
}
