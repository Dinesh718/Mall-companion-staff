import 'package:equatable/equatable.dart';
import 'maintenance_ticket_entity.dart';
import 'maintenance_activity_entity.dart';

class MaintenanceDashboardEntity extends Equatable {
  final String staffName;
  final String staffRole;
  
  // Hero Stats
  final int assignedCount;
  final int priorityCount;
  final int inProgressCount;
  final int completedCount;
  
  // Performance Summary
  final int resolvedToday;
  final int avgResolutionMins;
  final int slaCompliancePercent;
  final int pendingTasks;

  final List<MaintenanceTicketEntity> assignedTickets;
  final List<MaintenanceActivityEntity> recentActivity;

  const MaintenanceDashboardEntity({
    required this.staffName,
    required this.staffRole,
    required this.assignedCount,
    required this.priorityCount,
    required this.inProgressCount,
    required this.completedCount,
    required this.resolvedToday,
    required this.avgResolutionMins,
    required this.slaCompliancePercent,
    required this.pendingTasks,
    required this.assignedTickets,
    required this.recentActivity,
  });

  @override
  List<Object?> get props => [
        staffName,
        staffRole,
        assignedCount,
        priorityCount,
        inProgressCount,
        completedCount,
        resolvedToday,
        avgResolutionMins,
        slaCompliancePercent,
        pendingTasks,
        assignedTickets,
        recentActivity,
      ];
}
