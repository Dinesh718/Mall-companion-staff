import 'package:equatable/equatable.dart';
import '../../domain/entities/reservation_entity.dart';
import '../../domain/entities/reservation_summary_entity.dart';
import '../../domain/entities/reservation_statistics_entity.dart';

abstract class ReservationDashboardState extends Equatable {
  const ReservationDashboardState();

  @override
  List<Object?> get props => [];
}

class ReservationDashboardInitial extends ReservationDashboardState {
  const ReservationDashboardInitial();
}

class ReservationDashboardLoading extends ReservationDashboardState {
  const ReservationDashboardLoading();
}

class ReservationDashboardLoaded extends ReservationDashboardState {
  final ReservationSummaryEntity summary;
  final ReservationStatisticsEntity statistics;
  final List<ReservationEntity> todayReservations;

  const ReservationDashboardLoaded({
    required this.summary,
    required this.statistics,
    required this.todayReservations,
  });

  @override
  List<Object?> get props => [summary, statistics, todayReservations];
}

class ReservationDashboardError extends ReservationDashboardState {
  final String message;

  const ReservationDashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}
