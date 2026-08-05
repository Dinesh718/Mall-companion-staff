import 'package:equatable/equatable.dart';
import 'reservation_entity.dart';
import 'timeline_event_entity.dart';

class ReservationDetailsEntity extends Equatable {
  final ReservationEntity baseInfo;
  
  // Customer Details
  final String membershipLevel;
  final String email;
  final String avatarUrl;
  
  // Insights
  final String insightTitle;
  final String insightDescription;
  
  // Reservation Info
  final String table;
  final String area;
  final String type;
  final String preference;
  final String occasion;
  final String bookingSource;
  
  // Requests & Notes
  final List<String> specialRequestTags;
  final String internalStaffNotes;
  
  // Timeline
  final List<TimelineEventEntity> timeline;

  const ReservationDetailsEntity({
    required this.baseInfo,
    required this.membershipLevel,
    required this.email,
    required this.avatarUrl,
    required this.insightTitle,
    required this.insightDescription,
    required this.table,
    required this.area,
    required this.type,
    required this.preference,
    required this.occasion,
    required this.bookingSource,
    required this.specialRequestTags,
    required this.internalStaffNotes,
    required this.timeline,
  });

  @override
  List<Object?> get props => [
        baseInfo,
        membershipLevel,
        email,
        avatarUrl,
        insightTitle,
        insightDescription,
        table,
        area,
        type,
        preference,
        occasion,
        bookingSource,
        specialRequestTags,
        internalStaffNotes,
        timeline,
      ];
}
