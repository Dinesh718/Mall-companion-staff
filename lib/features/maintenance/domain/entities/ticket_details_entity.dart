import 'package:equatable/equatable.dart';
import '../../../reservation/domain/entities/timeline_event_entity.dart';

class TicketAttachmentEntity extends Equatable {
  final String id;
  final String name;
  final String url;
  final String type; // e.g. 'image', 'document'
  final String size;

  const TicketAttachmentEntity({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
    required this.size,
  });

  @override
  List<Object?> get props => [id, name, url, type, size];
}

class TicketNoteEntity extends Equatable {
  final String id;
  final String authorName;
  final String authorRole;
  final String content;
  final String timestamp;

  const TicketNoteEntity({
    required this.id,
    required this.authorName,
    required this.authorRole,
    required this.content,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, authorName, authorRole, content, timestamp];
}

class TicketSlaEntity extends Equatable {
  final String reportedTime;
  final String dueTime;
  final String timeRemaining;
  final bool isBreached;

  const TicketSlaEntity({
    required this.reportedTime,
    required this.dueTime,
    required this.timeRemaining,
    this.isBreached = false,
  });

  @override
  List<Object?> get props => [reportedTime, dueTime, timeRemaining, isBreached];
}

class TicketDetailsEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final String category;
  
  final String location;
  final String locationDetails; // e.g., "Near Men's Restroom"
  
  final TicketSlaEntity sla;
  final List<TimelineEventEntity> timeline;
  final List<TicketAttachmentEntity> attachments;
  final List<TicketNoteEntity> notes;

  const TicketDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.location,
    required this.locationDetails,
    required this.sla,
    required this.timeline,
    required this.attachments,
    required this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        priority,
        category,
        location,
        locationDetails,
        sla,
        timeline,
        attachments,
        notes,
      ];

  TicketDetailsEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    String? priority,
    String? category,
    String? location,
    String? locationDetails,
    TicketSlaEntity? sla,
    List<TimelineEventEntity>? timeline,
    List<TicketAttachmentEntity>? attachments,
    List<TicketNoteEntity>? notes,
  }) {
    return TicketDetailsEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      location: location ?? this.location,
      locationDetails: locationDetails ?? this.locationDetails,
      sla: sla ?? this.sla,
      timeline: timeline ?? this.timeline,
      attachments: attachments ?? this.attachments,
      notes: notes ?? this.notes,
    );
  }
}
