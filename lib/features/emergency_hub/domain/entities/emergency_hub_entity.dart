import 'emergency_action_entity.dart';
import 'assistance_service_entity.dart';
import 'emergency_facility_entity.dart';
import 'emergency_contact_entity.dart';
import 'emergency_guideline_entity.dart';

class EmergencyHubEntity {
  final bool isMallOperatingNormally;
  final String locationText;
  final String securityTeamStatus;
  final String avgResponseTime;
  final String mallStatusText;
  
  final List<EmergencyActionEntity> primaryActions;
  final List<AssistanceServiceEntity> assistanceServices;
  final List<EmergencyFacilityEntity> nearbyFacilities;
  final List<EmergencyGuidelineEntity> guidelines;
  final List<EmergencyContactEntity> emergencyContacts;

  const EmergencyHubEntity({
    required this.isMallOperatingNormally,
    required this.locationText,
    required this.securityTeamStatus,
    required this.avgResponseTime,
    required this.mallStatusText,
    required this.primaryActions,
    required this.assistanceServices,
    required this.nearbyFacilities,
    required this.guidelines,
    required this.emergencyContacts,
  });
}
