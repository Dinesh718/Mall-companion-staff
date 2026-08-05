class EmergencyOverviewEntity {
  final int activeEmergencies;
  final int criticalEmergencies;
  final int availableOfficers;
  final double averageResponseTimeMinutes;

  const EmergencyOverviewEntity({
    required this.activeEmergencies,
    required this.criticalEmergencies,
    required this.availableOfficers,
    required this.averageResponseTimeMinutes,
  });
}
