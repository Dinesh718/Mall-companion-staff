import '../repositories/maintenance_repository.dart';

class CloseTicketUseCase {
  final MaintenanceRepository repository;

  CloseTicketUseCase({required this.repository});

  Future<void> call(String id) async {
    return repository.closeTicket(id);
  }
}
