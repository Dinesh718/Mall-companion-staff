import 'emergency_timeline_entity.dart';

enum EmergencyType { fireAlarm, medicalEmergency, sosRequest, lostChild, securityAssistance, panicAlert, buildingEmergency }
enum EmergencyPriority { critical, high, medium, low }
enum EmergencyStatus { reported, assigned, accepted, navigationStarted, onSite, assistanceInProgress, resolved }
enum EmergencyReporterSource { visitor, storeManager, maintenanceStaff, cctv, aiCamera, fireSensor, smokeDetector }

class EmergencyEntity {
  final String id;
  final String title;
  final EmergencyType type;
  final EmergencyPriority priority;
  final EmergencyStatus status;
  final String location;
  final String? floor;
  final String? zone;
  final DateTime reportedTime;
  final EmergencyReporterSource reporterSource;
  final double distanceFromOfficerMeters;
  final double estimatedArrivalTimeMinutes;
  final String crowdEstimate;
  final List<EmergencyTimelineEntity> timeline;

  const EmergencyEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.priority,
    required this.status,
    required this.location,
    this.floor,
    this.zone,
    required this.reportedTime,
    required this.reporterSource,
    required this.distanceFromOfficerMeters,
    required this.estimatedArrivalTimeMinutes,
    required this.crowdEstimate,
    this.timeline = const [],
  });
}
