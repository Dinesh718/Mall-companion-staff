import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/incident_filter_entity.dart';
import '../../domain/usecases/get_incident_overview_usecase.dart';
import '../../domain/usecases/get_incident_summary_usecase.dart';
import '../../domain/usecases/get_incidents_usecase.dart';
import 'incident_management_event.dart';
import 'incident_management_state.dart';

class IncidentManagementBloc extends Bloc<IncidentManagementEvent, IncidentManagementState> {
  final GetIncidentsUseCase getIncidentsUseCase;
  final GetIncidentOverviewUseCase getIncidentOverviewUseCase;
  final GetIncidentSummaryUseCase getIncidentSummaryUseCase;

  IncidentFilterEntity _currentFilter = IncidentFilterEntity.all;

  IncidentManagementBloc({
    required this.getIncidentsUseCase,
    required this.getIncidentOverviewUseCase,
    required this.getIncidentSummaryUseCase,
  }) : super(const IncidentManagementInitial()) {
    on<LoadIncidentsRequested>(_onLoadIncidents);
    on<FilterChanged>(_onFilterChanged);
    on<RefreshIncidentsRequested>(_onRefreshIncidents);
  }

  Future<void> _onLoadIncidents(
    LoadIncidentsRequested event,
    Emitter<IncidentManagementState> emit,
  ) async {
    emit(IncidentManagementLoading(filter: _currentFilter));

    try {
      final overview = await getIncidentOverviewUseCase();
      final summary = await getIncidentSummaryUseCase();
      final incidents = await getIncidentsUseCase(_currentFilter);

      emit(IncidentManagementLoaded(
        incidents: incidents,
        overview: overview,
        summary: summary,
        currentFilter: _currentFilter,
      ));
    } catch (e) {
      emit(IncidentManagementError(message: 'Failed to load incidents: ${e.toString()}'));
    }
  }

  Future<void> _onFilterChanged(
    FilterChanged event,
    Emitter<IncidentManagementState> emit,
  ) async {
    if (_currentFilter == event.filter && state is IncidentManagementLoaded) {
      return;
    }

    _currentFilter = event.filter;
    
    // If we already have the overview and summary, just fetch the new list of incidents
    // without doing a hard loading screen to keep it smooth, but since we are mocking
    // we can emit a soft loading state if we want, or just wait.
    // For now, let's just await the incidents and emit a new Loaded state.
    
    if (state is IncidentManagementLoaded) {
      final currentState = state as IncidentManagementLoaded;
      try {
        final incidents = await getIncidentsUseCase(_currentFilter);
        emit(currentState.copyWith(
          incidents: incidents,
          currentFilter: _currentFilter,
        ));
      } catch (e) {
        emit(IncidentManagementError(message: 'Failed to filter incidents: ${e.toString()}'));
      }
    } else {
      add(const LoadIncidentsRequested());
    }
  }

  Future<void> _onRefreshIncidents(
    RefreshIncidentsRequested event,
    Emitter<IncidentManagementState> emit,
  ) async {
    try {
      final overview = await getIncidentOverviewUseCase();
      final summary = await getIncidentSummaryUseCase();
      final incidents = await getIncidentsUseCase(_currentFilter);

      emit(IncidentManagementLoaded(
        incidents: incidents,
        overview: overview,
        summary: summary,
        currentFilter: _currentFilter,
      ));
    } catch (e) {
      // If refresh fails, we could either emit error or keep old state. We'll emit error.
      emit(IncidentManagementError(message: 'Failed to refresh incidents: ${e.toString()}'));
    }
  }
}
