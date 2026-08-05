import '../entities/emergency_summary_entity.dart';
import '../repositories/emergency_response_repository.dart';

class GetEmergencySummaryUseCase {
  final EmergencyResponseRepository repository;

  GetEmergencySummaryUseCase({required this.repository});

  Future<EmergencySummaryEntity> call() async {
    return await repository.getEmergencySummary();
  }
}
