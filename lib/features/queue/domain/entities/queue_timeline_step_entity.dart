import 'package:equatable/equatable.dart';
import 'queue_timeline_step_status.dart';

class QueueTimelineStepEntity extends Equatable {
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final QueueTimelineStepStatus status;

  const QueueTimelineStepEntity({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.status,
  });

  @override
  List<Object?> get props => [title, subtitle, timestamp, status];
}
