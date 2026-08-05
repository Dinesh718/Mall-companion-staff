import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/contact_entity.dart';
import '../../domain/entities/document_entity.dart';
import '../../domain/entities/performance_snapshot_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

class MockProfileRepository implements ProfileRepository {
  @override
  Future<ProfileEntity> getProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return const ProfileEntity(
      name: 'Alex Rivera',
      employeeId: 'MC-8842',
      role: 'Maintenance Staff',
      avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB_civy03tg-alh1CmyR5D2NDutWTq24mKljZ1iYCTm04NbYmyDXsA5i2S_SBhKaPxZzF7mIiJxAJNbnPtK3cfom0jXcgUVN-tYP2OW5lqm3eW3DU8-7WhXDAgFIXu-aF4rXvnwon6UqCRRDWWrNbKMIDAG9G8X6BoOYXuxLP-dPGMjCHUNpnJRIK4jAWR4wwe7wJyYqUCMd7A9psE077fley61Vqh9bszlxS5H0nIBjIuyrIVWvg3t',
      isOnline: true,
      currentTask: "Zone A Maintenance",
      shiftHours: "08:00 - 17:00",
      activeTicketsCount: 14,
      assignment: AssignmentEntity(
        mall: 'Lumina Plaza',
        zone: 'Zone A (Premium)',
        shift: 'Morning',
        experience: '5 Years',
        department: 'Facility Management',
        reportingManager: 'Marcus Chen',
        employmentType: 'Full-time',
        authorizedEquipment: [
          'Electrical Panel',
          'HVAC',
          'Lift Maintenance',
          'Fire Systems'
        ],
      ),
      contact: ContactEntity(
        phone: '+1 555-0123',
        email: 'alex.r@mallcomp.com',
        emergencyContactName: 'Sarah Rivera',
        bloodGroup: 'O+',
        isFirstAidCertified: true,
      ),
      performance: PerformanceSnapshotEntity(
        ticketsCompleted: 128,
        averageResolutionTimeMinutes: 42,
        attendancePercentage: 98,
        rating: 4.8,
      ),
      certifiedSkills: [
        'Electrical',
        'HVAC',
        'Fire Safety',
        'First Aid',
        'Plumbing',
        'Equipment Repair'
      ],
      documents: [
        DocumentEntity(
          title: 'Employee ID Card',
          iconName: 'badge',
          isVerified: true,
        ),
        DocumentEntity(
          title: 'Safety Certificate',
          iconName: 'verified_user',
          isVerified: true,
        ),
        DocumentEntity(
          title: 'Training Certificate',
          iconName: 'school',
          isVerified: true,
        ),
      ],
    );
  }
}
