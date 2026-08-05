enum QueuePriority {
  normal,
  vip,
  senior;

  String toDisplayString() {
    switch (this) {
      case QueuePriority.normal:
        return 'Normal';
      case QueuePriority.vip:
        return 'VIP';
      case QueuePriority.senior:
        return 'Senior';
    }
  }

  static QueuePriority fromString(String val) {
    switch (val.trim().toLowerCase()) {
      case 'vip':
        return QueuePriority.vip;
      case 'senior':
        return QueuePriority.senior;
      default:
        return QueuePriority.normal;
    }
  }
}
