import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_filter.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationsRequested extends NotificationsEvent {}

class RefreshNotificationsRequested extends NotificationsEvent {}

class SearchNotificationsRequested extends NotificationsEvent {
  final String query;

  const SearchNotificationsRequested(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterNotificationsRequested extends NotificationsEvent {
  final NotificationFilter filter;

  const FilterNotificationsRequested(this.filter);

  @override
  List<Object?> get props => [filter];
}

class MarkNotificationReadRequested extends NotificationsEvent {
  final String notificationId;

  const MarkNotificationReadRequested(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

class MarkAllNotificationsReadRequested extends NotificationsEvent {}
