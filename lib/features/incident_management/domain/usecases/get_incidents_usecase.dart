import '../entities/incident_entity.dart';
import '../entities/incident_filter_entity.dart';
import '../repositories/incident_repository.dart';

class GetIncidentsUseCase {
  final IncidentRepository repository;

  GetIncidentsUseCase({required this.repository});

  Future<List<IncidentEntity>> call(IncidentFilterEntity filter) async {
    return await repository.getIncidents(filter);
  }
}
