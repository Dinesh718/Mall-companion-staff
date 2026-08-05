import 'queue_analytics_summary_entity.dart';
import 'queue_status_distribution_entity.dart';
import 'hourly_queue_trend_entity.dart';
import 'performance_metrics_entity.dart';
import 'insight_entity.dart';
import 'staff_performance_entity.dart';

class QueueAnalyticsEntity {
  final int todayCustomersCount;
  final int completedCount;
  final double completedChange;
  final int waitingCount;
  final int avgWaitMinutes;
  final String avgWaitStatus;
  final DateTime lastUpdated;
  final QueueAnalyticsSummaryEntity summary;
  final List<QueueStatusDistributionEntity> distribution;
  final List<HourlyQueueTrendEntity> hourlyTrends;
  final PerformanceMetricsEntity performance;
  final List<InsightEntity> insights;
  final StaffPerformanceEntity staffPerformance;

  const QueueAnalyticsEntity({
    required this.todayCustomersCount,
    required this.completedCount,
    required this.completedChange,
    required this.waitingCount,
    required this.avgWaitMinutes,
    required this.avgWaitStatus,
    required this.lastUpdated,
    required this.summary,
    required this.distribution,
    required this.hourlyTrends,
    required this.performance,
    required this.insights,
    required this.staffPerformance,
  });
}
