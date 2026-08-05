import 'package:equatable/equatable.dart';
import '../../../domain/entities/activity_history_item_entity.dart';
import '../../../domain/entities/assigned_ticket_filter.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object?> get props => [];
}

class ActivityInitial extends ActivityState {
  const ActivityInitial();
}

class ActivityLoading extends ActivityState {
  const ActivityLoading();
}

class ActivityLoaded extends ActivityState {
  final List<ActivityHistoryItemEntity> allActivities;
  final List<ActivityHistoryItemEntity> filteredActivities;
  final String searchQuery;
  final Set<AssignedTicketFilter> activeFilters;

  const ActivityLoaded({
    required this.allActivities,
    required this.filteredActivities,
    this.searchQuery = '',
    this.activeFilters = const {AssignedTicketFilter.all},
  });

  ActivityLoaded copyWith({
    List<ActivityHistoryItemEntity>? allActivities,
    List<ActivityHistoryItemEntity>? filteredActivities,
    String? searchQuery,
    Set<AssignedTicketFilter>? activeFilters,
  }) {
    return ActivityLoaded(
      allActivities: allActivities ?? this.allActivities,
      filteredActivities: filteredActivities ?? this.filteredActivities,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilters: activeFilters ?? this.activeFilters,
    );
  }

  @override
  List<Object?> get props => [allActivities, filteredActivities, searchQuery, activeFilters];
}

class ActivityError extends ActivityState {
  final String errorMessage;

  const ActivityError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
