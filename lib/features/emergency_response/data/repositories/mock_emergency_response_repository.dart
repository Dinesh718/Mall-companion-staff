import 'dart:async';

import '../../domain/entities/emergency_entity.dart';
import '../../domain/entities/emergency_filter_entity.dart';
import '../../domain/entities/emergency_overview_entity.dart';
import '../../domain/entities/emergency_summary_entity.dart';
import '../../domain/entities/emergency_timeline_entity.dart';
import '../../domain/repositories/emergency_response_repository.dart';

class MockEmergencyResponseRepository implements EmergencyResponseRepository {
  final List<EmergencyEntity> _mockEmergencies = [
    EmergencyEntity(
      id: 'EME-9921',
      title: 'Fire Alarm',
      type: EmergencyType.fireAlarm,
      priority: EmergencyPriority.critical,
      status: EmergencyStatus.reported, // Waiting in UI
      location: 'Food Court - North Wing',
      reportedTime: DateTime.now().subtract(const Duration(minutes: 2)),
      reporterSource: EmergencyReporterSource.fireSensor,
      distanceFromOfficerMeters: 120,
      estimatedArrivalTimeMinutes: 1.5,
      crowdEstimate: '15+ people',
    ),
    EmergencyEntity(
      id: 'EME-9922',
      title: 'Medical Emergency',
      type: EmergencyType.medicalEmergency,
      priority: EmergencyPriority.high,
      status: EmergencyStatus.accepted,
      location: 'Level 2 Elevators',
      reportedTime: DateTime.now().subtract(const Duration(minutes: 5)),
      reporterSource: EmergencyReporterSource.storeManager,
      distanceFromOfficerMeters: 450,
      estimatedArrivalTimeMinutes: 3,
      crowdEstimate: '2-3 people',
      timeline: [
        EmergencyTimelineEntity(
          title: 'Officer Accepted',
          timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
          isCurrent: true,
        ),
        EmergencyTimelineEntity(
          title: 'Assigned to Officer',
          timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
          isCompleted: true,
        ),
        EmergencyTimelineEntity(
          title: 'Emergency Reported',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isCompleted: true,
        ),
      ],
    ),
  ];

  @override
  Future<List<EmergencyEntity>> getEmergencies(EmergencyFilterEntity filter) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (filter == EmergencyFilterEntity.all) {
      return _mockEmergencies;
    }

    return _mockEmergencies.where((emergency) {
      switch (filter) {
        case EmergencyFilterEntity.critical:
          return emergency.priority == EmergencyPriority.critical;
        case EmergencyFilterEntity.fire:
          return emergency.type == EmergencyType.fireAlarm;
        case EmergencyFilterEntity.medical:
          return emergency.type == EmergencyType.medicalEmergency;
        case EmergencyFilterEntity.sos:
          return emergency.type == EmergencyType.sosRequest;
        case EmergencyFilterEntity.lostChild:
          return emergency.type == EmergencyType.lostChild;
        case EmergencyFilterEntity.accepted:
          return emergency.status == EmergencyStatus.accepted;
        default:
          return true;
      }
    }).toList();
  }

  @override
  Future<EmergencyOverviewEntity> getEmergencyOverview() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const EmergencyOverviewEntity(
      activeEmergencies: 4,
      criticalEmergencies: 2,
      availableOfficers: 8,
      averageResponseTimeMinutes: 2.4,
    );
  }

  @override
  Future<EmergencySummaryEntity> getEmergencySummary() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return EmergencySummaryEntity(
      totalEmergencies: 4,
      accepted: 1,
      waiting: 3,
      resolvedToday: 12,
      lastUpdatedTime: DateTime.now(),
    );
  }
}
