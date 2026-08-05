import '../../domain/entities/achievement_entity.dart';
import '../../domain/entities/issue_category_entity.dart';
import '../../domain/entities/milestone_entity.dart';
import '../../domain/entities/performance_metrics_entity.dart';
import '../../domain/entities/resolution_time_entity.dart';
import '../../domain/repositories/analytics_repository.dart';

class MockAnalyticsRepository implements AnalyticsRepository {
  @override
  Future<PerformanceMetricsEntity> getPerformanceMetrics(String timeRange) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const PerformanceMetricsEntity(
      performanceScore: 94.0,
      scoreTrend: 8.0,
      completedTickets: 128,
      pendingTickets: 12,
      pendingTicketsTrend: 2,
      avgResolutionTimeMinutes: 42,
      avgResolutionTimeTrend: -5.0,
      customerRating: 4.8,
      efficiencyScore: 96.0,
      efficiencyTrend: 3.0,
      topPercentile: 'top 5%',
    );
  }

  @override
  Future<List<double>> getProductivityTrend(String timeRange) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [40.0, 60.0, 45.0, 85.0, 65.0, 95.0, 90.0, 100.0, 95.0, 110.0];
  }

  @override
  Future<List<IssueCategoryEntity>> getIssueCategories(String timeRange) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      IssueCategoryEntity(name: 'Electrical', count: 45, colorHex: '7c3aed'), // primary
      IssueCategoryEntity(name: 'Plumbing', count: 32, colorHex: '316bf3'),   // secondary
      IssueCategoryEntity(name: 'Cleaning', count: 20, colorHex: '0ea5e9'),   // sky-500
      IssueCategoryEntity(name: 'HVAC', count: 12, colorHex: 'f59e0b'),       // amber-500
      IssueCategoryEntity(name: 'Escalator', count: 10, colorHex: '10b981'),  // emerald-500
      IssueCategoryEntity(name: 'Other', count: 9, colorHex: 'cbd5e1'),       // slate-300
    ];
  }

  @override
  Future<List<double>> getWeeklyActivity(String timeRange) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [42, 28, 35, 22, 38, 15, 12]; // Mon-Sun
  }

  @override
  Future<List<String>> getSmartInsights(String timeRange) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      'Resolution time improved by 18% since last month.',
      'Electrical repairs are your strongest category.',
    ];
  }

  @override
  Future<List<ResolutionTimeEntity>> getResolutionTimeAnalysis(String timeRange) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const [
      ResolutionTimeEntity(categoryName: 'Electrical', averageTimeMinutes: 28, percentage: 0.40, colorHex: '7c3aed'),
      ResolutionTimeEntity(categoryName: 'Plumbing', averageTimeMinutes: 35, percentage: 0.55, colorHex: '316bf3'),
      ResolutionTimeEntity(categoryName: 'Cleaning', averageTimeMinutes: 15, percentage: 0.25, colorHex: '0ea5e9'),
      ResolutionTimeEntity(categoryName: 'HVAC', averageTimeMinutes: 58, percentage: 0.85, colorHex: 'f59e0b'),
    ];
  }

  @override
  Future<List<AchievementEntity>> getAchievements() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      AchievementEntity(iconEmoji: '🏅', title: 'Fast Responder', subtitle: 'Under 15m', isEarned: true),
      AchievementEntity(iconEmoji: '⭐', title: '100 Tickets', subtitle: 'Milestone', isEarned: false),
      AchievementEntity(iconEmoji: '⚡', title: 'Expert', subtitle: '98% Resolution', isEarned: true),
      AchievementEntity(iconEmoji: '🥇', title: 'Top Performer', subtitle: 'Rank #3', isEarned: true),
    ];
  }

  @override
  Future<List<MilestoneEntity>> getRecentMilestones() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      MilestoneEntity(
        iconName: 'military_tech',
        iconColorHex: 'ffffff',
        iconBgHex: '7c3aed',
        title: 'Completed 100 Tickets',
        subtitle: 'Achieved on Oct 24, 2023',
      ),
      MilestoneEntity(
        iconName: 'emoji_events',
        iconColorHex: 'ffffff',
        iconBgHex: '316bf3',
        title: 'Best Weekly Performance',
        subtitle: 'Reached 99% efficiency in Week 3',
      ),
      MilestoneEntity(
        iconName: 'schedule',
        iconColorHex: '7b7487',
        iconBgHex: 'e0e3e5',
        title: 'Perfect Attendance Streak',
        subtitle: '15 days without delay',
      ),
    ];
  }
}
