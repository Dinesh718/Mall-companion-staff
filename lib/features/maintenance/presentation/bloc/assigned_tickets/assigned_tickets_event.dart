import 'package:equatable/equatable.dart';
import '../../../domain/entities/assigned_ticket_filter.dart';
import '../../../domain/entities/assigned_ticket_sort.dart';

abstract class AssignedTicketsEvent extends Equatable {
  const AssignedTicketsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAssignedTickets extends AssignedTicketsEvent {
  const LoadAssignedTickets();
}

class SearchTicketsRequested extends AssignedTicketsEvent {
  final String query;

  const SearchTicketsRequested(this.query);

  @override
  List<Object?> get props => [query];
}

class ApplyFiltersRequested extends AssignedTicketsEvent {
  final Set<AssignedTicketFilter> filters;

  const ApplyFiltersRequested(this.filters);

  @override
  List<Object?> get props => [filters];
}

class RemoveFilterRequested extends AssignedTicketsEvent {
  final AssignedTicketFilter filter;

  const RemoveFilterRequested(this.filter);

  @override
  List<Object?> get props => [filter];
}

class ApplySortRequested extends AssignedTicketsEvent {
  final AssignedTicketSort sort;

  const ApplySortRequested(this.sort);

  @override
  List<Object?> get props => [sort];
}

class ClearFiltersRequested extends AssignedTicketsEvent {
  const ClearFiltersRequested();
}
