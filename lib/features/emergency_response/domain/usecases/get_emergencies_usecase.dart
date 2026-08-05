import '../entities/emergency_entity.dart';
import '../entities/emergency_filter_entity.dart';
import '../repositories/emergency_response_repository.dart';

class GetEmergenciesUseCase {
  final EmergencyResponseRepository repository;

  GetEmergenciesUseCase({required this.repository});

  Future<List<EmergencyEntity>> call(EmergencyFilterEntity filter) async {
    return await repository.getEmergencies(filter);
  }
}
