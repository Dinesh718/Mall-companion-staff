import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../bloc/analytics_bloc.dart';
import '../bloc/analytics_event.dart';
import '../bloc/analytics_state.dart';
import '../widgets/analytics_hero_card.dart';
import '../widgets/time_range_selector.dart';
import '../widgets/kpi_summary_grid.dart';
import '../widgets/productivity_trend_card.dart';
import '../widgets/issue_categories_card.dart';
import '../widgets/weekly_activity_card.dart';
import '../widgets/smart_insights_card.dart';
import '../widgets/resolution_time_analysis_card.dart';
import '../widgets/achievements_card.dart';
import '../widgets/recent_milestones_card.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.stitchBackground,
      body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
        builder: (context, state) {
          if (state is AnalyticsLoading || state is AnalyticsInitial) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF8B5CF6)),
            );
          } else if (state is AnalyticsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: 60.0,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Failed to load analytics',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    state.message,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AnalyticsBloc>().add(const LoadAnalyticsRequested());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is AnalyticsLoaded) {
            final data = state.data;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AnalyticsBloc>().add(RefreshAnalyticsRequested());
              },
              color: const Color(0xFF8B5CF6),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // App Bar
                  SliverAppBar(
                    backgroundColor: AppColors.stitchBackground,
                    pinned: true,
                    elevation: 0,
                    scrolledUnderElevation: 1.0,
                    title: const Text(
                      'Performance Analytics',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                        letterSpacing: -0.02,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.file_download_outlined, color: AppColors.onSurface),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  // Body
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        TimeRangeSelector(
                          activeRange: state.activeTimeRange,
                          onRangeSelected: (range) {
                            context.read<AnalyticsBloc>().add(LoadAnalyticsRequested(timeRange: range));
                          },
                        ),
                        const SizedBox(height: 24.0),
                        AnalyticsHeroCard(metrics: data.metrics),
                        const SizedBox(height: 32.0),
                        KpiSummaryGrid(metrics: data.metrics),
                        const SizedBox(height: 32.0),
                        ProductivityTrendCard(trendData: data.productivityTrend),
                        const SizedBox(height: 32.0),
                        IssueCategoriesCard(categories: data.categories),
                        const SizedBox(height: 32.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: WeeklyActivityCard(weeklyActivity: data.weeklyActivity),
                        ),
                        const SizedBox(height: 32.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SmartInsightsCard(insights: data.insights),
                        ),
                        const SizedBox(height: 32.0),
                        ResolutionTimeAnalysisCard(resolutionTimes: data.resolutionTimes),
                        const SizedBox(height: 32.0),
                        AchievementsCard(achievements: data.achievements),
                        const SizedBox(height: 32.0),
                        RecentMilestonesCard(milestones: data.milestones),
                        const SizedBox(height: 48.0), // bottom padding before navigation bar
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
