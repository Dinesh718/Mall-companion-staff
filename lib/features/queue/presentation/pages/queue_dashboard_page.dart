// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_loading_indicator.dart';
import '../../../../core/shared/presentation/widgets/app_error_state.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../data/repositories/mock_queue_repository.dart';
import '../../domain/usecases/load_queue_dashboard_usecase.dart';
import '../../domain/usecases/get_queue_details_usecase.dart';
import '../../domain/usecases/search_queue_usecase.dart';
import '../../domain/usecases/filter_queue_usecase.dart';
import '../../domain/usecases/sort_queue_usecase.dart';
import '../../domain/entities/queue_filter.dart';
import '../../domain/entities/queue_sort_option.dart';
import '../bloc/queue_bloc.dart';
import '../bloc/queue_event.dart';
import '../bloc/queue_state.dart';
import 'queue_details_page.dart';
import 'queue_analytics_page.dart';
import 'add_walk_in_customer_page.dart';
import '../widgets/queue_summary_section.dart';
import '../widgets/queue_overview_section.dart';
import '../widgets/queue_quick_actions_section.dart';
import '../widgets/queue_card.dart';
import '../widgets/queue_bottom_navigation.dart';
import '../widgets/queue_search_bar.dart';
import '../widgets/queue_sort_sheet.dart';

class QueueDashboardPage extends StatelessWidget {
  final bool showBackButton;

