import 'package:equatable/equatable.dart';
import '../../domain/entities/security_dashboard_entity.dart';

abstract class SecurityDashboardState extends Equatable {
  const SecurityDashboardState();
  
  @override
  List<Object?> get props => [];
}

class SecurityDashboardInitial extends SecurityDashboardState {}

class SecurityDashboardLoading extends SecurityDashboardState {}

class SecurityDashboardLoaded extends SecurityDashboardState {
  final SecurityDashboardEntity dashboardData;

  const SecurityDashboardLoaded({required this.dashboardData});

  @override
  List<Object?> get props => [dashboardData];
}

class SecurityDashboardError extends SecurityDashboardState {
  final String message;

  const SecurityDashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}
