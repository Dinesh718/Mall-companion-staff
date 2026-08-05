import 'notification_type.dart';

class NotificationEntity {
  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isRead;
  final String? referenceId;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isRead,
    this.referenceId,
  });

  NotificationEntity copyWith({
    String? id,
    NotificationType? type,
    String? title,
    String? description,
    DateTime? timestamp,
    bool? isRead,
    String? referenceId,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      referenceId: referenceId ?? this.referenceId,
    );
  }
}
