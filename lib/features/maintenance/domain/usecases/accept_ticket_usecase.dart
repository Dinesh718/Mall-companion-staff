import '../repositories/maintenance_repository.dart';

class AcceptTicketUseCase {
  final MaintenanceRepository repository;

  AcceptTicketUseCase({required this.repository});

  Future<void> call(String id) async {
    return repository.acceptTicket(id);
  }
}
