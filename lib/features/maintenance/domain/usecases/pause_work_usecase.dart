import '../repositories/maintenance_repository.dart';

class PauseWorkUseCase {
  final MaintenanceRepository repository;

  PauseWorkUseCase({required this.repository});

  Future<void> call(String id) async {
    return repository.pauseWork(id);
  }
}
