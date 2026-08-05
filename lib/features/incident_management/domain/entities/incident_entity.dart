import 'assigned_officer_entity.dart';

enum IncidentPriority { critical, high, medium, low }
enum IncidentStatus { pending, assigned, accepted, responding, onSite, resolved, closed }
enum IncidentReporterSource { cctv, aiCamera, visitor, mallStaff, doorSensor }

class IncidentEntity {
  final String id;
  final String title;
  final String category;
  final IncidentPriority priority;
  final IncidentStatus status;
  final String location;
  final DateTime reportedTime;
  final IncidentReporterSource reporterSource;
  final AssignedOfficerEntity? assignedOfficer;
  final int? estimatedResponseTimeMinutes;
  final bool hasAttachments;

  const IncidentEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.status,
    required this.location,
    required this.reportedTime,
    required this.reporterSource,
    this.assignedOfficer,
    this.estimatedResponseTimeMinutes,
    this.hasAttachments = false,
  });
}
