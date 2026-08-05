enum QueueSortOption {
  oldestFirst,
  newestFirst,
  longestWaiting,
  shortestWaiting,
  highestPriority,
  largestPartySize;

  String toDisplayString() {
    switch (this) {
      case QueueSortOption.oldestFirst:
        return 'Oldest First';
      case QueueSortOption.newestFirst:
        return 'Newest First';
      case QueueSortOption.longestWaiting:
        return 'Longest Waiting';
      case QueueSortOption.shortestWaiting:
        return 'Shortest Waiting';
      case QueueSortOption.highestPriority:
        return 'Highest Priority';
      case QueueSortOption.largestPartySize:
        return 'Largest Party Size';
    }
  }
}
