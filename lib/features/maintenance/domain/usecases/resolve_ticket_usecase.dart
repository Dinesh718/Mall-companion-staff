import '../repositories/maintenance_repository.dart';
import '../entities/ticket_resolution_entity.dart';

class ResolveTicketUseCase {
  final MaintenanceRepository repository;

  ResolveTicketUseCase({required this.repository});

  Future<void> call(String id, TicketResolutionEntity resolution) async {
    return repository.resolveTicket(id, resolution);
  }
}
