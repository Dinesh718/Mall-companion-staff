import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../dashboard/presentation/widgets/bottom_navigation.dart';
import '../bloc/security_dashboard_bloc.dart';
import '../../domain/usecases/get_security_dashboard_usecase.dart';
import '../../data/repositories/mock_security_dashboard_repository.dart';
import 'security_dashboard_page.dart';
import '../../../../features/incident_management/presentation/pages/incident_management_page.dart';
import '../../../../features/incident_management/presentation/bloc/incident_management_bloc.dart';
import '../../../../features/incident_management/domain/usecases/get_incidents_usecase.dart';
import '../../../../features/incident_management/domain/usecases/get_incident_summary_usecase.dart';
import '../../../../features/incident_management/domain/usecases/get_incident_overview_usecase.dart';
import '../../../../features/incident_management/data/repositories/mock_incident_repository.dart';
import '../../../../features/emergency_response/presentation/pages/emergency_response_page.dart';
import '../../../../features/emergency_response/presentation/bloc/emergency_response_bloc.dart';
import '../../../../features/emergency_response/domain/usecases/get_emergencies_usecase.dart';
import '../../../../features/emergency_response/domain/usecases/get_emergency_summary_usecase.dart';
import '../../../../features/emergency_response/domain/usecases/get_emergency_overview_usecase.dart';
import '../../../../features/emergency_response/data/repositories/mock_emergency_response_repository.dart';
import '../../../../features/emergency_hub/presentation/pages/emergency_hub_page.dart';
import '../../../../features/emergency_hub/presentation/bloc/emergency_hub_bloc.dart';
import '../../../../features/emergency_hub/domain/usecases/get_emergency_hub_data_usecase.dart';
import '../../../../features/emergency_hub/data/repositories/mock_emergency_hub_repository.dart';

class SecurityMainLayout extends StatefulWidget {
  const SecurityMainLayout({super.key});

  @override
  State<SecurityMainLayout> createState() => _SecurityMainLayoutState();
}

class _SecurityMainLayoutState extends State<SecurityMainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                switch (_currentIndex) {
                  case 0:
                    return BlocProvider(
                      create: (context) => SecurityDashboardBloc(
                        getSecurityDashboardUseCase: GetSecurityDashboardUseCase(
                          repository: MockSecurityDashboardRepository(),
                        ),
                      ),
                      child: const SecurityDashboardPage(),
                    );
                  case 1:
                    return BlocProvider(
                      create: (context) {
                        final repo = MockIncidentRepository();
                        return IncidentManagementBloc(
                          getIncidentsUseCase: GetIncidentsUseCase(repository: repo),
                          getIncidentOverviewUseCase: GetIncidentOverviewUseCase(repository: repo),
                          getIncidentSummaryUseCase: GetIncidentSummaryUseCase(repository: repo),
                        );
                      },
                      child: const IncidentManagementPage(),
                    );
                  case 2:
                    return BlocProvider(
                      create: (context) {
                        final repo = MockEmergencyResponseRepository();
                        return EmergencyResponseBloc(
                          getEmergenciesUseCase: GetEmergenciesUseCase(repository: repo),
                          getEmergencyOverviewUseCase: GetEmergencyOverviewUseCase(repository: repo),
                          getEmergencySummaryUseCase: GetEmergencySummaryUseCase(repository: repo),
                        );
                      },
                      child: const EmergencyResponsePage(),
                    );
                  case 3:
                    return BlocProvider(
                      create: (context) {
                        return EmergencyHubBloc(
                          getEmergencyHubDataUseCase: GetEmergencyHubDataUseCase(
                            repository: MockEmergencyHubRepository(),
                          ),
                        );
                      },
                      child: const EmergencyHubPage(),
                    );
                  case 4:
                    return const Center(child: Text('Profile Placeholder'));
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
          BottomNavigation(
            selectedIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationItemData(
                icon: Icons.dashboard_outlined,
                activeIcon: Icons.dashboard_rounded,
                label: 'Dashboard',
              ),
              BottomNavigationItemData(
                icon: Icons.warning_amber_outlined,
                activeIcon: Icons.warning_rounded,
                label: 'Incidents',
              ),
              BottomNavigationItemData(
                icon: Icons.security_outlined,
                activeIcon: Icons.security_rounded,
                label: 'Emergency',
              ),
              BottomNavigationItemData(
                icon: Icons.history_outlined,
                activeIcon: Icons.history_rounded,
                label: 'Activity',
              ),
              BottomNavigationItemData(
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
