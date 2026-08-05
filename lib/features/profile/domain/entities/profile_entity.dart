import 'assignment_entity.dart';
import 'contact_entity.dart';
import 'performance_snapshot_entity.dart';
import 'document_entity.dart';

class ProfileEntity {
  final String name;
  final String employeeId;
  final String role;
  final String avatarUrl;
  final bool isOnline;
  final String currentTask;
  final String shiftHours;
  final int activeTicketsCount;
  
  final AssignmentEntity assignment;
  final ContactEntity contact;
  final PerformanceSnapshotEntity performance;
  final List<String> certifiedSkills;
  final List<DocumentEntity> documents;

  const ProfileEntity({
    required this.name,
    required this.employeeId,
    required this.role,
    required this.avatarUrl,
    required this.isOnline,
    required this.currentTask,
    required this.shiftHours,
    required this.activeTicketsCount,
    required this.assignment,
    required this.contact,
    required this.performance,
    required this.certifiedSkills,
    required this.documents,
  });
}
