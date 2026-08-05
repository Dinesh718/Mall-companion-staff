class IncidentOverviewEntity {
  final int activeIncidents;
  final int criticalIncidents;
  final int assignedIncidents;
  final double averageResponseTime;

  const IncidentOverviewEntity({
    required this.activeIncidents,
    required this.criticalIncidents,
    required this.assignedIncidents,
    required this.averageResponseTime,
  });
}
