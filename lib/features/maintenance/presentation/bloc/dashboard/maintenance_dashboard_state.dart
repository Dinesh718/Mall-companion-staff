import 'package:equatable/equatable.dart';
import '../../../domain/entities/maintenance_dashboard_entity.dart';

abstract class MaintenanceDashboardState extends Equatable {
  const MaintenanceDashboardState();

  @override
  List<Object> get props => [];
}

class MaintenanceDashboardInitial extends MaintenanceDashboardState {}

class MaintenanceDashboardLoading extends MaintenanceDashboardState {}

class MaintenanceDashboardLoaded extends MaintenanceDashboardState {
  final MaintenanceDashboardEntity dashboard;

  const MaintenanceDashboardLoaded({required this.dashboard});

  @override
  List<Object> get props => [dashboard];
}

class MaintenanceDashboardError extends MaintenanceDashboardState {
  final String errorMessage;

  const MaintenanceDashboardError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
