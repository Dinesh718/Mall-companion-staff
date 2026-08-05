import '../entities/security_dashboard_entity.dart';
import '../repositories/security_dashboard_repository.dart';

class GetSecurityDashboardUseCase {
  final SecurityDashboardRepository repository;

  GetSecurityDashboardUseCase({required this.repository});

  Future<SecurityDashboardEntity> call() async {
    return await repository.getDashboardData();
  }
}
