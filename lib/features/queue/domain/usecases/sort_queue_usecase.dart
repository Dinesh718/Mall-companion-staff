import '../entities/queue_entity.dart';
import '../entities/queue_sort_option.dart';
import '../repositories/queue_repository.dart';

class SortQueueUseCase {
  final QueueRepository repository;

  SortQueueUseCase(this.repository);

  Future<List<QueueEntity>> call(QueueSortOption sortOption, {List<QueueEntity>? localList}) async {
    if (localList != null) {
      final sorted = List<QueueEntity>.from(localList);
      _applySort(sorted, sortOption);
      return sorted;
    }
    return repository.sortQueue(sortOption);
  }

  void _applySort(List<QueueEntity> list, QueueSortOption sortOption) {
    switch (sortOption) {
      case QueueSortOption.oldestFirst:
      case QueueSortOption.longestWaiting:
        list.sort((a, b) => a.checkInTime.compareTo(b.checkInTime));
        break;
      case QueueSortOption.newestFirst:
      case QueueSortOption.shortestWaiting:
        list.sort((a, b) => b.checkInTime.compareTo(a.checkInTime));
        break;
      case QueueSortOption.highestPriority:
        list.sort((a, b) {
          final priorityComparison = _getPriorityRank(b.priority).compareTo(_getPriorityRank(a.priority));
          if (priorityComparison != 0) return priorityComparison;
          // Sub-sort by check-in time (earliest first) if priority is same
          return a.checkInTime.compareTo(b.checkInTime);
        });
        break;
      case QueueSortOption.largestPartySize:
        list.sort((a, b) {
          final partyComparison = b.partySize.compareTo(a.partySize);
          if (partyComparison != 0) return partyComparison;
          // Sub-sort by check-in time
          return a.checkInTime.compareTo(b.checkInTime);
        });
        break;
    }
  }

  int _getPriorityRank(String? priority) {
    if (priority == null) return 0;
    switch (priority.trim().toLowerCase()) {
      case 'vip':
        return 3;
      case 'senior':
        return 2;
      case 'normal':
      case 'standard':
        return 1;
      default:
        return 0;
    }
  }
}
