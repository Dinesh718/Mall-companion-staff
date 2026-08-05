import '../entities/queue_entity.dart';
import '../entities/queue_summary_entity.dart';
import '../repositories/queue_repository.dart';

class LoadQueueDashboardUseCase {
  final QueueRepository repository;

  LoadQueueDashboardUseCase(this.repository);

  Future<(List<QueueEntity>, QueueSummaryEntity)> call() async {
    final queue = await repository.getCurrentQueue();
    final summary = await repository.getQueueSummary();
    return (queue, summary);
  }
}
