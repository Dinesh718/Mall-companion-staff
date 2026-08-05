import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_maintenance_dashboard_usecase.dart';
import 'maintenance_dashboard_event.dart';
import 'maintenance_dashboard_state.dart';

class MaintenanceDashboardBloc extends Bloc<MaintenanceDashboardEvent, MaintenanceDashboardState> {
  final GetMaintenanceDashboardUseCase getMaintenanceDashboardUseCase;

  MaintenanceDashboardBloc({
    required this.getMaintenanceDashboardUseCase,
  }) : super(MaintenanceDashboardInitial()) {
    on<LoadMaintenanceDashboard>(_onLoadDashboard);
    on<RefreshMaintenanceDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadMaintenanceDashboard event,
    Emitter<MaintenanceDashboardState> emit,
  ) async {
    emit(MaintenanceDashboardLoading());
    try {
      final dashboard = await getMaintenanceDashboardUseCase();
      emit(MaintenanceDashboardLoaded(dashboard: dashboard));
    } catch (e) {
      emit(MaintenanceDashboardError(errorMessage: e.toString()));
    }
  }

  Future<void> _onRefreshDashboard(
    RefreshMaintenanceDashboard event,
    Emitter<MaintenanceDashboardState> emit,
  ) async {
    try {
      final dashboard = await getMaintenanceDashboardUseCase();
      emit(MaintenanceDashboardLoaded(dashboard: dashboard));
    } catch (e) {
      emit(MaintenanceDashboardError(errorMessage: e.toString()));
    }
  }
}
