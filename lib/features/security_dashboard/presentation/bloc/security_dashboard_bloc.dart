import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_security_dashboard_usecase.dart';
import 'security_dashboard_event.dart';
import 'security_dashboard_state.dart';

class SecurityDashboardBloc extends Bloc<SecurityDashboardEvent, SecurityDashboardState> {
  final GetSecurityDashboardUseCase getSecurityDashboardUseCase;

  SecurityDashboardBloc({required this.getSecurityDashboardUseCase}) : super(SecurityDashboardInitial()) {
    on<LoadSecurityDashboardRequested>(_onLoadSecurityDashboard);
    on<RefreshSecurityDashboardRequested>(_onRefreshSecurityDashboard);
  }

  Future<void> _onLoadSecurityDashboard(
    LoadSecurityDashboardRequested event,
    Emitter<SecurityDashboardState> emit,
  ) async {
    emit(SecurityDashboardLoading());
    try {
      final dashboardData = await getSecurityDashboardUseCase();
      emit(SecurityDashboardLoaded(dashboardData: dashboardData));
    } catch (e) {
      emit(SecurityDashboardError(message: 'Failed to load security dashboard: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshSecurityDashboard(
    RefreshSecurityDashboardRequested event,
    Emitter<SecurityDashboardState> emit,
  ) async {
    try {
      final dashboardData = await getSecurityDashboardUseCase();
      emit(SecurityDashboardLoaded(dashboardData: dashboardData));
    } catch (e) {
      emit(SecurityDashboardError(message: 'Failed to refresh security dashboard: ${e.toString()}'));
    }
  }
}
