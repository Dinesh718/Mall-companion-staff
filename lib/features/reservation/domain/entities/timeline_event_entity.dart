import 'package:equatable/equatable.dart';

class TimelineEventEntity extends Equatable {
  final String title;
  final String subtitle;
  final bool isPrimary;
  final bool isPast;

  const TimelineEventEntity({
    required this.title,
    required this.subtitle,
    this.isPrimary = false,
    this.isPast = true,
  });

  @override
  List<Object?> get props => [title, subtitle, isPrimary, isPast];
}
