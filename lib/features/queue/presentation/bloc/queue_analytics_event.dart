import 'package:equatable/equatable.dart';

abstract class QueueAnalyticsEvent extends Equatable {
  const QueueAnalyticsEvent();

  @override
  List<Object?> get props => [];
}

class LoadQueueAnalytics extends QueueAnalyticsEvent {
  final String range;

  const LoadQueueAnalytics({this.range = 'Today'});

  @override
  List<Object?> get props => [range];
}

class RefreshQueueAnalytics extends QueueAnalyticsEvent {
  final String range;

  const RefreshQueueAnalytics({required this.range});

  @override
  List<Object?> get props => [range];
}

class ChangeDateRange extends QueueAnalyticsEvent {
  final String newRange;

  const ChangeDateRange({required this.newRange});

  @override
  List<Object?> get props => [newRange];
}
