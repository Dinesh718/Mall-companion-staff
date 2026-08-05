import '../entities/activity_history_item_entity.dart';
import '../repositories/maintenance_repository.dart';

class GetActivityHistoryUseCase {
  final MaintenanceRepository repository;

  GetActivityHistoryUseCase({required this.repository});

  Future<List<ActivityHistoryItemEntity>> call() async {
    return await repository.getActivityHistory();
  }
}
