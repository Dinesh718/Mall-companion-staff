import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/queue/data/repositories/mock_queue_repository.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_analytics_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_analytics_summary_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_status_distribution_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/hourly_queue_trend_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/performance_metrics_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/insight_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/staff_performance_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/get_queue_analytics_usecase.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_analytics_bloc.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_analytics_event.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_analytics_state.dart';
import 'package:mall_companion_staff/features/queue/presentation/pages/queue_analytics_page.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/queue_distribution_chart_widget.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/hourly_trend_chart_widget.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/queue_analytics_hero_card.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/queue_analytics_kpi_grid.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/queue_performance_metrics_card.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/queue_key_insights_card.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/staff_performance_card.dart';

void main() {
  late MockQueueRepository repository;
  late GetQueueAnalyticsUseCase getAnalyticsUseCase;
  late QueueAnalyticsBloc bloc;

  setUp(() {
    repository = MockQueueRepository(populateAll: true);
    getAnalyticsUseCase = GetQueueAnalyticsUseCase(repository);
    bloc = QueueAnalyticsBloc(getQueueAnalyticsUseCase: getAnalyticsUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('Queue Analytics Domain & Data Layer Tests', () {
    test('GetQueueAnalyticsUseCase fetches data successfully for range', () async {
      final analytics = await getAnalyticsUseCase(range: 'Today');
      expect(analytics.todayCustomersCount, 124);
      expect(analytics.completedCount, 86);
      expect(analytics.waitingCount, 32);
      expect(analytics.avgWaitMinutes, 12);
      expect(analytics.summary.peakHour, '1 PM');
    });

    test('MockQueueRepository returns different datasets based on range filter', () async {
      final yesterdayAnalytics = await repository.getQueueAnalytics(range: 'Yesterday');
      expect(yesterdayAnalytics.todayCustomersCount, 110);
      expect(yesterdayAnalytics.completedCount, 75);
      expect(yesterdayAnalytics.waitingCount, 0);
      expect(yesterdayAnalytics.summary.peakHour, '2 PM');

      final weeklyAnalytics = await repository.getQueueAnalytics(range: 'This Week');
      expect(weeklyAnalytics.todayCustomersCount, 780);
      expect(weeklyAnalytics.completedCount, 590);
      expect(weeklyAnalytics.summary.peakHour, '12 PM');
    });
  });

  group('Queue Analytics BLoC State Transitions Tests', () {
    test('LoadQueueAnalytics transitions to loaded state with correct range data', () async {
      bloc.add(const LoadQueueAnalytics(range: 'Today'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          const QueueAnalyticsLoading(),
          isA<QueueAnalyticsLoaded>().having((s) => s.range, 'range', 'Today')
              .having((s) => s.analytics.todayCustomersCount, 'todayCustomersCount', 124),
        ]),
      );
    });

    test('ChangeDateRange transitions range and triggers new data load', () async {
      bloc.add(const ChangeDateRange(newRange: 'Yesterday'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          const QueueAnalyticsLoading(),
          isA<QueueAnalyticsLoaded>().having((s) => s.range, 'range', 'Yesterday')
              .having((s) => s.analytics.todayCustomersCount, 'todayCustomersCount', 110),
        ]),
      );
    });

    test('RefreshQueueAnalytics triggers reload of data', () async {
      bloc.add(const RefreshQueueAnalytics(range: 'This Week'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          const QueueAnalyticsLoading(),
          isA<QueueAnalyticsLoaded>().having((s) => s.range, 'range', 'This Week')
              .having((s) => s.analytics.todayCustomersCount, 'todayCustomersCount', 780),
        ]),
      );
    });
  });

  group('Queue Analytics Widgets Rendering Tests', () {
    testWidgets('QueueAnalyticsHeroCard renders completely with stats', (WidgetTester tester) async {
      final now = DateTime.now();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QueueAnalyticsHeroCard(
              totalCustomers: 124,
              completedCount: 86,
              completedChange: 0.12,
              waitingCount: 32,
              avgWaitMinutes: 12,
              avgWaitStatus: 'Optimal',
              lastUpdated: now.subtract(const Duration(minutes: 2)),
            ),
          ),
        ),
      );

      expect(find.text("TODAY'S CUSTOMERS"), findsOneWidget);
      expect(find.text("124"), findsOneWidget);
      expect(find.text("Users"), findsOneWidget);
      expect(find.text("COMPLETED"), findsOneWidget);
      expect(find.text("86"), findsOneWidget);
      expect(find.text("LIVE"), findsOneWidget);
      expect(find.text("12m"), findsOneWidget);
      expect(find.text("Optimal"), findsOneWidget);
    });

    testWidgets('QueueDistributionChartWidget renders and draws donut labels', (WidgetTester tester) async {
      final analytics = _createMockAnalytics();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QueueDistributionChartWidget(
              distribution: analytics.distribution,
              totalUsers: analytics.todayCustomersCount,
            ),
          ),
        ),
      );

      expect(find.text("Queue Distribution"), findsOneWidget);
      expect(find.text("124"), findsOneWidget);
      expect(find.text("TOTAL USERS"), findsOneWidget);
      expect(find.text("Waiting"), findsOneWidget);
      expect(find.text("Serving"), findsOneWidget);
      expect(find.text("Cancelled"), findsOneWidget);
    });

    testWidgets('HourlyTrendChartWidget renders line chart and hour labels', (WidgetTester tester) async {
      final analytics = _createMockAnalytics();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HourlyTrendChartWidget(trends: analytics.hourlyTrends),
          ),
        ),
      );

      expect(find.text("Hourly Trend"), findsOneWidget);
      expect(find.text("Today"), findsOneWidget);
      expect(find.text("Average"), findsOneWidget);
      expect(find.text("10A"), findsOneWidget);
      expect(find.text("12P"), findsOneWidget);
      expect(find.text("01P"), findsOneWidget);
      expect(find.text("04P"), findsOneWidget);
    });

    testWidgets('QueueAnalyticsPage renders loading skeleton then full content', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: QueueAnalyticsPage(),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await Future.delayed(const Duration(milliseconds: 150));
        await tester.pump();
      });

      expect(find.text('Queue Analytics'), findsOneWidget);
      expect(find.text("Today's Queue Performance"), findsOneWidget);
      expect(find.byType(QueueAnalyticsHeroCard), findsOneWidget);
      expect(find.byType(QueueAnalyticsKpiGrid), findsOneWidget);
      expect(find.byType(QueueDistributionChartWidget), findsOneWidget);
      expect(find.byType(HourlyTrendChartWidget), findsOneWidget);
      expect(find.byType(QueuePerformanceMetricsCard), findsOneWidget);
      expect(find.byType(QueueKeyInsightsCard), findsOneWidget);
      expect(find.byType(StaffPerformanceCard), findsOneWidget);
      expect(find.text('Export Report'), findsOneWidget);
      expect(find.text('Refresh Analytics'), findsOneWidget);
    });
  });
}

