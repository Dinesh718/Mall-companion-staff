enum NotificationFilter {
  all,
  unread,
  assignments,
  critical,
  resolved;

  String toDisplayString() {
    switch (this) {
      case NotificationFilter.all:
        return 'All';
      case NotificationFilter.unread:
        return 'Unread';
      case NotificationFilter.assignments:
        return 'Assignments';
      case NotificationFilter.critical:
        return 'Critical';
      case NotificationFilter.resolved:
        return 'Resolved';
    }
  }
}
