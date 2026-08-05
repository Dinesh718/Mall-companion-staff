// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_loading_indicator.dart';
import '../../../../core/shared/presentation/widgets/app_error_state.dart';
import '../../data/repositories/mock_queue_repository.dart';
import '../../domain/usecases/get_queue_analytics_usecase.dart';
import '../bloc/queue_analytics_bloc.dart';
import '../bloc/queue_analytics_event.dart';
import '../bloc/queue_analytics_state.dart';
import '../widgets/queue_analytics_filter_bar.dart';
import '../widgets/queue_analytics_hero_card.dart';
import '../widgets/queue_analytics_kpi_grid.dart';
import '../widgets/queue_distribution_chart_widget.dart';
import '../widgets/hourly_trend_chart_widget.dart';
import '../widgets/queue_performance_metrics_card.dart';
import '../widgets/queue_key_insights_card.dart';
import '../widgets/staff_performance_card.dart';

class QueueAnalyticsPage extends StatelessWidget {
  const QueueAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockQueueRepository(populateAll: true);
    final getAnalyticsUseCase = GetQueueAnalyticsUseCase(mockRepo);

    return BlocProvider(
      create: (context) => QueueAnalyticsBloc(
        getQueueAnalyticsUseCase: getAnalyticsUseCase,
      )..add(const LoadQueueAnalytics()),
      child: BlocBuilder<QueueAnalyticsBloc, QueueAnalyticsState>(
        builder: (context, state) {
          String rangeText = 'Today';
          if (state is QueueAnalyticsLoaded) {
            rangeText = state.range;
          }

          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FF),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(72.0),
              child: AppBar(
                leadingWidth: 56.0,
                automaticallyImplyLeading: false,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.primary,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Queue Analytics',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      _getSubtitle(rangeText),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                elevation: 0.5,
                actions: [
                  // Current Date Indicator
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF4FF),
                      borderRadius: BorderRadius.circular(99.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          color: AppColors.onSurfaceVariant,
                          size: 14.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          _getFormattedDate(rangeText),
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.onSurfaceVariant,
                    ),
                    onPressed: () {
                      context.read<QueueAnalyticsBloc>().add(RefreshQueueAnalytics(range: rangeText));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Refreshing analytics metrics...'),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  String _getSubtitle(String range) {
    switch (range.toLowerCase()) {
      case 'yesterday':
        return "Yesterday's Queue Performance";
      case 'this week':
        return "Weekly Queue Performance";
      default:
        return "Today's Queue Performance";
    }
  }

  String _getFormattedDate(String range) {
    final now = DateTime.now();
    if (range.toLowerCase() == 'yesterday') {
      final yesterday = now.subtract(const Duration(hours: 24));
      return _formatSimpleDate(yesterday);
    } else if (range.toLowerCase() == 'this week') {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      return '${_formatMonthDay(startOfWeek)} - ${_formatMonthDay(now)}';
    } else {
      return _formatSimpleDate(now);
    }
  }

  String _formatSimpleDate(DateTime dt) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final month = months[dt.month - 1];
    final day = dt.day.toString().padLeft(2, '0');
    final year = dt.year;
    return '$month $day, $year';
  }

  String _formatMonthDay(DateTime dt) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final month = months[dt.month - 1];
    final day = dt.day.toString().padLeft(2, '0');
    return '$month $day';
  }

  Widget _buildBody(BuildContext context, QueueAnalyticsState state) {
    if (state is QueueAnalyticsInitial || state is QueueAnalyticsLoading) {
      return const Center(child: AppLoadingIndicator());
    } else if (state is QueueAnalyticsError) {
      return AppErrorState(
        title: 'Failed to load analytics',
        message: state.message,
        onRetry: () {
          context.read<QueueAnalyticsBloc>().add(const LoadQueueAnalytics());
        },
      );
    } else if (state is QueueAnalyticsLoaded) {
      final analytics = state.analytics;
      final range = state.range;

      return SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Hero Analytics Card
              QueueAnalyticsHeroCard(
                totalCustomers: analytics.todayCustomersCount,
                completedCount: analytics.completedCount,
                completedChange: analytics.completedChange,
                waitingCount: analytics.waitingCount,
                avgWaitMinutes: analytics.avgWaitMinutes,
                avgWaitStatus: analytics.avgWaitStatus,
                lastUpdated: analytics.lastUpdated,
              ),
              const SizedBox(height: 20.0),

              // 2. Filter Bar
              QueueAnalyticsFilterBar(
                activeRange: range,
                onRangeChanged: (newRange) {
                  context.read<QueueAnalyticsBloc>().add(ChangeDateRange(newRange: newRange));
                },
                onCalendarTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Date picker placeholder'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                onFiltersTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Advanced filters placeholder'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),

              // 3. KPI Cards Grid
              QueueAnalyticsKpiGrid(summary: analytics.summary),
              const SizedBox(height: 20.0),

              // 4. Charts layout
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 720;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: QueueDistributionChartWidget(
                            distribution: analytics.distribution,
                            totalUsers: analytics.todayCustomersCount,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: HourlyTrendChartWidget(trends: analytics.hourlyTrends),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        QueueDistributionChartWidget(
                          distribution: analytics.distribution,
                          totalUsers: analytics.todayCustomersCount,
                        ),
                        const SizedBox(height: 20.0),
                        HourlyTrendChartWidget(trends: analytics.hourlyTrends),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 20.0),

              // 5. Bento grid segments: Performance, insights, staff
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 900;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: QueuePerformanceMetricsCard(performance: analytics.performance),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: QueueKeyInsightsCard(insights: analytics.insights),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: StaffPerformanceCard(staffPerformance: analytics.staffPerformance),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        QueuePerformanceMetricsCard(performance: analytics.performance),
                        const SizedBox(height: 20.0),
                        QueueKeyInsightsCard(insights: analytics.insights),
                        const SizedBox(height: 20.0),
                        StaffPerformanceCard(staffPerformance: analytics.staffPerformance),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 32.0),

              // 6. Bottom Action Buttons
              _buildBottomActions(context, range),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildBottomActions(BuildContext context, String range) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Export Report Button
        Expanded(
          child: Container(
            height: 48.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99.0),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
            child: TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Exporting report for "$range"...'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.download_rounded, size: 18.0),
              label: const Text(
                'Export Report',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        // Refresh Button
        Expanded(
          child: Container(
            height: 48.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColors.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(99.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryGradientStart.withOpacity(0.2),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<QueueAnalyticsBloc>().add(RefreshQueueAnalytics(range: range));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Refreshing analytics...'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.autorenew_rounded, size: 18.0),
              label: const Text(
                'Refresh Analytics',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
