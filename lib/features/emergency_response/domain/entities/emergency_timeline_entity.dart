class EmergencyTimelineEntity {
  final String title;
  final DateTime timestamp;
  final bool isCompleted;
  final bool isCurrent;

  const EmergencyTimelineEntity({
    required this.title,
    required this.timestamp,
    this.isCompleted = false,
    this.isCurrent = false,
  });
}
