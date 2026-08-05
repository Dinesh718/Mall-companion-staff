import '../entities/queue_entity.dart';
import '../entities/queue_summary_entity.dart';
import '../entities/create_queue_entry_entity.dart';

import '../entities/queue_filter.dart';
import '../entities/queue_sort_option.dart';
import '../entities/queue_analytics_entity.dart';

abstract class QueueRepository {
  Future<List<QueueEntity>> getCurrentQueue();
  Future<QueueSummaryEntity> getQueueSummary();
  Future<QueueEntity> getQueueDetails(String queueId);
  Future<QueueEntity> createQueueEntry(CreateQueueEntryEntity entry);
  Future<Map<String, String>> validateQueueEntry(CreateQueueEntryEntity entry);
  Future<QueueEntity> callCustomer(String queueId);
  Future<QueueEntity> markArrived(String queueId);
  Future<QueueEntity> startService(String queueId);
  Future<QueueEntity> completeService(String queueId);
  Future<QueueEntity> skipCustomer(String queueId);
  Future<QueueEntity> cancelQueue(String queueId);
  Future<List<QueueEntity>> searchQueue(String query);
  Future<List<QueueEntity>> filterQueue(QueueFilter filter);
  Future<List<QueueEntity>> sortQueue(QueueSortOption sortOption);
  Future<QueueAnalyticsEntity> getQueueAnalytics({required String range});
}
