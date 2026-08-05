import '../repositories/maintenance_repository.dart';
import '../entities/ticket_resolution_entity.dart';

class SaveResolutionDraftUseCase {
  final MaintenanceRepository repository;

  SaveResolutionDraftUseCase({required this.repository});

  Future<void> call(String id, TicketResolutionEntity draft) async {
    return repository.saveResolutionDraft(id, draft);
  }
}
