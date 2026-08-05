import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../authentication/presentation/pages/authentication_page.dart';
import '../../../store_profile/presentation/pages/store_profile_page.dart';
import '../../../offers/presentation/pages/offers_dashboard_page.dart';
import '../../../queue/presentation/pages/queue_dashboard_page.dart';
import '../../data/repositories/mock_store_dashboard_repository.dart';
import '../bloc/store_dashboard_bloc.dart';
import '../bloc/store_dashboard_event.dart';
import '../bloc/store_dashboard_state.dart';
import '../../../../core/presentation/widgets/dashboard_greeting.dart';
import '../widgets/store_hero_card.dart';
import '../widgets/business_health_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/live_queue_card.dart';
import '../widgets/offers_carousel.dart';
import '../widgets/reservation_list.dart';
import '../widgets/bottom_navigation.dart';

class StoreManagerDashboardPage extends StatefulWidget {
  const StoreManagerDashboardPage({super.key});

  @override
  State<StoreManagerDashboardPage> createState() => _StoreManagerDashboardPageState();
}

class _StoreManagerDashboardPageState extends State<StoreManagerDashboardPage> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreDashboardBloc(
        repository: MockStoreDashboardRepository(),
      )..add(const LoadDashboard()),
      child: Scaffold(
        backgroundColor: AppColors.stitchBackground,
        appBar: _currentTab == 0
            ? AppBar(
                title: const Text(
                  'Store Manager Portal',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                elevation: 0.5,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout_rounded),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const AuthenticationPage()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              )
            : null,
        body: BlocBuilder<StoreDashboardBloc, StoreDashboardState>(
          builder: (context, state) {
            if (state is StoreDashboardLoading || state is StoreDashboardInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (state is StoreDashboardError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.error,
                      size: 60.0,
                    ),
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
                    Text(
                      state.errorMessage,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        context.read<StoreDashboardBloc>().add(const LoadDashboard());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            } else if (state is StoreDashboardLoaded) {
              final dashboard = state.dashboard;
              return Column(
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        switch (_currentTab) {
                          case 0:
                            return RefreshIndicator(
                              onRefresh: () async {
                                context.read<StoreDashboardBloc>().add(const RefreshDashboard());
                              },
                              color: AppColors.primary,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                                  child: Column(
                                    children: [
                                      DashboardGreeting(
                                        managerName: dashboard.managerName,
                                        managerRole: dashboard.managerRole,
                                      ),
                                      const SizedBox(height: 24.0),
                                      StoreHeroCard(dashboard: dashboard),
                                      const SizedBox(height: 24.0),
                                      BusinessHealthCard(dashboard: dashboard),
                                      const SizedBox(height: 24.0),
                                      const QuickActionsGrid(),
                                      const SizedBox(height: 24.0),
                                      LiveQueueCard(dashboard: dashboard),
                                      const SizedBox(height: 24.0),
                                      OffersCarousel(offers: dashboard.todayOffers),
                                      const SizedBox(height: 24.0),
                                      ReservationList(reservations: dashboard.todayReservations),
                                      const SizedBox(height: 32.0),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          case 1:
                            return const OffersDashboardPage(showBackButton: false);
                          case 2:
                            return const QueueDashboardPage(showBackButton: false);
                          case 3:
                            return const StoreProfilePage(showBackButton: false);
                          default:
                            return const Center(
                              child: Text(
                                'Bookings Content (Future Milestone)',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            );
                        }
                      },
                    ),
                  ),
                  BottomNavigation(
                    selectedIndex: _currentTab,
                    onTap: (index) {
                      setState(() {
                        _currentTab = index;
                      });
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
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
