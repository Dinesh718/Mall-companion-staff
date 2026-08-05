import 'package:equatable/equatable.dart';

abstract class SecurityDashboardEvent extends Equatable {
  const SecurityDashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadSecurityDashboardRequested extends SecurityDashboardEvent {
  const LoadSecurityDashboardRequested();
}

class RefreshSecurityDashboardRequested extends SecurityDashboardEvent {
  const RefreshSecurityDashboardRequested();
}
