import 'package:flutter/foundation.dart';

@immutable
sealed class StoreDashboardEvent {
  const StoreDashboardEvent();
}

class LoadDashboard extends StoreDashboardEvent {
  const LoadDashboard();
}

class RefreshDashboard extends StoreDashboardEvent {
  const RefreshDashboard();
}
