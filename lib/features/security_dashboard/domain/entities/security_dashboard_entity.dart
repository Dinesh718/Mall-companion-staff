import 'package:equatable/equatable.dart';

class SecurityDashboardEntity extends Equatable {
  final SecurityOfficerEntity officer;
  final HeroMetricsEntity heroMetrics;
  final List<EmergencyAlertEntity> emergencyAlerts;
  final TeamStatusEntity teamStatus;
  final ActiveIncidentEntity? activeIncident;
  final PatrolProgressEntity patrolProgress;
  final EquipmentStatusEntity equipmentStatus;
  final PerformanceSummaryEntity performanceSummary;
  final List<ActivityTimelineEntity> recentActivity;
  final ShiftSummaryEntity shiftSummary;

  const SecurityDashboardEntity({
    required this.officer,
    required this.heroMetrics,
    required this.emergencyAlerts,
    required this.teamStatus,
    this.activeIncident,
    required this.patrolProgress,
    required this.equipmentStatus,
    required this.performanceSummary,
    required this.recentActivity,
    required this.shiftSummary,
  });

  @override
  List<Object?> get props => [
        officer,
        heroMetrics,
        emergencyAlerts,
        teamStatus,
        activeIncident,
        patrolProgress,
        equipmentStatus,
        performanceSummary,
        recentActivity,
        shiftSummary,
      ];
}

class SecurityOfficerEntity extends Equatable {
  final String name;
  final String employeeId;
  final String avatarUrl;
  final String role;
  final String assignedZone;
  final String currentShift;
  final String dutyStatus;

  const SecurityOfficerEntity({
    required this.name,
    required this.employeeId,
    required this.avatarUrl,
    required this.role,
    required this.assignedZone,
    required this.currentShift,
    required this.dutyStatus,
  });

  @override
  List<Object?> get props => [
        name,
        employeeId,
        avatarUrl,
        role,
        assignedZone,
        currentShift,
        dutyStatus,
      ];
}

class HeroMetricsEntity extends Equatable {
  final int activeIncidents;
  final double patrolProgressPercentage;
  final double averageResponseTimeMinutes;

  const HeroMetricsEntity({
    required this.activeIncidents,
    required this.patrolProgressPercentage,
    required this.averageResponseTimeMinutes,
  });

  @override
  List<Object?> get props => [
        activeIncidents,
        patrolProgressPercentage,
        averageResponseTimeMinutes,
      ];
}

enum AlertPriority { low, medium, high, critical }

class EmergencyAlertEntity extends Equatable {
  final String id;
  final String type;
  final String location;
  final DateTime time;
  final AlertPriority priority;
  final String status;

  const EmergencyAlertEntity({
    required this.id,
    required this.type,
    required this.location,
    required this.time,
    required this.priority,
    required this.status,
  });

  @override
  List<Object?> get props => [id, type, location, time, priority, status];
}

class TeamStatusEntity extends Equatable {
  final int available;
  final int responding;
  final int offDuty;

  const TeamStatusEntity({
    required this.available,
    required this.responding,
    required this.offDuty,
  });

  @override
  List<Object?> get props => [available, responding, offDuty];
}

class ActiveIncidentEntity extends Equatable {
  final String id;
  final String title;
  final String location;
  final DateTime time;
  final AlertPriority priority;
  final String status;
  final String reportedBy;
  final bool isAssignedToYou;

  const ActiveIncidentEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.time,
    required this.priority,
    required this.status,
    required this.reportedBy,
    required this.isAssignedToYou,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        time,
        priority,
        status,
        reportedBy,
        isAssignedToYou,
      ];
}

class PatrolProgressEntity extends Equatable {
  final int totalCheckpoints;
  final int completedCheckpoints;
  final DateTime estimatedCompletionTime;
  final String nextCheckpoint;

  const PatrolProgressEntity({
    required this.totalCheckpoints,
    required this.completedCheckpoints,
    required this.estimatedCompletionTime,
    required this.nextCheckpoint,
  });

  double get progressPercentage => totalCheckpoints > 0 ? (completedCheckpoints / totalCheckpoints) * 100 : 0.0;

  @override
  List<Object?> get props => [totalCheckpoints, completedCheckpoints, estimatedCompletionTime, nextCheckpoint];
}

class EquipmentStatusEntity extends Equatable {
  final bool isRadioActive;
  final bool isBodyCamActive;
  final bool isGpsActive;

  const EquipmentStatusEntity({
    required this.isRadioActive,
    required this.isBodyCamActive,
    required this.isGpsActive,
  });

  @override
  List<Object?> get props => [isRadioActive, isBodyCamActive, isGpsActive];
}

class PerformanceSummaryEntity extends Equatable {
  final int incidentsResolved;
  final double averageResponseTimeMinutes;
  final double patrolAccuracyPercentage;
  final int securityChecks;

  const PerformanceSummaryEntity({
    required this.incidentsResolved,
    required this.averageResponseTimeMinutes,
    required this.patrolAccuracyPercentage,
    required this.securityChecks,
  });

  @override
  List<Object?> get props => [incidentsResolved, averageResponseTimeMinutes, patrolAccuracyPercentage, securityChecks];
}

class ActivityTimelineEntity extends Equatable {
  final String id;
  final String activity;
  final String description;
  final DateTime time;
  final String status;

  const ActivityTimelineEntity({
    required this.id,
    required this.activity,
    required this.description,
    required this.time,
    required this.status,
  });

  @override
  List<Object?> get props => [id, activity, description, time, status];
}

class ShiftSummaryEntity extends Equatable {
  final DateTime shiftStart;
  final DateTime shiftEnd;

  const ShiftSummaryEntity({
    required this.shiftStart,
    required this.shiftEnd,
  });

  Duration get remainingTime {
    final now = DateTime.now();
    if (now.isAfter(shiftEnd)) return Duration.zero;
    return shiftEnd.difference(now);
  }

  @override
  List<Object?> get props => [shiftStart, shiftEnd];
}
