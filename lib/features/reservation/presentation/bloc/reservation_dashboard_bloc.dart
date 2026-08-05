import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_dashboard_event.dart';
import 'reservation_dashboard_state.dart';
import '../../domain/usecases/get_reservation_summary_usecase.dart';
import '../../domain/usecases/get_reservation_statistics_usecase.dart';
import '../../domain/usecases/get_today_reservations_usecase.dart';

class ReservationDashboardBloc extends Bloc<ReservationDashboardEvent, ReservationDashboardState> {
  final GetReservationSummaryUseCase getSummaryUseCase;
  final GetReservationStatisticsUseCase getStatisticsUseCase;
  final GetTodayReservationsUseCase getReservationsUseCase;

  ReservationDashboardBloc({
    required this.getSummaryUseCase,
    required this.getStatisticsUseCase,
    required this.getReservationsUseCase,
  }) : super(const ReservationDashboardInitial()) {
    on<LoadReservationDashboard>(_onLoadDashboard);
    on<RefreshReservationDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadReservationDashboard event,
    Emitter<ReservationDashboardState> emit,
  ) async {
    emit(const ReservationDashboardLoading());
    await _fetchData(emit);
  }

  Future<void> _onRefreshDashboard(
    RefreshReservationDashboard event,
    Emitter<ReservationDashboardState> emit,
  ) async {
    await _fetchData(emit);
  }

  Future<void> _fetchData(Emitter<ReservationDashboardState> emit) async {
    try {
      final summaryFuture = getSummaryUseCase();
      final statsFuture = getStatisticsUseCase();
      final reservationsFuture = getReservationsUseCase();

      final summary = await summaryFuture;
      final statistics = await statsFuture;
      final todayReservations = await reservationsFuture;

      emit(ReservationDashboardLoaded(
        summary: summary,
        statistics: statistics,
        todayReservations: todayReservations,
      ));
    } catch (e) {
      emit(ReservationDashboardError(message: 'Failed to load reservation data: $e'));
    }
  }
}
