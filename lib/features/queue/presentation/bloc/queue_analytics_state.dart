import 'package:equatable/equatable.dart';
import '../../domain/entities/queue_analytics_entity.dart';

abstract class QueueAnalyticsState extends Equatable {
  const QueueAnalyticsState();

  @override
  List<Object?> get props => [];
}

class QueueAnalyticsInitial extends QueueAnalyticsState {
  const QueueAnalyticsInitial();
}

class QueueAnalyticsLoading extends QueueAnalyticsState {
  const QueueAnalyticsLoading();
}

class QueueAnalyticsLoaded extends QueueAnalyticsState {
  final QueueAnalyticsEntity analytics;
  final String range;

  const QueueAnalyticsLoaded({
    required this.analytics,
    required this.range,
  });

  @override
  List<Object?> get props => [analytics, range];
}

class QueueAnalyticsError extends QueueAnalyticsState {
  final String message;

  const QueueAnalyticsError(this.message);

  @override
  List<Object?> get props => [message];
}
