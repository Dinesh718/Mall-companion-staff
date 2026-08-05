import 'package:equatable/equatable.dart';
import '../../../domain/entities/assigned_ticket_filter.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object?> get props => [];
}

class LoadActivityHistory extends ActivityEvent {
  const LoadActivityHistory();
}

class SearchActivityRequested extends ActivityEvent {
  final String query;

  const SearchActivityRequested(this.query);

  @override
  List<Object?> get props => [query];
}

class ApplyFiltersRequested extends ActivityEvent {
  final Set<AssignedTicketFilter> filters;

  const ApplyFiltersRequested(this.filters);

  @override
  List<Object?> get props => [filters];
}

class RemoveFilterRequested extends ActivityEvent {
  final AssignedTicketFilter filter;

  const RemoveFilterRequested(this.filter);

  @override
  List<Object?> get props => [filter];
}

class ClearFiltersRequested extends ActivityEvent {
  const ClearFiltersRequested();
}
