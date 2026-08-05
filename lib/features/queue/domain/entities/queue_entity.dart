import 'package:equatable/equatable.dart';
import 'queue_status.dart';
import 'queue_timeline_step_entity.dart';

class QueueEntity extends Equatable {
  final String id;
  final String token;
  final String customerName;
  final String phoneNumber;
  final String avatarUrl;
  final int partySize;
  final int estimatedWaitMinutes;
  final DateTime checkInTime;
  final QueueStatus status;

  // Detailed fields for Queue Details phase
  final String? specialNotes;
  final int? position;
  final String? serviceType;
  final String? priority;
  final String? contactPreference;
  final String? membershipLevel;
  final List<QueueTimelineStepEntity>? timelineSteps;

  const QueueEntity({
    required this.id,
    required this.token,
    required this.customerName,
    required this.phoneNumber,
    required this.avatarUrl,
    required this.partySize,
    required this.estimatedWaitMinutes,
    required this.checkInTime,
    required this.status,
    this.specialNotes,
    this.position,
    this.serviceType,
    this.priority,
    this.contactPreference,
    this.membershipLevel,
    this.timelineSteps,
  });

  @override
  List<Object?> get props => [
        id,
        token,
        customerName,
        phoneNumber,
        avatarUrl,
        partySize,
        estimatedWaitMinutes,
        checkInTime,
        status,
        specialNotes,
        position,
        serviceType,
        priority,
        contactPreference,
        membershipLevel,
        timelineSteps,
      ];
}
