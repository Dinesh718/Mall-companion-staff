import '../../domain/entities/assistance_service_entity.dart';
import '../../domain/entities/emergency_action_entity.dart';
import '../../domain/entities/emergency_contact_entity.dart';
import '../../domain/entities/emergency_facility_entity.dart';
import '../../domain/entities/emergency_guideline_entity.dart';
import '../../domain/entities/emergency_hub_entity.dart';
import '../../domain/repositories/emergency_hub_repository.dart';

class MockEmergencyHubRepository implements EmergencyHubRepository {
  @override
  Future<EmergencyHubEntity> getEmergencyHubData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return const EmergencyHubEntity(
      isMallOperatingNormally: true,
      locationText: 'Level 2 • Food Court',
      securityTeamStatus: 'Available',
      avgResponseTime: '< 3 min',
      mallStatusText: 'Normal',
      primaryActions: [
        EmergencyActionEntity(
          title: 'SOS',
          subtitle: 'Immediately notify mall security.',
          iconName: 'sos',
          isDestructive: true,
          routeName: '/sos',
        ),
        EmergencyActionEntity(
          title: 'Fire Exit',
          subtitle: 'Navigate to the nearest emergency exit.',
          iconName: 'directions_run',
          routeName: '/fire-exit',
        ),
        EmergencyActionEntity(
          title: 'First Aid',
          subtitle: 'Find the nearest first aid station.',
          iconName: 'medical_services',
          routeName: '/first-aid',
        ),
        EmergencyActionEntity(
          title: 'Security Assistance',
          subtitle: 'Request security assistance.',
          iconName: 'local_police',
          routeName: '/security-assistance',
        ),
      ],
      assistanceServices: [
        AssistanceServiceEntity(
          title: 'Lost Child',
          subtitle: 'Immediate assistance',
          iconName: 'child_care',
          badgeText: '24/7',
        ),
        AssistanceServiceEntity(
          title: 'Help Desk',
          subtitle: 'General inquiries',
          iconName: 'support_agent',
          badgeText: '24/7',
        ),
        AssistanceServiceEntity(
          title: 'Info Counter',
          subtitle: 'Mall navigation',
          iconName: 'info',
        ),
        AssistanceServiceEntity(
          title: 'Accessibility',
          subtitle: 'Mobility support',
          iconName: 'accessible',
        ),
      ],
      nearbyFacilities: [
        EmergencyFacilityEntity(
          name: 'First Aid Station',
          locationDetails: 'Floor 2, 50m away',
          iconName: 'medical_services',
        ),
        EmergencyFacilityEntity(
          name: 'Security Office',
          locationDetails: 'Floor 1, 120m away',
          iconName: 'local_police',
        ),
        EmergencyFacilityEntity(
          name: 'Emergency Exit',
          locationDetails: 'North Wing, 30m away',
          iconName: 'exit_to_app',
        ),
      ],
      guidelines: [
        EmergencyGuidelineEntity(title: 'Stay calm', iconName: 'spa'),
        EmergencyGuidelineEntity(title: 'Follow staff', iconName: 'record_voice_over'),
        EmergencyGuidelineEntity(title: 'No elevators', iconName: 'no_transportation'),
        EmergencyGuidelineEntity(title: 'Proceed to exit', iconName: 'directions_run'),
      ],
      emergencyContacts: [
        EmergencyContactEntity(name: 'Mall Security', phoneNumber: '555-0101', iconName: 'shield'),
        EmergencyContactEntity(name: 'Medical Desk', phoneNumber: '555-0102', iconName: 'medical_information'),
        EmergencyContactEntity(name: 'Help Desk', phoneNumber: '555-0103', iconName: 'help_center'),
      ],
    );
  }
}
