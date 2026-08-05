import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../data/repositories/mock_maintenance_repository.dart';
import '../../domain/usecases/get_activity_history_usecase.dart';
import '../bloc/activity/activity_bloc.dart';
import '../bloc/activity/activity_event.dart';
import '../bloc/activity/activity_state.dart';
import '../widgets/activity/activity_header.dart';
import '../widgets/activity/activity_summary_section.dart';
import '../widgets/activity/activity_timeline_card.dart';
import '../widgets/shared/maintenance_filter_chips.dart';
import '../widgets/shared/maintenance_search_bar.dart';
import '../widgets/shared/maintenance_filter_sheet.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityBloc(
        repository: MockMaintenanceRepository(),
        getActivityHistoryUseCase: GetActivityHistoryUseCase(
          repository: MockMaintenanceRepository(),
        ),
      )..add(const LoadActivityHistory()),
      child: const _ActivityView(),
    );
  }
}

class _ActivityView extends StatelessWidget {
  const _ActivityView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) {
        if (state is ActivityLoading || state is ActivityInitial) {
          return const Scaffold(
            backgroundColor: AppColors.stitchBackground,
            body: Center(
              child: LoadingWidget(message: 'Loading activity...'),
            ),
          );
        } else if (state is ActivityError) {
          return Scaffold(
            backgroundColor: AppColors.stitchBackground,
            body: Center(
              child: AppErrorWidget(
                message: state.errorMessage,
                onRetry: () {
                  context.read<ActivityBloc>().add(const LoadActivityHistory());
                },
              ),
            ),
          );
        } else if (state is ActivityLoaded) {
          return Scaffold(
            backgroundColor: AppColors.stitchBackground,
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<ActivityBloc>().add(const LoadActivityHistory());
              },
              color: AppColors.primary,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 48.0), // Status bar padding
                        const ActivityHeader(),
                        const SizedBox(height: 16.0),
                        const ActivitySummarySection(),
                        const SizedBox(height: 8.0),
                        MaintenanceSearchBar(
                          searchQuery: state.searchQuery,
                          placeholder: 'Search ticket, issue or location',
                          onSearchChanged: (query) {
                            context.read<ActivityBloc>().add(SearchActivityRequested(query));
                          },
                          onClearSearch: () {
                            context.read<ActivityBloc>().add(const SearchActivityRequested(''));
                          },
                          onFilterTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (bottomSheetContext) => MaintenanceFilterSheet(
                                initialFilters: state.activeFilters,
                                onApplyFilters: (filters) {
                                  if (filters.isEmpty) {
                                    context.read<ActivityBloc>().add(const ClearFiltersRequested());
                                  } else {
                                    context.read<ActivityBloc>().add(ApplyFiltersRequested(filters));
                                  }
                                },
                              ),
                            );
                          },
                        ),
                        MaintenanceFilterChips(
                          activeFilters: state.activeFilters,
                          onRemoveFilter: (filter) {
                            context.read<ActivityBloc>().add(RemoveFilterRequested(filter));
                          },
                          onClearFilters: () {
                            context.read<ActivityBloc>().add(const ClearFiltersRequested());
                          },
                        ),
                      ],
                    ),
                  ),
                  if (state.filteredActivities.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: EmptyStateWidget(
                          title: 'No Activity Found',
                          description: 'Try adjusting your search or filters.',
                          icon: Icons.history_rounded,
                          action: ElevatedButton(
                            onPressed: () {
                              context.read<ActivityBloc>().add(const ClearFiltersRequested());
                            },
                            child: const Text('Clear Filters'),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            // Logic to group by date
                            final item = state.filteredActivities[index];
                            final isFirstInGroup = index == 0 ||
                                state.filteredActivities[index - 1].dateGroup != item.dateGroup;
                            final isLast = index == state.filteredActivities.length - 1;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isFirstInGroup)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 24.0, top: index == 0 ? 8.0 : 16.0),
                                    child: Text(
                                      item.dateGroup,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                ActivityTimelineCard(
                                  item: item,
                                  isLast: isLast || (index < state.filteredActivities.length - 1 && 
                                          state.filteredActivities[index + 1].dateGroup != item.dateGroup),
                                ),
                              ],
                            );
                          },
                          childCount: state.filteredActivities.length,
                        ),
                      ),
                    ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100.0), // Extra bottom padding for navigation bar
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
