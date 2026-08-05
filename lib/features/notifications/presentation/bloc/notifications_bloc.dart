import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/notification_filter.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/mark_notification_read_usecase.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationReadUseCase markNotificationReadUseCase;

  NotificationsBloc({
    required this.getNotificationsUseCase,
    required this.markNotificationReadUseCase,
  }) : super(NotificationsInitial()) {
    on<LoadNotificationsRequested>(_onLoadNotifications);
    on<RefreshNotificationsRequested>(_onRefreshNotifications);
    on<SearchNotificationsRequested>(_onSearchNotifications);
    on<FilterNotificationsRequested>(_onFilterNotifications);
    on<MarkNotificationReadRequested>(_onMarkNotificationRead);
    on<MarkAllNotificationsReadRequested>(_onMarkAllNotificationsRead);
  }

  Future<void> _onLoadNotifications(
      LoadNotificationsRequested event, Emitter<NotificationsState> emit) async {
    emit(NotificationsLoading());
    try {
      final notifications = await getNotificationsUseCase();
      emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  Future<void> _onRefreshNotifications(
      RefreshNotificationsRequested event, Emitter<NotificationsState> emit) async {
    try {
      final currentState = state;
      String query = '';
      NotificationFilter filter = NotificationFilter.all;

      if (currentState is NotificationsLoaded) {
        query = currentState.searchQuery;
        filter = currentState.activeFilter;
      }
      
      final notifications = await getNotificationsUseCase(query: query, filter: filter);
      emit(NotificationsLoaded(
        notifications: notifications,
        searchQuery: query,
        activeFilter: filter,
      ));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  Future<void> _onSearchNotifications(
      SearchNotificationsRequested event, Emitter<NotificationsState> emit) async {
    final currentState = state;
    if (currentState is NotificationsLoaded) {
      try {
        final notifications = await getNotificationsUseCase(
            query: event.query, filter: currentState.activeFilter);
        emit(currentState.copyWith(
          notifications: notifications,
          searchQuery: event.query,
        ));
      } catch (e) {
        emit(NotificationsError(e.toString()));
      }
    }
  }

  Future<void> _onFilterNotifications(
      FilterNotificationsRequested event, Emitter<NotificationsState> emit) async {
    final currentState = state;
    if (currentState is NotificationsLoaded) {
      try {
        final notifications = await getNotificationsUseCase(
            query: currentState.searchQuery, filter: event.filter);
        emit(currentState.copyWith(
          notifications: notifications,
          activeFilter: event.filter,
        ));
      } catch (e) {
        emit(NotificationsError(e.toString()));
      }
    }
  }

  Future<void> _onMarkNotificationRead(
      MarkNotificationReadRequested event, Emitter<NotificationsState> emit) async {
    final currentState = state;
    if (currentState is NotificationsLoaded) {
      try {
        await markNotificationReadUseCase(event.notificationId);
        // Refresh the list seamlessly
        final notifications = await getNotificationsUseCase(
            query: currentState.searchQuery, filter: currentState.activeFilter);
        emit(currentState.copyWith(notifications: notifications));
      } catch (e) {
        // ignore error silently for now, or could emit error
      }
    }
  }

  Future<void> _onMarkAllNotificationsRead(
      MarkAllNotificationsReadRequested event, Emitter<NotificationsState> emit) async {
    final currentState = state;
    if (currentState is NotificationsLoaded) {
      try {
        await markNotificationReadUseCase.markAllAsRead();
        // Refresh the list seamlessly
        final notifications = await getNotificationsUseCase(
            query: currentState.searchQuery, filter: currentState.activeFilter);
        emit(currentState.copyWith(notifications: notifications));
      } catch (e) {
        // ignore error silently
      }
    }
  }
}
