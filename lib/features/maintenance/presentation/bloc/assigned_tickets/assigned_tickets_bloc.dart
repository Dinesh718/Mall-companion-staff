import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/maintenance_ticket_entity.dart';
import '../../../domain/entities/assigned_ticket_filter.dart';
import '../../../domain/entities/assigned_ticket_sort.dart';
import '../../../domain/usecases/get_assigned_tickets_usecase.dart';
import '../../../domain/repositories/maintenance_repository.dart';
import 'assigned_tickets_event.dart';
import 'assigned_tickets_state.dart';

class AssignedTicketsBloc extends Bloc<AssignedTicketsEvent, AssignedTicketsState> {
  final GetAssignedTicketsUseCase getAssignedTicketsUseCase;
  final MaintenanceRepository repository;
  
  List<MaintenanceTicketEntity> _allTickets = [];

  AssignedTicketsBloc({
    required this.getAssignedTicketsUseCase,
    required this.repository,
  }) : super(AssignedTicketsInitial()) {
    on<LoadAssignedTickets>(_onLoadAssignedTickets);
    on<SearchTicketsRequested>(_onSearchTicketsRequested);
    on<ApplyFiltersRequested>(_onApplyFiltersRequested);
    on<RemoveFilterRequested>(_onRemoveFilterRequested);
    on<ApplySortRequested>(_onApplySortRequested);
    on<ClearFiltersRequested>(_onClearFiltersRequested);
  }

  Future<void> _onLoadAssignedTickets(LoadAssignedTickets event, Emitter<AssignedTicketsState> emit) async {
    emit(AssignedTicketsLoading());
    try {
      _allTickets = await getAssignedTicketsUseCase.call();
      emit(AssignedTicketsLoaded(tickets: _allTickets));
    } catch (e) {
      emit(AssignedTicketsError(e.toString()));
    }
  }

  Future<void> _onSearchTicketsRequested(SearchTicketsRequested event, Emitter<AssignedTicketsState> emit) async {
    final currentState = state;
    if (currentState is AssignedTicketsLoaded) {
      try {
        final filtered = await repository.filterAssignedTickets(
          filters: currentState.activeFilters,
          tickets: _allTickets,
        );
        final searched = await repository.searchAssignedTickets(
          query: event.query,
          tickets: filtered,
        );
        final sorted = await repository.sortAssignedTickets(
          sort: currentState.activeSort,
          tickets: searched,
        );
        emit(currentState.copyWith(tickets: sorted, searchQuery: event.query));
      } catch (e) {
        emit(AssignedTicketsError(e.toString()));
      }
    }
  }

  Future<void> _onApplyFiltersRequested(ApplyFiltersRequested event, Emitter<AssignedTicketsState> emit) async {
    final currentState = state;
    if (currentState is AssignedTicketsLoaded) {
      try {
        final filtered = await repository.filterAssignedTickets(
          filters: event.filters,
          tickets: _allTickets,
        );
        final searched = await repository.searchAssignedTickets(
          query: currentState.searchQuery,
          tickets: filtered,
        );
        final sorted = await repository.sortAssignedTickets(
          sort: currentState.activeSort,
          tickets: searched,
        );
        emit(currentState.copyWith(tickets: sorted, activeFilters: event.filters));
      } catch (e) {
        emit(AssignedTicketsError(e.toString()));
      }
    }
  }

  Future<void> _onRemoveFilterRequested(RemoveFilterRequested event, Emitter<AssignedTicketsState> emit) async {
    final currentState = state;
    if (currentState is AssignedTicketsLoaded) {
      try {
        final newFilters = Set<AssignedTicketFilter>.from(currentState.activeFilters)..remove(event.filter);
        if (newFilters.isEmpty) {
          newFilters.add(AssignedTicketFilter.all);
        }
        
        final filtered = await repository.filterAssignedTickets(
          filters: newFilters,
          tickets: _allTickets,
        );
        final searched = await repository.searchAssignedTickets(
          query: currentState.searchQuery,
          tickets: filtered,
        );
        final sorted = await repository.sortAssignedTickets(
          sort: currentState.activeSort,
          tickets: searched,
        );
        emit(currentState.copyWith(tickets: sorted, activeFilters: newFilters));
      } catch (e) {
        emit(AssignedTicketsError(e.toString()));
      }
    }
  }

  Future<void> _onApplySortRequested(ApplySortRequested event, Emitter<AssignedTicketsState> emit) async {
    final currentState = state;
    if (currentState is AssignedTicketsLoaded) {
      try {
        final filtered = await repository.filterAssignedTickets(
          filters: currentState.activeFilters,
          tickets: _allTickets,
        );
        final searched = await repository.searchAssignedTickets(
          query: currentState.searchQuery,
          tickets: filtered,
        );
        final sorted = await repository.sortAssignedTickets(
          sort: event.sort,
          tickets: searched,
        );
        emit(currentState.copyWith(tickets: sorted, activeSort: event.sort));
      } catch (e) {
        emit(AssignedTicketsError(e.toString()));
      }
    }
  }

  Future<void> _onClearFiltersRequested(ClearFiltersRequested event, Emitter<AssignedTicketsState> emit) async {
    final currentState = state;
    if (currentState is AssignedTicketsLoaded) {
      try {
        final sorted = await repository.sortAssignedTickets(
          sort: AssignedTicketSort.newest,
          tickets: _allTickets,
        );
        emit(currentState.copyWith(
          tickets: sorted,
          activeFilters: {AssignedTicketFilter.all},
          activeSort: AssignedTicketSort.newest,
          searchQuery: '',
        ));
      } catch (e) {
        emit(AssignedTicketsError(e.toString()));
      }
    }
  }
}
