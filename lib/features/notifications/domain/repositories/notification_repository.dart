import '../entities/notification_entity.dart';
import '../entities/notification_filter.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getNotifications();
  Future<List<NotificationEntity>> searchNotifications(String query);
  Future<List<NotificationEntity>> filterNotifications(NotificationFilter filter);
  Future<void> markNotificationRead(String id);
  Future<void> markAllNotificationsRead();
  Future<List<NotificationEntity>> refreshNotifications();
}
