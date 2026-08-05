class EmergencySummaryEntity {
  final int totalEmergencies;
  final int accepted;
  final int waiting;
  final int resolvedToday;
  final DateTime lastUpdatedTime;

  const EmergencySummaryEntity({
    required this.totalEmergencies,
    required this.accepted,
    required this.waiting,
    required this.resolvedToday,
    required this.lastUpdatedTime,
  });
}
