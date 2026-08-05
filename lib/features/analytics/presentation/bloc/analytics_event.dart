import 'package:equatable/equatable.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAnalyticsRequested extends AnalyticsEvent {
  final String timeRange;

  const LoadAnalyticsRequested({this.timeRange = 'Month'});

  @override
  List<Object?> get props => [timeRange];
}

class RefreshAnalyticsRequested extends AnalyticsEvent {}
