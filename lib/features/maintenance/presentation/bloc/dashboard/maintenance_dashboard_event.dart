import 'package:equatable/equatable.dart';

abstract class MaintenanceDashboardEvent extends Equatable {
  const MaintenanceDashboardEvent();

  @override
  List<Object> get props => [];
}

class LoadMaintenanceDashboard extends MaintenanceDashboardEvent {
  const LoadMaintenanceDashboard();
}

class RefreshMaintenanceDashboard extends MaintenanceDashboardEvent {
  const RefreshMaintenanceDashboard();
}
