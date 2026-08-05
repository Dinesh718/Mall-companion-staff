class PerformanceSnapshotEntity {
  final int ticketsCompleted;
  final int averageResolutionTimeMinutes;
  final int attendancePercentage;
  final double rating;

  const PerformanceSnapshotEntity({
    required this.ticketsCompleted,
    required this.averageResolutionTimeMinutes,
    required this.attendancePercentage,
    required this.rating,
  });
}
