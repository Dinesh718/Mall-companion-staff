import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class GetQueueDetailsUseCase {
  final QueueRepository repository;

  const GetQueueDetailsUseCase(this.repository);

  Future<QueueEntity> call(String queueId) async {
    return repository.getQueueDetails(queueId);
  }
}
