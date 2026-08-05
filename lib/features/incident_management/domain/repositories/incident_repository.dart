import '../entities/incident_entity.dart';
import '../entities/incident_summary_entity.dart';
import '../entities/incident_overview_entity.dart';
import '../entities/incident_filter_entity.dart';

abstract class IncidentRepository {
  Future<List<IncidentEntity>> getIncidents(IncidentFilterEntity filter);
  Future<IncidentSummaryEntity> getIncidentSummary();
  Future<IncidentOverviewEntity> getIncidentOverview();
}
