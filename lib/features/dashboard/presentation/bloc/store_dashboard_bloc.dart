import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/store_dashboard_repository.dart';
import 'store_dashboard_event.dart';
import 'store_dashboard_state.dart';

class StoreDashboardBloc extends Bloc<StoreDashboardEvent, StoreDashboardState> {
  final StoreDashboardRepository repository;

  StoreDashboardBloc({
    required this.repository,
  }) : super(const StoreDashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<StoreDashboardState> emit,
  ) async {
    emit(const StoreDashboardLoading());
    try {
      final dashboard = await repository.getDashboardData();
      emit(StoreDashboardLoaded(dashboard));
    } catch (e) {
      emit(StoreDashboardError(e.toString()));
    }
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboard event,
    Emitter<StoreDashboardState> emit,
  ) async {
    // We emit loading for refresh to show progress indicator
    emit(const StoreDashboardLoading());
    try {
      final dashboard = await repository.getDashboardData();
      emit(StoreDashboardLoaded(dashboard));
    } catch (e) {
      emit(StoreDashboardError(e.toString()));
    }
  }
}
