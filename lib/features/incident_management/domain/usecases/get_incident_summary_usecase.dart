import '../entities/incident_summary_entity.dart';
import '../repositories/incident_repository.dart';

class GetIncidentSummaryUseCase {
  final IncidentRepository repository;

  GetIncidentSummaryUseCase({required this.repository});

  Future<IncidentSummaryEntity> call() async {
    return await repository.getIncidentSummary();
  }
}
