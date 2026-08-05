import '../entities/emergency_hub_entity.dart';

abstract class EmergencyHubRepository {
  Future<EmergencyHubEntity> getEmergencyHubData();
}