QueueAnalyticsEntity _createMockAnalytics() {
  return QueueAnalyticsEntity(
    todayCustomersCount: 124,
    completedCount: 86,
    completedChange: 0.12,
    waitingCount: 32,
    avgWaitMinutes: 12,
    avgWaitStatus: 'Optimal',
    lastUpdated: DateTime.now(),
    summary: const QueueAnalyticsSummaryEntity(
      todayVisitors: 124,
      todayVisitorsChange: 0.08,
      avgServiceTimeMinutes: 18,
      avgServiceTimeChange: -0.04,
      cancelledCount: 5,
      cancelledChange: -0.02,
      peakHour: '1 PM',
      peakHourLabel: 'Daily Peak',
    ),
    distribution: const [
      QueueStatusDistributionEntity(status: 'Waiting', count: 42, colorHex: '6100D6', percentage: 0.35),
      QueueStatusDistributionEntity(status: 'Serving', count: 18, colorHex: 'FFB68E', percentage: 0.15),
      QueueStatusDistributionEntity(status: 'Cancelled', count: 5, colorHex: 'BA1A1A', percentage: 0.05),
    ],
    hourlyTrends: const [
      HourlyQueueTrendEntity(hourLabel: '10A', todayCount: 15, averageCount: 12),
      HourlyQueueTrendEntity(hourLabel: '12P', todayCount: 30, averageCount: 22),
      HourlyQueueTrendEntity(hourLabel: '01P', todayCount: 45, averageCount: 25),
      HourlyQueueTrendEntity(hourLabel: '04P', todayCount: 20, averageCount: 18),
    ],
    performance: const PerformanceMetricsEntity(
      completionRate: 0.94,
      completionRateLabel: 'Above Target Performance',
      cancellationRate: 0.04,
      cancellationRateLabel: 'Within Expected Range',
      isStable: true,
      stabilityMessage: 'System is Stable with high routing efficiency.',
    ),
    insights: const [
      InsightEntity(
        type: 'peak_activity',
        title: 'Peak Activity',
        description: 'Max queue length at 1:00 PM with 45 users.',
        colorHex: '7B2FF7',
      ),
    ],
    staffPerformance: const StaffPerformanceEntity(
      activeStaffCount: 5,
      avgCustomersServedPerStaff: 24,
      fastestServiceMinutes: 8,
      teamEfficiency: 0.88,
    ),
  );
}
