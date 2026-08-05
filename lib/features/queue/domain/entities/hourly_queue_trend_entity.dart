class HourlyQueueTrendEntity {
  final String hourLabel;
  final int todayCount;
  final int averageCount;

  const HourlyQueueTrendEntity({
    required this.hourLabel,
    required this.todayCount,
    required this.averageCount,
  });
}
