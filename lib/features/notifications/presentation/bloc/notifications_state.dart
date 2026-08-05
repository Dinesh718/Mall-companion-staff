import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_filter.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
  
  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationEntity> notifications;
  final NotificationFilter activeFilter;
  final String searchQuery;

  const NotificationsLoaded({
    required this.notifications,
    this.activeFilter = NotificationFilter.all,
    this.searchQuery = '',
  });

  NotificationsLoaded copyWith({
    List<NotificationEntity>? notifications,
    NotificationFilter? activeFilter,
    String? searchQuery,
  }) {
    return NotificationsLoaded(
      notifications: notifications ?? this.notifications,
      activeFilter: activeFilter ?? this.activeFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [notifications, activeFilter, searchQuery];
}

class NotificationsError extends NotificationsState {
  final String message;

  const NotificationsError(this.message);

  @override
  List<Object?> get props => [message];
}
