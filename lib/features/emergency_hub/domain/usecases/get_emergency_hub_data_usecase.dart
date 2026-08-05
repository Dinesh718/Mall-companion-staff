import '../entities/emergency_hub_entity.dart';
import '../repositories/emergency_hub_repository.dart';

class GetEmergencyHubDataUseCase {
  final EmergencyHubRepository repository;

  GetEmergencyHubDataUseCase({required this.repository});

  Future<EmergencyHubEntity> call() async {
    return await repository.getEmergencyHubData();
  }
}
