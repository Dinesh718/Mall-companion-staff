class PerformanceMetricsEntity {
  final double performanceScore;
  final double scoreTrend;
  final int completedTickets;
  final int pendingTickets;
  final int pendingTicketsTrend;
  final int avgResolutionTimeMinutes;
  final double avgResolutionTimeTrend;
  final double customerRating;
  final double efficiencyScore;
  final double efficiencyTrend;
  final String topPercentile;

  const PerformanceMetricsEntity({
    required this.performanceScore,
    required this.scoreTrend,
    required this.completedTickets,
    required this.pendingTickets,
    required this.pendingTicketsTrend,
    required this.avgResolutionTimeMinutes,
    required this.avgResolutionTimeTrend,
    required this.customerRating,
    required this.efficiencyScore,
    required this.efficiencyTrend,
    required this.topPercentile,
  });
}
