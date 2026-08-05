import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class CancelQueueUseCase {
  final QueueRepository repository;

  CancelQueueUseCase(this.repository);

  Future<QueueEntity> call(String queueId) async {
    return repository.cancelQueue(queueId);
  }
}
