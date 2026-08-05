import '../entities/maintenance_dashboard_entity.dart';
import '../repositories/maintenance_repository.dart';

class GetMaintenanceDashboardUseCase {
  final MaintenanceRepository repository;

  GetMaintenanceDashboardUseCase({required this.repository});

  Future<MaintenanceDashboardEntity> call() async {
    return await repository.getDashboard();
  }
}
