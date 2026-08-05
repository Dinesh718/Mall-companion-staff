import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/assigned_ticket_filter.dart';
import '../../../domain/repositories/maintenance_repository.dart';
import '../../../domain/usecases/get_activity_history_usecase.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final MaintenanceRepository repository;
  final GetActivityHistoryUseCase getActivityHistoryUseCase;

  ActivityBloc({
    required this.repository,
    required this.getActivityHistoryUseCase,
  }) : super(const ActivityInitial()) {
    on<LoadActivityHistory>(_onLoadActivityHistory);
    on<SearchActivityRequested>(_onSearchActivityRequested);
    on<ApplyFiltersRequested>(_onApplyFiltersRequested);
    on<RemoveFilterRequested>(_onRemoveFilterRequested);
    on<ClearFiltersRequested>(_onClearFiltersRequested);
  }

  Future<void> _onLoadActivityHistory(
    LoadActivityHistory event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityLoading());
    try {
      final activities = await getActivityHistoryUseCase();
      emit(ActivityLoaded(
        allActivities: activities,
        filteredActivities: activities,
      ));
    } catch (e) {
      emit(ActivityError('Failed to load activity history: $e'));
    }
  }

  Future<void> _onSearchActivityRequested(
    SearchActivityRequested event,
    Emitter<ActivityState> emit,
  ) async {
    if (state is ActivityLoaded) {
      final currentState = state as ActivityLoaded;
      try {
        final filteredByStatus = await repository.filterActivityHistory(
          filters: currentState.activeFilters,
          activities: currentState.allActivities,
        );

        final searched = await repository.searchActivityHistory(
          query: event.query,
          activities: filteredByStatus,
        );

        emit(currentState.copyWith(
          searchQuery: event.query,
          filteredActivities: searched,
        ));
      } catch (e) {
        emit(ActivityError('Failed to search activity history: $e'));
      }
    }
  }

  Future<void> _onApplyFiltersRequested(
    ApplyFiltersRequested event,
    Emitter<ActivityState> emit,
  ) async {
    if (state is ActivityLoaded) {
      final currentState = state as ActivityLoaded;
      try {
        final filtered = await repository.filterActivityHistory(
          filters: event.filters,
          activities: currentState.allActivities,
        );

        final searched = await repository.searchActivityHistory(
          query: currentState.searchQuery,
          activities: filtered,
        );

        emit(currentState.copyWith(
          activeFilters: event.filters,
          filteredActivities: searched,
        ));
      } catch (e) {
        emit(ActivityError('Failed to apply filters: $e'));
      }
    }
  }

  Future<void> _onRemoveFilterRequested(
    RemoveFilterRequested event,
    Emitter<ActivityState> emit,
  ) async {
    if (state is ActivityLoaded) {
      final currentState = state as ActivityLoaded;
      final newFilters = Set<AssignedTicketFilter>.from(currentState.activeFilters)
        ..remove(event.filter);
        
      if (newFilters.isEmpty) {
        newFilters.add(AssignedTicketFilter.all);
      }
      
      add(ApplyFiltersRequested(newFilters));
    }
  }

  Future<void> _onClearFiltersRequested(
    ClearFiltersRequested event,
    Emitter<ActivityState> emit,
  ) async {
    if (state is ActivityLoaded) {
      add(const ApplyFiltersRequested({AssignedTicketFilter.all}));
    }
  }
}
