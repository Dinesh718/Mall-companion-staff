import '../entities/performance_metrics_entity.dart';
import '../entities/issue_category_entity.dart';
import '../entities/resolution_time_entity.dart';
import '../entities/achievement_entity.dart';
import '../entities/milestone_entity.dart';
import '../repositories/analytics_repository.dart';

class AnalyticsData {
  final PerformanceMetricsEntity metrics;
  final List<double> productivityTrend;
  final List<IssueCategoryEntity> categories;
  final List<double> weeklyActivity;
  final List<String> insights;
  final List<ResolutionTimeEntity> resolutionTimes;
  final List<AchievementEntity> achievements;
  final List<MilestoneEntity> milestones;

  AnalyticsData({
    required this.metrics,
    required this.productivityTrend,
    required this.categories,
    required this.weeklyActivity,
    required this.insights,
    required this.resolutionTimes,
    required this.achievements,
    required this.milestones,
  });
}

class GetAnalyticsUseCase {
  final AnalyticsRepository repository;

  GetAnalyticsUseCase(this.repository);

  Future<AnalyticsData> call(String timeRange) async {
    final results = await Future.wait([
      repository.getPerformanceMetrics(timeRange),
      repository.getProductivityTrend(timeRange),
      repository.getIssueCategories(timeRange),
      repository.getWeeklyActivity(timeRange),
      repository.getSmartInsights(timeRange),
      repository.getResolutionTimeAnalysis(timeRange),
      repository.getAchievements(),
      repository.getRecentMilestones(),
    ]);

    return AnalyticsData(
      metrics: results[0] as PerformanceMetricsEntity,
      productivityTrend: results[1] as List<double>,
      categories: results[2] as List<IssueCategoryEntity>,
      weeklyActivity: results[3] as List<double>,
      insights: results[4] as List<String>,
      resolutionTimes: results[5] as List<ResolutionTimeEntity>,
      achievements: results[6] as List<AchievementEntity>,
      milestones: results[7] as List<MilestoneEntity>,
    );
  }
}
