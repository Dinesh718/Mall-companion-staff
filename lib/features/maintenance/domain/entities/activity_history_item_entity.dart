import 'package:equatable/equatable.dart';

class ActivityHistoryItemEntity extends Equatable {
  final String id;
  final String title;
  final String time;
  final String ticketId;
  final String priority;
  final String status;
  final String location;
  final String metadataText;
  final String metadataIcon; // e.g., 'person', 'schedule', 'history'
  final String iconType; // e.g., 'check_circle', 'play_arrow', 'assignment_turned_in', 'pause_circle'
  final String dateGroup; // e.g., 'Today • June 12'
  final String category;

  const ActivityHistoryItemEntity({
    required this.id,
    required this.title,
    required this.time,
    required this.ticketId,
    required this.priority,
    required this.status,
    required this.location,
    required this.metadataText,
    required this.metadataIcon,
    required this.iconType,
    required this.dateGroup,
    required this.category,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        time,
        ticketId,
        priority,
        status,
        location,
        metadataText,
        metadataIcon,
        iconType,
        dateGroup,
        category,
      ];
}
