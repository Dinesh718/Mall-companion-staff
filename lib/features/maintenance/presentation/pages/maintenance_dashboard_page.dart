import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';

import '../../../dashboard/presentation/widgets/bottom_navigation.dart';
import '../../data/repositories/mock_maintenance_repository.dart';
import '../../domain/usecases/get_maintenance_dashboard_usecase.dart';
import '../bloc/dashboard/maintenance_dashboard_bloc.dart';
import '../bloc/dashboard/maintenance_dashboard_event.dart';
import '../bloc/dashboard/maintenance_dashboard_state.dart';
import '../widgets/maintenance_hero_card.dart';
import '../widgets/maintenance_quick_actions.dart';
import '../widgets/assigned_tickets_list.dart';
import '../widgets/performance_summary_section.dart';
import '../widgets/recent_activity_section.dart';
import 'assigned_tickets_page.dart';
import 'activity_page.dart';
import 'package:mall_companion_staff/features/profile/presentation/pages/profile_page.dart';
import 'package:mall_companion_staff/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:mall_companion_staff/features/profile/presentation/bloc/profile_event.dart';
import 'package:mall_companion_staff/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:mall_companion_staff/features/profile/data/repositories/mock_profile_repository.dart';
import 'package:mall_companion_staff/features/analytics/presentation/pages/analytics_page.dart';
import 'package:mall_companion_staff/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:mall_companion_staff/features/analytics/presentation/bloc/analytics_event.dart';
import 'package:mall_companion_staff/features/analytics/domain/usecases/get_analytics_usecase.dart';
import 'package:mall_companion_staff/features/analytics/data/repositories/mock_analytics_repository.dart';
import 'package:mall_companion_staff/features/notifications/presentation/pages/notifications_page.dart';
import 'package:mall_companion_staff/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:mall_companion_staff/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:mall_companion_staff/features/notifications/domain/usecases/mark_notification_read_usecase.dart';
import 'package:mall_companion_staff/features/notifications/data/repositories/mock_notification_repository.dart';
import 'package:mall_companion_staff/features/settings/presentation/pages/settings_page.dart';
import 'package:mall_companion_staff/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:mall_companion_staff/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:mall_companion_staff/features/settings/data/repositories/mock_settings_repository.dart';

class MaintenanceDashboardPage extends StatefulWidget {
  const MaintenanceDashboardPage({super.key});

  @override
  State<MaintenanceDashboardPage> createState() => _MaintenanceDashboardPageState();
}

class _MaintenanceDashboardPageState extends State<MaintenanceDashboardPage> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MaintenanceDashboardBloc(
        getMaintenanceDashboardUseCase: GetMaintenanceDashboardUseCase(
          repository: MockMaintenanceRepository(),
        ),
      )..add(const LoadMaintenanceDashboard()),
      child: Scaffold(
        backgroundColor: AppColors.stitchBackground,
        body: BlocBuilder<MaintenanceDashboardBloc, MaintenanceDashboardState>(
          builder: (context, state) {
            if (state is MaintenanceDashboardLoading || state is MaintenanceDashboardInitial) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF8B5CF6)),
              );
            } else if (state is MaintenanceDashboardError) {
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
                      'Failed to load dashboard',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
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
                        context.read<MaintenanceDashboardBloc>().add(const LoadMaintenanceDashboard());
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
            } else if (state is MaintenanceDashboardLoaded) {
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
                                context.read<MaintenanceDashboardBloc>().add(const RefreshMaintenanceDashboard());
                              },
                              color: const Color(0xFF8B5CF6),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 48.0), // Status bar padding
                                    _buildHeader(dashboard.staffName),
                                    const SizedBox(height: 24.0),
                                    MaintenanceHeroCard(dashboard: dashboard),
                                    const SizedBox(height: 24.0),
                                    const MaintenanceQuickActions(),
                                    const SizedBox(height: 32.0),
                                    AssignedTicketsList(tickets: dashboard.assignedTickets),
                                    const SizedBox(height: 32.0),
                                    PerformanceSummarySection(dashboard: dashboard),
                                    const SizedBox(height: 32.0),
                                    RecentActivitySection(activities: dashboard.recentActivity),
                                    const SizedBox(height: 40.0), // Bottom padding before nav
                                  ],
                                ),
                              ),
                            );
                          case 1:
                            return const AssignedTicketsPage();
                          case 2:
                            return const ActivityPage();
                          case 3:
                            return BlocProvider(
                              create: (context) => AnalyticsBloc(
                                getAnalyticsUseCase: GetAnalyticsUseCase(MockAnalyticsRepository()),
                              )..add(const LoadAnalyticsRequested()),
                              child: const AnalyticsPage(),
                            );
                          case 4:
                            return BlocProvider(
                              create: (context) => ProfileBloc(
                                getProfileUseCase: GetProfileUseCase(MockProfileRepository()),
                              )..add(const LoadProfileRequested()),
                              child: const ProfilePage(),
                            );
                          default:
                            return const SizedBox.shrink();
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
                        icon: Icons.grid_view_rounded,
                        activeIcon: Icons.grid_view_rounded,
                        label: 'Dashboard',
                      ),
                      BottomNavigationItemData(
                        icon: Icons.confirmation_number_outlined,
                        activeIcon: Icons.confirmation_number_rounded,
                        label: 'Tickets',
                      ),
                      BottomNavigationItemData(
                        icon: Icons.history_rounded,
                        activeIcon: Icons.history_rounded,
                        label: 'Activity',
                      ),
                      BottomNavigationItemData(
                        icon: Icons.insights_rounded,
                        activeIcon: Icons.insights_rounded,
                        label: 'Insights',
                      ),
                      BottomNavigationItemData(
                        icon: Icons.person_outline_rounded,
                        activeIcon: Icons.person_rounded,
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

  Widget _buildHeader(String staffName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 32.0,
            ),
          ),
          const SizedBox(width: 12.0),
          // Greeting & Chip
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning, $staffName',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE), // Light blue
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Text(
                    'MORNING SHIFT',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D4ED8), // Dark blue
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Icons
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            color: const Color(0xFF4B5563),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) {
                      final repo = MockNotificationRepository();
                      return NotificationsBloc(
                        getNotificationsUseCase: GetNotificationsUseCase(repository: repo),
                        markNotificationReadUseCase: MarkNotificationReadUseCase(repository: repo),
                      );
                    },
                    child: const NotificationsPage(),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            color: const Color(0xFF4B5563),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => SettingsBloc(
                      getSettingsUseCase: GetSettingsUseCase(
                        repository: MockSettingsRepository(),
                      ),
                    ),
                    child: const SettingsPage(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
