import '../repositories/maintenance_repository.dart';

class ResumeWorkUseCase {
  final MaintenanceRepository repository;

  ResumeWorkUseCase({required this.repository});

  Future<void> call(String id) async {
    return repository.resumeWork(id);
  }
}
