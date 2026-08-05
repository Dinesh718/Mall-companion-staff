import 'package:flutter/foundation.dart';
import '../../domain/entities/store_dashboard_entity.dart';

@immutable
sealed class StoreDashboardState {
  const StoreDashboardState();
}

class StoreDashboardInitial extends StoreDashboardState {
  const StoreDashboardInitial();
}

class StoreDashboardLoading extends StoreDashboardState {
  const StoreDashboardLoading();
}

class StoreDashboardLoaded extends StoreDashboardState {
  final StoreDashboardEntity dashboard;

  const StoreDashboardLoaded(this.dashboard);
}

class StoreDashboardError extends StoreDashboardState {
  final String errorMessage;

  const StoreDashboardError(this.errorMessage);
}
