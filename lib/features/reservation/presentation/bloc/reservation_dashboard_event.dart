import 'package:equatable/equatable.dart';

abstract class ReservationDashboardEvent extends Equatable {
  const ReservationDashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadReservationDashboard extends ReservationDashboardEvent {
  const LoadReservationDashboard();
}

class RefreshReservationDashboard extends ReservationDashboardEvent {
  const RefreshReservationDashboard();
}
