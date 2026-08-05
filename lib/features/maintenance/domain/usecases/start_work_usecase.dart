import '../repositories/maintenance_repository.dart';

class StartWorkUseCase {
  final MaintenanceRepository repository;

  StartWorkUseCase({required this.repository});

  Future<void> call(String id) async {
    return repository.startWork(id);
  }
}
