import '../entities/security_dashboard_entity.dart';

abstract class SecurityDashboardRepository {
  Future<SecurityDashboardEntity> getDashboardData();
}
