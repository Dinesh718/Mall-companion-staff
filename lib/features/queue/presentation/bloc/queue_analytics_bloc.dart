import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_queue_analytics_usecase.dart';
import 'queue_analytics_event.dart';
import 'queue_analytics_state.dart';

class QueueAnalyticsBloc extends Bloc<QueueAnalyticsEvent, QueueAnalyticsState> {
  final GetQueueAnalyticsUseCase getQueueAnalyticsUseCase;

  QueueAnalyticsBloc({required this.getQueueAnalyticsUseCase})
      : super(const QueueAnalyticsInitial()) {
    on<LoadQueueAnalytics>(_onLoadQueueAnalytics);
    on<RefreshQueueAnalytics>(_onRefreshQueueAnalytics);
    on<ChangeDateRange>(_onChangeDateRange);
  }

  Future<void> _onLoadQueueAnalytics(
    LoadQueueAnalytics event,
    Emitter<QueueAnalyticsState> emit,
  ) async {
    emit(const QueueAnalyticsLoading());
    try {
      final analytics = await getQueueAnalyticsUseCase(range: event.range);
      emit(QueueAnalyticsLoaded(analytics: analytics, range: event.range));
    } catch (e) {
      emit(QueueAnalyticsError(e.toString()));
    }
  }

  Future<void> _onRefreshQueueAnalytics(
    RefreshQueueAnalytics event,
    Emitter<QueueAnalyticsState> emit,
  ) async {
    emit(const QueueAnalyticsLoading());
    try {
      final analytics = await getQueueAnalyticsUseCase(range: event.range);
      emit(QueueAnalyticsLoaded(analytics: analytics, range: event.range));
    } catch (e) {
      emit(QueueAnalyticsError(e.toString()));
    }
  }

  Future<void> _onChangeDateRange(
    ChangeDateRange event,
    Emitter<QueueAnalyticsState> emit,
  ) async {
    emit(const QueueAnalyticsLoading());
    try {
      final analytics = await getQueueAnalyticsUseCase(range: event.newRange);
      emit(QueueAnalyticsLoaded(analytics: analytics, range: event.newRange));
    } catch (e) {
      emit(QueueAnalyticsError(e.toString()));
    }
  }
}
