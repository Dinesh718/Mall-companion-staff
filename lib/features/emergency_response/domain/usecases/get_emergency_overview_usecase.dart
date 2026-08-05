import '../entities/emergency_overview_entity.dart';
import '../repositories/emergency_response_repository.dart';

class GetEmergencyOverviewUseCase {
  final EmergencyResponseRepository repository;

  GetEmergencyOverviewUseCase({required this.repository});

  Future<EmergencyOverviewEntity> call() async {
    return await repository.getEmergencyOverview();
  }
}
