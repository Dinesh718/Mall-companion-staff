import '../entities/queue_entity.dart';
import '../entities/queue_filter.dart';
import '../entities/queue_status.dart';
import '../repositories/queue_repository.dart';

class FilterQueueUseCase {
  final QueueRepository repository;

  FilterQueueUseCase(this.repository);

  Future<List<QueueEntity>> call(QueueFilter filter, {List<QueueEntity>? localList}) async {
    if (localList != null) {
      if (filter == QueueFilter.all) return localList;
      if (filter == QueueFilter.skipped) {
        return localList.where((item) =>
          item.timelineSteps?.any((step) => step.title.toLowerCase().contains('skipped')) ?? false
        ).toList();
      }
      final statusEnum = QueueStatus.values.firstWhere(
        (e) => e.name == filter.name,
        orElse: () => QueueStatus.waiting,
      );
      return localList.where((item) => item.status == statusEnum).toList();
    }
    return repository.filterQueue(filter);
  }
}
