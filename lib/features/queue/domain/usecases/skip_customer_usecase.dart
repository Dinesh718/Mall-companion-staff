import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class SkipCustomerUseCase {
  final QueueRepository repository;

  SkipCustomerUseCase(this.repository);

  Future<QueueEntity> call(String queueId) async {
    return repository.skipCustomer(queueId);
  }
}
