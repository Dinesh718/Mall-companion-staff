import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../bloc/security_dashboard_bloc.dart';
import '../bloc/security_dashboard_event.dart';
import '../bloc/security_dashboard_state.dart';
import '../widgets/security_hero_card.dart';
import '../widgets/emergency_alerts_section.dart';
import '../widgets/team_status_section.dart';
import '../widgets/active_incident_section.dart';
import '../widgets/patrol_progress_section.dart';
import '../widgets/equipment_status_section.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/performance_grid.dart';
import '../widgets/recent_activity_timeline.dart';
import '../widgets/current_shift_summary.dart';

class SecurityDashboardPage extends StatefulWidget {
  const SecurityDashboardPage({super.key});

  @override
  State<SecurityDashboardPage> createState() => _SecurityDashboardPageState();
}

class _SecurityDashboardPageState extends State<SecurityDashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<SecurityDashboardBloc>().add(const LoadSecurityDashboardRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: BlocBuilder<SecurityDashboardBloc, SecurityDashboardState>(
        builder: (context, state) {
          if (state is SecurityDashboardLoading || state is SecurityDashboardInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is SecurityDashboardError) {
            return _buildErrorState(context, state.message);
          } else if (state is SecurityDashboardLoaded) {
            final data = state.dashboardData;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<SecurityDashboardBloc>().add(const RefreshSecurityDashboardRequested());
              },
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SecurityHeroCard(officer: data.officer, metrics: data.heroMetrics),
                      const SizedBox(height: 24.0),
                      
                      EmergencyAlertsSection(
                        alerts: data.emergencyAlerts,
                        onViewAll: () {},
                        onNavigate: (alert) {},
                      ),
                      const SizedBox(height: 24.0),
                      
                      TeamStatusSection(teamStatus: data.teamStatus),
                      const SizedBox(height: 24.0),
                      
                      ActiveIncidentSection(
                        activeIncident: data.activeIncident,
                        onRespond: () {},
                      ),
                      const SizedBox(height: 24.0),
                      
                      PatrolProgressSection(patrolProgress: data.patrolProgress),
                      const SizedBox(height: 24.0),
                      
                      EquipmentStatusSection(equipmentStatus: data.equipmentStatus),
                      const SizedBox(height: 24.0),
                      
                      const QuickActionsGrid(),
                      const SizedBox(height: 24.0),
                      
                      PerformanceGrid(performance: data.performanceSummary),
                      const SizedBox(height: 24.0),
                      
                      RecentActivityTimeline(activities: data.recentActivity),
                      const SizedBox(height: 24.0),
                      
                      CurrentShiftSummary(shiftSummary: data.shiftSummary),
                      
                      // Extra padding for bottom nav
                      const SizedBox(height: 80.0),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface.withAlpha(204), // 80% opacity
      elevation: 0,
      scrolledUnderElevation: 4.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Security Dashboard',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
          ),
          Text(
            'Security Staff',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: AppColors.onSurfaceVariant),
              onPressed: () {},
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2.0),
                ),
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: AppColors.onSurfaceVariant),
          onPressed: () {},
        ),
        const SizedBox(width: 8.0),
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
          const Text(
            'Failed to load dashboard',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: AppColors.outline,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () => context.read<SecurityDashboardBloc>().add(const LoadSecurityDashboardRequested()),
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
