import 'package:equatable/equatable.dart';
import '../../../domain/entities/maintenance_ticket_entity.dart';
import '../../../domain/entities/assigned_ticket_filter.dart';
import '../../../domain/entities/assigned_ticket_sort.dart';

abstract class AssignedTicketsState extends Equatable {
  const AssignedTicketsState();

  @override
  List<Object?> get props => [];
}

class AssignedTicketsInitial extends AssignedTicketsState {}

class AssignedTicketsLoading extends AssignedTicketsState {}

class AssignedTicketsLoaded extends AssignedTicketsState {
  final List<MaintenanceTicketEntity> tickets;
  final Set<AssignedTicketFilter> activeFilters;
  final AssignedTicketSort activeSort;
  final String searchQuery;

  const AssignedTicketsLoaded({
    required this.tickets,
    this.activeFilters = const {},
    this.activeSort = AssignedTicketSort.newest,
    this.searchQuery = '',
  });

  AssignedTicketsLoaded copyWith({
    List<MaintenanceTicketEntity>? tickets,
    Set<AssignedTicketFilter>? activeFilters,
    AssignedTicketSort? activeSort,
    String? searchQuery,
  }) {
    return AssignedTicketsLoaded(
      tickets: tickets ?? this.tickets,
      activeFilters: activeFilters ?? this.activeFilters,
      activeSort: activeSort ?? this.activeSort,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [tickets, activeFilters, activeSort, searchQuery];
}

class AssignedTicketsError extends AssignedTicketsState {
  final String errorMessage;

  const AssignedTicketsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
