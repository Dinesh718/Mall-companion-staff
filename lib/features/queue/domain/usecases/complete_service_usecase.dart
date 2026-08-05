import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class CompleteServiceUseCase {
  final QueueRepository repository;

  CompleteServiceUseCase(this.repository);

  Future<QueueEntity> call(String queueId) async {
    return repository.completeService(queueId);
  }
}
