import '../entities/notification_entity.dart';
import '../entities/notification_filter.dart';
import '../entities/notification_type.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase({required this.repository});

  Future<List<NotificationEntity>> call({String query = '', NotificationFilter filter = NotificationFilter.all}) async {
    List<NotificationEntity> results;
    
    if (query.isNotEmpty) {
      results = await repository.searchNotifications(query);
      
      // Apply filter to search results if not 'all'
      if (filter != NotificationFilter.all) {
         results = results.where((n) {
           switch (filter) {
             case NotificationFilter.unread: return !n.isRead;
             case NotificationFilter.assignments: return n.type == NotificationType.assignment;
             case NotificationFilter.critical: return n.type == NotificationType.critical;
             case NotificationFilter.resolved: return n.type == NotificationType.resolved;
             default: return true;
           }
         }).toList();
      }
    } else if (filter != NotificationFilter.all) {
      results = await repository.filterNotifications(filter);
    } else {
      results = await repository.getNotifications();
    }
    
    // Always return sorted by timestamp descending
    final sortedResults = List<NotificationEntity>.from(results);
    sortedResults.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sortedResults;
  }
}
