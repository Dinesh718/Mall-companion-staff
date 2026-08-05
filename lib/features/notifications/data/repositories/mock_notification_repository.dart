import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_filter.dart';
import '../../domain/entities/notification_type.dart';
import '../../domain/repositories/notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  // Singleton pattern for persistence during session
  static final MockNotificationRepository _instance = MockNotificationRepository._internal();
  factory MockNotificationRepository() => _instance;
  
  MockNotificationRepository._internal() {
    _initMockData();
  }

  late List<NotificationEntity> _notifications;

  void _initMockData() {
    final now = DateTime.now();
    _notifications = [
      NotificationEntity(
        id: 'n1',
        type: NotificationType.critical,
        title: 'Critical HVAC Failure',
        description: 'Food Court, Level 2 - System pressure drop detected in Unit #7. Immediate inspection required.',
        timestamp: now.subtract(const Duration(minutes: 5)),
        isRead: false,
        referenceId: 'HVAC-07',
      ),
      NotificationEntity(
        id: 'n2',
        type: NotificationType.assignment,
        title: 'New Ticket Assigned',
        description: '#MT-2051 Lighting - Corridor B, Level 1. Flickering LED panel reported by security.',
        timestamp: now.subtract(const Duration(minutes: 15)),
        isRead: false,
        referenceId: '#MT-2051',
      ),
      NotificationEntity(
        id: 'n3',
        type: NotificationType.update,
        title: 'Ticket Updated',
        description: '#MT-2045 Status changed to In Progress. Technician James started work.',
        timestamp: now.subtract(const Duration(hours: 1)),
        isRead: false,
        referenceId: '#MT-2045',
      ),
      NotificationEntity(
        id: 'n4',
        type: NotificationType.announcement,
        title: 'General Announcement',
        description: 'Mandatory safety briefing tomorrow at 08:00 AM in the South Wing Staff Room.',
        timestamp: now.subtract(const Duration(hours: 22)),
        isRead: true,
      ),
      NotificationEntity(
        id: 'n5',
        type: NotificationType.resolved,
        title: 'Ticket Resolved',
        description: '#MT-2040 Plumbing issue in Restroom A, Level 1 has been resolved and verified.',
        timestamp: now.subtract(const Duration(days: 1, hours: 2)),
        isRead: true,
        referenceId: '#MT-2040',
      ),
      NotificationEntity(
        id: 'n6',
        type: NotificationType.assignment,
        title: 'New Ticket Assigned',
        description: '#MT-2052 Spillage - Main Atrium. Requires immediate cleaning to prevent slip hazards.',
        timestamp: now.subtract(const Duration(days: 1, hours: 5)),
        isRead: true,
        referenceId: '#MT-2052',
      ),
      NotificationEntity(
        id: 'n7',
        type: NotificationType.critical,
        title: 'Security Alert',
        description: 'Unauthorized access detected at Service Entrance C. Security team dispatched.',
        timestamp: now.subtract(const Duration(days: 2)),
        isRead: true,
      ),
    ];
  }

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate network latency
    return List.unmodifiable(_notifications);
  }

  @override
  Future<List<NotificationEntity>> searchNotifications(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final lowerQuery = query.toLowerCase().trim();
    return _notifications.where((n) {
      return n.title.toLowerCase().contains(lowerQuery) ||
          n.description.toLowerCase().contains(lowerQuery) ||
          (n.referenceId != null && n.referenceId!.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  @override
  Future<List<NotificationEntity>> filterNotifications(NotificationFilter filter) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (filter == NotificationFilter.all) {
      return List.unmodifiable(_notifications);
    }
    
    return _notifications.where((n) {
      switch (filter) {
        case NotificationFilter.unread:
          return !n.isRead;
        case NotificationFilter.assignments:
          return n.type == NotificationType.assignment;
        case NotificationFilter.critical:
          return n.type == NotificationType.critical;
        case NotificationFilter.resolved:
          return n.type == NotificationType.resolved;
        default:
          return true;
      }
    }).toList();
  }

  @override
  Future<void> markNotificationRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  @override
  Future<void> markAllNotificationsRead() async {
    await Future.delayed(const Duration(milliseconds: 400));
    for (int i = 0; i < _notifications.length; i++) {
      if (!_notifications[i].isRead) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
    }
  }

  @override
  Future<List<NotificationEntity>> refreshNotifications() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.unmodifiable(_notifications);
  }
}
