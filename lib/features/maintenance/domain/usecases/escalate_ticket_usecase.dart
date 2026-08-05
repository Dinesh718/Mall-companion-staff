import '../repositories/maintenance_repository.dart';

class EscalateTicketUseCase {
  final MaintenanceRepository repository;

  EscalateTicketUseCase({required this.repository});

  Future<void> call(String id, String reason) async {
    return repository.escalateTicket(id, reason);
  }
}
