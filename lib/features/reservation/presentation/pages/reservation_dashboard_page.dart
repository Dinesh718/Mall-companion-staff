import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../data/repositories/mock_reservation_repository.dart';
import '../../domain/usecases/get_reservation_summary_usecase.dart';
import '../../domain/usecases/get_reservation_statistics_usecase.dart';
import '../../domain/usecases/get_today_reservations_usecase.dart';
import '../bloc/reservation_dashboard_bloc.dart';
import '../bloc/reservation_dashboard_event.dart';
import '../bloc/reservation_dashboard_state.dart';
import '../widgets/reservation_summary_card.dart';
import '../widgets/reservation_card.dart';
import '../widgets/reservation_greeting_header.dart';
import '../widgets/reservation_quick_actions.dart';
import '../widgets/operations_insight_card.dart';
import '../widgets/upcoming_reservations_list.dart';
import '../widgets/occupancy_chart.dart';
import '../../../dashboard/presentation/widgets/bottom_navigation.dart';
import 'reservation_details_page.dart';

class ReservationDashboardPage extends StatelessWidget {
  final bool showBackButton;

  const ReservationDashboardPage({
    super.key,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final repository = MockReservationRepository();

    return BlocProvider(
      create: (_) => ReservationDashboardBloc(
        getSummaryUseCase: GetReservationSummaryUseCase(repository),
        getStatisticsUseCase: GetReservationStatisticsUseCase(repository),
        getReservationsUseCase: GetTodayReservationsUseCase(repository),
      )..add(const LoadReservationDashboard()),
      child: Scaffold(
        backgroundColor: AppColors.stitchBackground,
        appBar: AppBar(
          title: const Text(
            'Reservations',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.stitchBackground,
          foregroundColor: AppColors.onSurface,
          elevation: 0,
          leading: showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert_rounded),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<ReservationDashboardBloc, ReservationDashboardState>(
          builder: (context, state) {
            if (state is ReservationDashboardLoading || state is ReservationDashboardInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state is ReservationDashboardError) {
              return _buildErrorState(context, state.message);
            } else if (state is ReservationDashboardLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ReservationDashboardBloc>().add(const RefreshReservationDashboard());
                },
                color: AppColors.primary,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ReservationGreetingHeader(totalReservations: state.summary.totalReservations),
                            ReservationSummaryCard(summary: state.summary),
                            const ReservationQuickActionsRow(),
                            
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final bool isDesktop = constraints.maxWidth > 800;
                                  
                                  if (isDesktop) {
                                    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: _buildTodayReservations(context, state),
                                        ),
                                        const SizedBox(width: 32.0),
                                        Expanded(
                                          flex: 1,
                                          child: _buildRightSidebar(context, state),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        _buildTodayReservations(context, state),
                                        const SizedBox(height: 32.0),
                                        _buildRightSidebar(context, state),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!showBackButton)
                      BottomNavigation(
                        selectedIndex: 3,
                        onTap: (index) {
                          if (index != 3) Navigator.pop(context);
                        },
                        items: const [
                          BottomNavigationItemData(
                            icon: Icons.dashboard_outlined,
                            activeIcon: Icons.dashboard_rounded,
                            label: 'Dashboard',
                          ),
                          BottomNavigationItemData(
                            icon: Icons.local_offer_outlined,
                            activeIcon: Icons.local_offer_rounded,
                            label: 'Offers',
                          ),
                          BottomNavigationItemData(
                            icon: Icons.queue_outlined,
                            activeIcon: Icons.queue_rounded,
                            label: 'Queue',
                          ),
                          BottomNavigationItemData(
                            icon: Icons.account_circle_outlined,
                            activeIcon: Icons.account_circle_rounded,
                            label: 'Profile',
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
              ),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(76),
                  blurRadius: 15.0,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 32.0),
          ),
        ),
      ),
    );
  }

  Widget _buildTodayReservations(BuildContext context, ReservationDashboardLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's Reservations",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurface,
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Text(
                'Filter',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              label: const Icon(Icons.filter_list_rounded, size: 18.0),
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        if (state.todayReservations.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(
              child: Text(
                'No reservations for today.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          )
        else ...[
          ...state.todayReservations.map((res) => ReservationCard(
            reservation: res,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReservationDetailsPage(reservationId: res.id),
                ),
              );
            },
          )),
          const SizedBox(height: 16.0),
          const OperationsInsightCard(),
        ],
      ],
    );
  }

  Widget _buildRightSidebar(BuildContext context, ReservationDashboardLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upcoming Next",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 16.0),
        UpcomingReservationsList(
          reservations: state.todayReservations.take(3).toList(),
        ),
        const SizedBox(height: 32.0),
        const Text(
          "Occupancy Load",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 16.0),
        OccupancyChart(occupancyData: state.statistics.hourlyOccupancy),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 60.0),
          const SizedBox(height: 16.0),
          Text(
            'Failed to load dashboard',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Inter', color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () => context.read<ReservationDashboardBloc>().add(const LoadReservationDashboard()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
