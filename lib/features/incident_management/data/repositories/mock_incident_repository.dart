import 'dart:async';

import '../../domain/entities/assigned_officer_entity.dart';
import '../../domain/entities/incident_entity.dart';
import '../../domain/entities/incident_filter_entity.dart';
import '../../domain/entities/incident_overview_entity.dart';
import '../../domain/entities/incident_summary_entity.dart';
import '../../domain/repositories/incident_repository.dart';

class MockIncidentRepository implements IncidentRepository {
  // Mock data as seen in the Stitch design
  final List<IncidentEntity> _mockIncidents = [
    IncidentEntity(
      id: 'INC-8821',
      title: 'Suspicious Package',
      category: 'Security',
      priority: IncidentPriority.critical,
      status: IncidentStatus.pending,
      location: 'Cinema Entry • Level 4',
      reportedTime: DateTime.now().subtract(const Duration(minutes: 5)),
      reporterSource: IncidentReporterSource.cctv,
      hasAttachments: true,
      assignedOfficer: const AssignedOfficerEntity(
        id: 'OFC-101',
        name: 'Officer Alex Rivera',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBlrhDgl7TTmoO65TgcKrBjKQIuF2Z1b9LLev0hZo1UZwfytsvNZGAZ77wny58pfeqx1v4wg2cAyFy5Mo-3Lv1RJcsIlDFrPt11XnwBs6AGqOaqAFEoBCm4xTfC74rA5xi3c06lWcA3utA43F5Ko_QOUrgeoJ9_S-jhyu8NDsxUg7A-RBD6cjez5H3NL1E7PZhrQwaK9h7h6Qro7eIJlyGRFl0cfx84-xJZoGIBi3voLbkOQFXMoo4',
        status: 'Responding',
      ),
    ),
    IncidentEntity(
      id: 'INC-8822',
      title: 'Unauthorized Access',
      category: 'Security',
      priority: IncidentPriority.high,
      status: IncidentStatus.responding, // In UI it says "Responding" in the top badge, but Officer is "On Site"
      location: 'Staff Elevators • Loading Bay',
      reportedTime: DateTime.now().subtract(const Duration(minutes: 12)),
      reporterSource: IncidentReporterSource.doorSensor,
      hasAttachments: false,
      assignedOfficer: const AssignedOfficerEntity(
        id: 'OFC-102',
        name: 'Officer Sarah Chen',
        avatarUrl: '', // uses fallback person icon in UI
        status: 'On Site',
      ),
    ),
  ];

  @override
  Future<List<IncidentEntity>> getIncidents(IncidentFilterEntity filter) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (filter == IncidentFilterEntity.all) {
      return _mockIncidents;
    }

    return _mockIncidents.where((incident) {
      switch (filter) {
        case IncidentFilterEntity.critical:
          return incident.priority == IncidentPriority.critical;
        case IncidentFilterEntity.assigned:
          return incident.assignedOfficer != null;
        case IncidentFilterEntity.pending:
          return incident.status == IncidentStatus.pending;
        case IncidentFilterEntity.responding:
          return incident.status == IncidentStatus.responding;
        case IncidentFilterEntity.resolved:
          return incident.status == IncidentStatus.resolved;
        case IncidentFilterEntity.today:
          final now = DateTime.now();
          return incident.reportedTime.year == now.year &&
              incident.reportedTime.month == now.month &&
              incident.reportedTime.day == now.day;
        default:
          return true;
      }
    }).toList();
  }

  @override
  Future<IncidentOverviewEntity> getIncidentOverview() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const IncidentOverviewEntity(
      activeIncidents: 12,
      criticalIncidents: 2,
      assignedIncidents: 5,
      averageResponseTime: 4.2,
    );
  }

  @override
  Future<IncidentSummaryEntity> getIncidentSummary() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return IncidentSummaryEntity(
      totalIncidents: 18,
      criticalIncidents: 2,
      assignedIncidents: 4,
      lastUpdatedTime: DateTime.now().subtract(const Duration(minutes: 1)),
    );
  }
}
