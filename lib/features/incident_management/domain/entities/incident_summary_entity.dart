class IncidentSummaryEntity {
  final int totalIncidents;
  final int criticalIncidents;
  final int assignedIncidents;
  final DateTime lastUpdatedTime;

  const IncidentSummaryEntity({
    required this.totalIncidents,
    required this.criticalIncidents,
    required this.assignedIncidents,
    required this.lastUpdatedTime,
  });
}
