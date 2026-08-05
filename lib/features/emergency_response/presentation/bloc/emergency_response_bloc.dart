import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/emergency_filter_entity.dart';
import '../../domain/usecases/get_emergencies_usecase.dart';
import '../../domain/usecases/get_emergency_overview_usecase.dart';
import '../../domain/usecases/get_emergency_summary_usecase.dart';
import 'emergency_response_event.dart';
import 'emergency_response_state.dart';

class EmergencyResponseBloc extends Bloc<EmergencyResponseEvent, EmergencyResponseState> {
  final GetEmergenciesUseCase getEmergenciesUseCase;
  final GetEmergencyOverviewUseCase getEmergencyOverviewUseCase;
  final GetEmergencySummaryUseCase getEmergencySummaryUseCase;

  EmergencyFilterEntity _currentFilter = EmergencyFilterEntity.all;

  EmergencyResponseBloc({
    required this.getEmergenciesUseCase,
    required this.getEmergencyOverviewUseCase,
    required this.getEmergencySummaryUseCase,
  }) : super(const EmergencyResponseInitial()) {
    on<LoadEmergenciesRequested>(_onLoadEmergencies);
    on<FilterChanged>(_onFilterChanged);
    on<RefreshRequested>(_onRefresh);
    on<AcceptResponseRequested>(_onAcceptResponse);
  }

  Future<void> _onLoadEmergencies(
    LoadEmergenciesRequested event,
    Emitter<EmergencyResponseState> emit,
  ) async {
    emit(EmergencyResponseLoading(filter: _currentFilter));

    try {
      final overview = await getEmergencyOverviewUseCase();
      final summary = await getEmergencySummaryUseCase();
      final emergencies = await getEmergenciesUseCase(_currentFilter);

      emit(EmergencyResponseLoaded(
        emergencies: emergencies,
        overview: overview,
        summary: summary,
        currentFilter: _currentFilter,
      ));
    } catch (e) {
      emit(EmergencyResponseError(message: 'Failed to load emergencies: ${e.toString()}'));
    }
  }

  Future<void> _onFilterChanged(
    FilterChanged event,
    Emitter<EmergencyResponseState> emit,
  ) async {
    if (_currentFilter == event.filter && state is EmergencyResponseLoaded) {
      return;
    }

    _currentFilter = event.filter;
    
    if (state is EmergencyResponseLoaded) {
      final currentState = state as EmergencyResponseLoaded;
      try {
        final emergencies = await getEmergenciesUseCase(_currentFilter);
        emit(currentState.copyWith(
          emergencies: emergencies,
          currentFilter: _currentFilter,
        ));
      } catch (e) {
        emit(EmergencyResponseError(message: 'Failed to filter emergencies: ${e.toString()}'));
      }
    } else {
      add(const LoadEmergenciesRequested());
    }
  }

  Future<void> _onRefresh(
    RefreshRequested event,
    Emitter<EmergencyResponseState> emit,
  ) async {
    try {
      final overview = await getEmergencyOverviewUseCase();
      final summary = await getEmergencySummaryUseCase();
      final emergencies = await getEmergenciesUseCase(_currentFilter);

      emit(EmergencyResponseLoaded(
        emergencies: emergencies,
        overview: overview,
        summary: summary,
        currentFilter: _currentFilter,
      ));
    } catch (e) {
      emit(EmergencyResponseError(message: 'Failed to refresh emergencies: ${e.toString()}'));
    }
  }

  Future<void> _onAcceptResponse(
    AcceptResponseRequested event,
    Emitter<EmergencyResponseState> emit,
  ) async {
    // In Phase 12.3, this just prints a log or could show a local optimistic update.
    // For now, we will just re-fetch to simulate the action.
    if (state is EmergencyResponseLoaded) {
      add(const RefreshRequested());
    }
  }
}
