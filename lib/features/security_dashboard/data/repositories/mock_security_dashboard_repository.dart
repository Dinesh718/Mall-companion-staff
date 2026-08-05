import '../../domain/entities/security_dashboard_entity.dart';
import '../../domain/repositories/security_dashboard_repository.dart';

class MockSecurityDashboardRepository implements SecurityDashboardRepository {
  @override
  Future<SecurityDashboardEntity> getDashboardData() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network latency

    final now = DateTime.now();

    return SecurityDashboardEntity(
      officer: const SecurityOfficerEntity(
        name: 'Alex Rivera',
        employeeId: 'S-10293',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCvSOHOWNWLmZs1hUqRThL2ntDfd9qQ-ZtUYFw9GSy6tA0g4n3ZiJ6cIZ2zXg_BHt5-76NAO3a-YnccVfvgZtR6SCNcylssRujm9zUb5qQqQaBfLfQLp33FaHOzrjYsceAvqjF_4GqIjDb1dhPLn5pYSDD0IxVtV-PfG5og6o7mSK3qMa5LKI_lX_UJfwP_HAuYzMBRoS_RsKbt8wF643VHcbD4NeE9Hfj5L9AZ_J6FJIEs_5F_WpY',
        role: 'Security Staff',
        assignedZone: 'Zone B',
        currentShift: 'Morning Shift',
        dutyStatus: 'On Patrol',
      ),
      heroMetrics: const HeroMetricsEntity(
        activeIncidents: 2,
        patrolProgressPercentage: 75.0,
        averageResponseTimeMinutes: 4.2,
      ),
      emergencyAlerts: [
        EmergencyAlertEntity(
          id: 'alert-1',
          type: 'Fire Alarm',
          location: 'Food Court - North Wing',
          time: now.subtract(const Duration(minutes: 2)),
          priority: AlertPriority.critical,
          status: 'Pending',
        ),
        EmergencyAlertEntity(
          id: 'alert-2',
          type: 'Medical Emergency',
          location: 'Level 2 North Escalators',
          time: now.subtract(const Duration(minutes: 2)),
          priority: AlertPriority.high,
          status: 'Pending',
        ),
      ],
      teamStatus: const TeamStatusEntity(
        available: 12,
        responding: 4,
        offDuty: 8,
      ),
      activeIncident: ActiveIncidentEntity(
        id: 'inc-1',
        title: 'Suspicious Package',
        location: 'Cinema Entry • Level 4',
        time: now.subtract(const Duration(minutes: 5)),
        priority: AlertPriority.high,
        status: 'Active',
        reportedBy: 'CCTV',
        isAssignedToYou: true,
      ),
      patrolProgress: PatrolProgressEntity(
        totalCheckpoints: 16,
        completedCheckpoints: 12,
        estimatedCompletionTime: DateTime(now.year, now.month, now.day, 14, 30),
        nextCheckpoint: 'Level 4 Cinema Entry',
      ),
      equipmentStatus: const EquipmentStatusEntity(
        isRadioActive: true,
        isBodyCamActive: true,
        isGpsActive: true,
      ),
      performanceSummary: const PerformanceSummaryEntity(
        incidentsResolved: 12,
        averageResponseTimeMinutes: 4.2,
        patrolAccuracyPercentage: 100.0,
        securityChecks: 24,
      ),
      recentActivity: [
        ActivityTimelineEntity(
          id: 'act-1',
          activity: 'Responded to Medical Alert',
          description: 'Zone A Escalators',
          time: DateTime(now.year, now.month, now.day, 10, 45),
          status: 'Resolved',
        ),
        ActivityTimelineEntity(
          id: 'act-2',
          activity: 'Completed Zone B Patrol',
          description: '16/16 Checkpoints',
          time: DateTime(now.year, now.month, now.day, 9, 30),
          status: 'Completed',
        ),
      ],
      shiftSummary: ShiftSummaryEntity(
        shiftStart: DateTime(now.year, now.month, now.day, 8, 0),
        shiftEnd: DateTime(now.year, now.month, now.day, 16, 0),
      ),
    );
  }
}
