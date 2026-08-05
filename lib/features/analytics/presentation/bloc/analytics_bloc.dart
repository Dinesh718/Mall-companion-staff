import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_analytics_usecase.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final GetAnalyticsUseCase getAnalyticsUseCase;

  AnalyticsBloc({required this.getAnalyticsUseCase}) : super(AnalyticsInitial()) {
    on<LoadAnalyticsRequested>(_onLoadAnalytics);
    on<RefreshAnalyticsRequested>(_onRefreshAnalytics);
  }

  Future<void> _onLoadAnalytics(
      LoadAnalyticsRequested event, Emitter<AnalyticsState> emit) async {
    emit(AnalyticsLoading());
    try {
      final data = await getAnalyticsUseCase(event.timeRange);
      emit(AnalyticsLoaded(data: data, activeTimeRange: event.timeRange));
    } catch (e) {
      emit(AnalyticsError(e.toString()));
    }
  }

  Future<void> _onRefreshAnalytics(
      RefreshAnalyticsRequested event, Emitter<AnalyticsState> emit) async {
    final currentState = state;
    if (currentState is AnalyticsLoaded) {
      try {
        final data = await getAnalyticsUseCase(currentState.activeTimeRange);
        emit(AnalyticsLoaded(data: data, activeTimeRange: currentState.activeTimeRange));
      } catch (e) {
        emit(AnalyticsError(e.toString()));
      }
    }
  }
}
