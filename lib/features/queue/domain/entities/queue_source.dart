enum QueueSource {
  inPerson,
  kiosk,
  concierge;

  String toDisplayString() {
    switch (this) {
      case QueueSource.inPerson:
        return 'In-Person Desk';
      case QueueSource.kiosk:
        return 'Phone Kiosk';
      case QueueSource.concierge:
        return 'Mall Concierge';
    }
  }

  static QueueSource fromString(String val) {
    switch (val.trim().toLowerCase()) {
      case 'phone kiosk':
      case 'kiosk':
        return QueueSource.kiosk;
      case 'mall concierge':
      case 'concierge':
        return QueueSource.concierge;
      default:
        return QueueSource.inPerson;
    }
  }
}
