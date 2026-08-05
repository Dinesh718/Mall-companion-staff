import 'package:flutter/material.dart';
import '../../features/authentication/domain/entities/staff_profile_entity.dart';
import '../../features/authentication/domain/entities/staff_role.dart';
import '../../features/dashboard/presentation/pages/admin_dashboard_page.dart';
import '../../features/security_dashboard/presentation/pages/security_main_layout.dart';
import '../../features/maintenance/presentation/pages/maintenance_dashboard_page.dart';
import '../../features/dashboard/presentation/pages/store_manager_dashboard_page.dart';

class RoleRouter {
  RoleRouter._();

  static void routeToDashboard(BuildContext context, StaffProfileEntity profile) {
    Widget targetPage;

    switch (profile.role) {
      case StaffRole.admin:
        targetPage = const AdminDashboardPage();
        break;
      case StaffRole.security:
        targetPage = const SecurityMainLayout();
        break;
      case StaffRole.maintenance:
        targetPage = const MaintenanceDashboardPage();
        break;
      case StaffRole.storeManager:
        targetPage = const StoreManagerDashboardPage();
        break;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => targetPage),
      (route) => false,
    );
  }
}
