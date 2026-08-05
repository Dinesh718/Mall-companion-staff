enum QueueFilter {
  all,
  waiting,
  called,
  arrived,
  serving,
  completed,
  cancelled,
  skipped;

  String toDisplayString() {
    switch (this) {
      case QueueFilter.all:
        return 'All';
      case QueueFilter.waiting:
        return 'Waiting';
      case QueueFilter.called:
        return 'Called';
      case QueueFilter.arrived:
        return 'Arrived';
      case QueueFilter.serving:
        return 'Serving';
      case QueueFilter.completed:
        return 'Completed';
      case QueueFilter.cancelled:
        return 'Cancelled';
      case QueueFilter.skipped:
        return 'Skipped';
    }
  }
}
