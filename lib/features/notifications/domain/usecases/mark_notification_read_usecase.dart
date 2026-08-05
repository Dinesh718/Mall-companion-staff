import '../repositories/notification_repository.dart';

class MarkNotificationReadUseCase {
  final NotificationRepository repository;

  MarkNotificationReadUseCase({required this.repository});

  Future<void> call(String id) async {
    await repository.markNotificationRead(id);
  }
  
  Future<void> markAllAsRead() async {
    await repository.markAllNotificationsRead();
  }
}