  const QueueDashboardPage({
    super.key,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockQueueRepository();

    return BlocProvider(
      create: (context) => QueueBloc(
        loadQueueDashboardUseCase: LoadQueueDashboardUseCase(mockRepo),
        getQueueDetailsUseCase: GetQueueDetailsUseCase(mockRepo),
        searchQueueUseCase: SearchQueueUseCase(mockRepo),
        filterQueueUseCase: FilterQueueUseCase(mockRepo),
        sortQueueUseCase: SortQueueUseCase(mockRepo),
      )..add(const LoadQueueDashboard()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF), // Lumina surface background
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(72.0),
          child: BlocBuilder<QueueBloc, QueueState>(
            builder: (context, state) {
              return AppBar(
                leadingWidth: showBackButton ? 56.0 : 16.0,
                automaticallyImplyLeading: false,
                leading: showBackButton
                    ? Padding(
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
                      )
                    : null,
                title: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Queue Dashboard',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      "Monitor today's customer queue",
                      style: TextStyle(
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
                  IconButton(
                    icon: const Icon(
                      Icons.analytics_outlined,
                      color: AppColors.primary,
                    ),
                    tooltip: 'Queue Analytics',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QueueAnalyticsPage(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.onSurfaceVariant,
                    ),
                    onPressed: () {
                      context.read<QueueBloc>().add(const RefreshQueueDashboard());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Checking for new bookings...'),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.onSurfaceVariant,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No new notifications'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.outlineVariant,
                          width: 1.5,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDyIrvZ59L3Bj0ko3yg-m5fSuHBP0aqGy0ZicdNegWbYd6b9BFFkfQy_eJeoourQaAn7lp1-EBV0D7h0Njz8GAKDKJikuVNWo6a-HmO04yNjvtRibQz5UYNAA3-WYGqhnuXaA5yBb1pkExh97EReU3_jdAmsIofIBt8JDtPwRXqP5lO_QfwWSPPfBcpXHLc2jEw4lY1y0SIB6fnEq1dSFP1fJf3ST8NQ4LT85c1PEhD-RxKk2Pm6wrZoZ9XYYHesWkfZTDrpwmp7A',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.account_circle,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        body: BlocBuilder<QueueBloc, QueueState>(
          builder: (context, state) {
            if (state is QueueLoading || state is QueueInitial) {
              return const Center(
                child: AppLoadingIndicator(),
              );
            } else if (state is QueueError) {
              return Center(
                child: AppErrorState(
                  message: state.errorMessage,
                  onRetry: () {
                    context.read<QueueBloc>().add(const LoadQueueDashboard());
                  },
                ),
              );
            } else if (state is QueueLoaded) {
              final queue = state.queue;
              final summary = state.summary;

              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      context.read<QueueBloc>().add(const RefreshQueueDashboard());
                    },
                    color: AppColors.primary,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 24.0, bottom: showBackButton ? 100.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 1. Summary card
                            QueueSummarySection(summary: summary),
                            const SizedBox(height: 24.0),

                            // 2. Responsive Overview & Quick Actions layout
                            LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth > 720) {
                                  // Landscape / Desktop / Tablet layout
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: QueueOverviewSection(summary: summary),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: QueueQuickActionsSection(
                                         onAddWalkIn: () async {
                                          final added = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddWalkInCustomerPage(summary: summary),
                                            ),
                                          );
                                          if (added == true && context.mounted) {
                                            context.read<QueueBloc>().add(const RefreshQueueDashboard());
                                          }
                                        },
                                          onRefresh: () => context.read<QueueBloc>().add(const RefreshQueueDashboard()),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  // Mobile layout
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      QueueOverviewSection(summary: summary),
                                      const SizedBox(height: 24.0),
                                      QueueQuickActionsSection(
                                          onAddWalkIn: () async {
                                            final added = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddWalkInCustomerPage(summary: summary),
                                              ),
                                            );
                                            if (added == true && context.mounted) {
                                              context.read<QueueBloc>().add(const RefreshQueueDashboard());
                                            }
                                          },
                                        onRefresh: () => context.read<QueueBloc>().add(const RefreshQueueDashboard()),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 24.0),

                            // Search & Filter
                            QueueSearchBar(
                              activeFilter: state.selectedFilter,
                              searchQuery: state.searchQuery,
                            ),
                            const SizedBox(height: 16.0),

                            // Active Filter Chip
                            if (state.selectedFilter != QueueFilter.all)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(99.0),
                                        border: Border.all(
                                          color: AppColors.primary.withOpacity(0.2),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Showing: ${state.selectedFilter.toDisplayString()}',
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          const SizedBox(width: 6.0),
                                          GestureDetector(
                                            onTap: () {
                                              context.read<QueueBloc>().add(const FilterChanged(QueueFilter.all));
                                            },
                                            child: const Icon(
                                              Icons.close_rounded,
                                              size: 14.0,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (state.selectedFilter != QueueFilter.all)
                              const SizedBox(height: 16.0),

                            // 3. Current Queue Header
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Current Queue (${queue.length})',
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 2.0),
                                      const Text(
                                        'Customers waiting for service',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12.0,
                                          color: AppColors.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      TextButton.icon(
                                        onPressed: () async {
                                          final selectedSort = await showModalBottomSheet<QueueSortOption>(
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (sheetContext) => QueueSortSheet(activeSort: state.selectedSort),
                                          );
                                          if (selectedSort != null && context.mounted) {
                                            context.read<QueueBloc>().add(SortChanged(selectedSort));
                                          }
                                        },
                                        icon: const Icon(Icons.sort_rounded, size: 16.0),
                                        label: Text(
                                          state.selectedSort.toDisplayString(),
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          foregroundColor: AppColors.primary,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => _showMockMessage(context, 'See All (mock placeholder)'),
                                        child: const Text(
                                          'See All',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12.0),

                            // 4. Current Queue Grid
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: queue.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                                      child: EmptyStateWidget(
                                        title: 'No customer found.',
                                        description: 'Try another search.',
                                        icon: Icons.search_off_rounded,
                                        action: TextButton(
                                          onPressed: () {
                                            context.read<QueueBloc>().add(const ClearFilters());
                                          },
                                          child: const Text(
                                            'Clear Filters',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : LayoutBuilder(
                                      builder: (context, constraints) {
                                        final crossCount = constraints.maxWidth > 600 ? 2 : 1;
                                        return GridView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: crossCount,
                                            crossAxisSpacing: 16.0,
                                            mainAxisSpacing: 16.0,
                                            mainAxisExtent: 312.0,
                                          ),
                                          itemCount: queue.length,
                                          itemBuilder: (context, index) {
                                            final item = queue[index];
                                            return QueueCard(
                                              queue: item,
                                              onViewDetails: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => QueueDetailsPage(queueId: item.id),
                                                  ),
                                                );
                                              },
                                              onCallCustomer: () => _showMockMessage(context, 'Calling customer ${item.customerName}...'),
                                            );
                                          },
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom navigation bar
                  if (showBackButton)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: QueueBottomNavigation(
                        onStoreTap: () => Navigator.pop(context),
                        onOffersTap: () {
                          // Pop and switch tab in parent or pop
                          Navigator.pop(context);
                        },
                      ),
                    ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showMockMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
