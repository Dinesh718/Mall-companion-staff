import '../entities/queue_analytics_entity.dart';
import '../repositories/queue_repository.dart';

class GetQueueAnalyticsUseCase {
  final QueueRepository repository;

  const GetQueueAnalyticsUseCase(this.repository);

  Future<QueueAnalyticsEntity> call({required String range}) async {
    return repository.getQueueAnalytics(range: range);
  }
}
