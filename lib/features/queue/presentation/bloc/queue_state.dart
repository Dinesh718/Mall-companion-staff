import 'package:equatable/equatable.dart';
import '../../domain/entities/queue_entity.dart';
import '../../domain/entities/queue_summary_entity.dart';
import '../../domain/entities/queue_filter.dart';
import '../../domain/entities/queue_sort_option.dart';

abstract class QueueState extends Equatable {
  const QueueState();

  @override
  List<Object?> get props => [];
}

class QueueInitial extends QueueState {
  const QueueInitial();
}

class QueueLoading extends QueueState {
  const QueueLoading();
}

class QueueLoaded extends QueueState {
  final List<QueueEntity> queue;
  final List<QueueEntity> allQueue;
  final QueueSummaryEntity summary;
  final String searchQuery;
  final QueueFilter selectedFilter;
  final QueueSortOption selectedSort;

  const QueueLoaded({
    required this.queue,
    required this.allQueue,
    required this.summary,
    this.searchQuery = '',
    this.selectedFilter = QueueFilter.all,
    this.selectedSort = QueueSortOption.oldestFirst,
  });

  QueueLoaded copyWith({
    List<QueueEntity>? queue,
    List<QueueEntity>? allQueue,
    QueueSummaryEntity? summary,
    String? searchQuery,
    QueueFilter? selectedFilter,
    QueueSortOption? selectedSort,
  }) {
    return QueueLoaded(
      queue: queue ?? this.queue,
      allQueue: allQueue ?? this.allQueue,
      summary: summary ?? this.summary,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedSort: selectedSort ?? this.selectedSort,
    );
  }

  @override
  List<Object?> get props => [
        queue,
        allQueue,
        summary,
        searchQuery,
        selectedFilter,
        selectedSort,
      ];
}

class QueueError extends QueueState {
  final String errorMessage;

  const QueueError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// Queue Details States
class QueueDetailsLoading extends QueueState {
  const QueueDetailsLoading();
}

class QueueDetailsLoaded extends QueueState {
  final QueueEntity queueItem;
  final String? activeAction;

  const QueueDetailsLoaded(this.queueItem, {this.activeAction});

  QueueDetailsLoaded copyWith({
    QueueEntity? queueItem,
    String? activeAction,
    bool clearActiveAction = false,
  }) {
    return QueueDetailsLoaded(
      queueItem ?? this.queueItem,
      activeAction: clearActiveAction ? null : (activeAction ?? this.activeAction),
    );
  }

  @override
  List<Object?> get props => [queueItem, activeAction];
}

class QueueDetailsError extends QueueState {
  final String errorMessage;

  const QueueDetailsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
