import '../entities/create_queue_entry_entity.dart';
import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';
import 'validate_queue_entry_usecase.dart';

class CreateQueueEntryUseCase {
  final QueueRepository repository;
  final ValidateQueueEntryUseCase validator;

  CreateQueueEntryUseCase(this.repository)
      : validator = ValidateQueueEntryUseCase();

  Future<QueueEntity> call(CreateQueueEntryEntity entry) async {
    // 1. Validate
    final errors = await validator(entry);
    if (errors.isNotEmpty) {
      throw Exception('Validation failed');
    }

    // 2. Delegate to repository
    return repository.createQueueEntry(entry);
  }
}
