import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class MarkArrivedUseCase {
  final QueueRepository repository;

  MarkArrivedUseCase(this.repository);

  Future<QueueEntity> call(String queueId) async {
    return repository.markArrived(queueId);
  }
}
