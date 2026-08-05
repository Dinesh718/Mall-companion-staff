import '../entities/store_dashboard_entity.dart';

abstract class StoreDashboardRepository {
  Future<StoreDashboardEntity> getDashboardData();
}
