import '../entities/performance_metrics_entity.dart';
import '../entities/issue_category_entity.dart';
import '../entities/resolution_time_entity.dart';
import '../entities/achievement_entity.dart';
import '../entities/milestone_entity.dart';

abstract class AnalyticsRepository {
  Future<PerformanceMetricsEntity> getPerformanceMetrics(String timeRange);
  Future<List<double>> getProductivityTrend(String timeRange);
  Future<List<IssueCategoryEntity>> getIssueCategories(String timeRange);
  Future<List<double>> getWeeklyActivity(String timeRange);
  Future<List<String>> getSmartInsights(String timeRange);
  Future<List<ResolutionTimeEntity>> getResolutionTimeAnalysis(String timeRange);
  Future<List<AchievementEntity>> getAchievements();
  Future<List<MilestoneEntity>> getRecentMilestones();
}
