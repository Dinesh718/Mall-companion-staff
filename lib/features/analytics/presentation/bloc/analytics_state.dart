import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_analytics_usecase.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final AnalyticsData data;
  final String activeTimeRange;

  const AnalyticsLoaded({
    required this.data,
    required this.activeTimeRange,
  });

  @override
  List<Object?> get props => [data, activeTimeRange];
}

class AnalyticsError extends AnalyticsState {
  final String message;

  const AnalyticsError(this.message);

  @override
  List<Object?> get props => [message];
}
