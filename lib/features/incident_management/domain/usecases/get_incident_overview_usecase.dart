import '../entities/incident_overview_entity.dart';
import '../repositories/incident_repository.dart';

class GetIncidentOverviewUseCase {
  final IncidentRepository repository;

  GetIncidentOverviewUseCase({required this.repository});

  Future<IncidentOverviewEntity> call() async {
    return await repository.getIncidentOverview();
  }
}
