import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

class CallCustomerUseCase {
  final QueueRepository repository;

  CallCustomerUseCase(this.repository);

  Future<QueueEntity> call(String queueId) async {
    return repository.callCustomer(queueId);
  }
}
