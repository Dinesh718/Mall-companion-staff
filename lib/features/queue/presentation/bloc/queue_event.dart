import 'package:equatable/equatable.dart';
import '../../domain/entities/queue_filter.dart';
import '../../domain/entities/queue_sort_option.dart';

abstract class QueueEvent extends Equatable {
  const QueueEvent();

  @override
  List<Object?> get props => [];
}

class LoadQueueDashboard extends QueueEvent {
  const LoadQueueDashboard();
}

class RefreshQueueDashboard extends QueueEvent {
  const RefreshQueueDashboard();
}

class LoadQueueDetails extends QueueEvent {
  final String queueId;

  const LoadQueueDetails(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class RefreshQueueDetails extends QueueEvent {
  final String queueId;

  const RefreshQueueDetails(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

// Session management actions
class CallCustomer extends QueueEvent {
  final String queueId;

  const CallCustomer(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class MarkArrived extends QueueEvent {
  final String queueId;

  const MarkArrived(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class CompleteService extends QueueEvent {
  final String queueId;

  const CompleteService(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class SkipCustomer extends QueueEvent {
  final String queueId;

  const SkipCustomer(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class CancelQueue extends QueueEvent {
  final String queueId;

  const CancelQueue(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class CallCustomerRequested extends QueueEvent {
  final String queueId;
  const CallCustomerRequested(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class MarkArrivedRequested extends QueueEvent {
  final String queueId;
  const MarkArrivedRequested(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class StartServiceRequested extends QueueEvent {
  final String queueId;
  const StartServiceRequested(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class CompleteServiceRequested extends QueueEvent {
  final String queueId;
  const CompleteServiceRequested(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class SkipCustomerRequested extends QueueEvent {
  final String queueId;
  const SkipCustomerRequested(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class CancelQueueRequested extends QueueEvent {
  final String queueId;
  const CancelQueueRequested(this.queueId);

  @override
  List<Object?> get props => [queueId];
}

class SearchQueryChanged extends QueueEvent {
  final String query;
  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterChanged extends QueueEvent {
  final QueueFilter filter;
  const FilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}

class SortChanged extends QueueEvent {
  final QueueSortOption sortOption;
  const SortChanged(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}

class ClearFilters extends QueueEvent {
  const ClearFilters();
}
