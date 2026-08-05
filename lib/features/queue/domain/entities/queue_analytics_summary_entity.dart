class QueueAnalyticsSummaryEntity {
  final int todayVisitors;
  final double todayVisitorsChange;
  final int avgServiceTimeMinutes;
  final double avgServiceTimeChange;
  final int cancelledCount;
  final double cancelledChange;
  final String peakHour;
  final String peakHourLabel;

  const QueueAnalyticsSummaryEntity({
    required this.todayVisitors,
    required this.todayVisitorsChange,
    required this.avgServiceTimeMinutes,
    required this.avgServiceTimeChange,
    required this.cancelledCount,
    required this.cancelledChange,
    required this.peakHour,
    required this.peakHourLabel,
  });
}
