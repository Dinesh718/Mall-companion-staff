enum QueueStatus {
  waiting,
  called,
  arrived,
  serving,
  completed,
  cancelled;

  String toDisplayString() {
    switch (this) {
      case QueueStatus.waiting:
        return 'Waiting';
      case QueueStatus.called:
        return 'Called';
      case QueueStatus.arrived:
        return 'Arrived';
      case QueueStatus.serving:
        return 'Serving';
      case QueueStatus.completed:
        return 'Completed';
      case QueueStatus.cancelled:
        return 'Cancelled';
    }
  }

  static QueueStatus fromString(String val) {
    switch (val.trim().toLowerCase()) {
      case 'called':
        return QueueStatus.called;
      case 'arrived':
        return QueueStatus.arrived;
      case 'serving':
        return QueueStatus.serving;
      case 'completed':
        return QueueStatus.completed;
      case 'cancelled':
      case 'canceled':
        return QueueStatus.cancelled;
      default:
        return QueueStatus.waiting;
    }
  }
}
