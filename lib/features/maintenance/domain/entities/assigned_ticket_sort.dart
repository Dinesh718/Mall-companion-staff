enum AssignedTicketSort {
  newest,
  oldest,
  highestPriority,
  recentlyUpdated,
  dueSoon;

  String toDisplayString() {
    switch (this) {
      case AssignedTicketSort.newest:
        return 'Newest';
      case AssignedTicketSort.oldest:
        return 'Oldest';
      case AssignedTicketSort.highestPriority:
        return 'Highest Priority';
      case AssignedTicketSort.recentlyUpdated:
        return 'Recently Updated';
      case AssignedTicketSort.dueSoon:
        return 'Due Soon';
    }
  }
}
