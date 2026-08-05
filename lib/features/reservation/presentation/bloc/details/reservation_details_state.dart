import 'package:equatable/equatable.dart';
import '../../../domain/entities/reservation_details_entity.dart';

abstract class ReservationDetailsState extends Equatable {
  const ReservationDetailsState();

  @override
  List<Object?> get props => [];
}

class ReservationDetailsInitial extends ReservationDetailsState {}

class ReservationDetailsLoading extends ReservationDetailsState {}

class ReservationDetailsLoaded extends ReservationDetailsState {
  final ReservationDetailsEntity details;

  const ReservationDetailsLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

class ReservationDetailsError extends ReservationDetailsState {
  final String message;

  const ReservationDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReservationDetailsOperationLoading extends ReservationDetailsState {
  final ReservationDetailsEntity details;

  const ReservationDetailsOperationLoading(this.details);

  @override
  List<Object?> get props => [details];
}

class ReservationDetailsOperationSuccess extends ReservationDetailsState {
  final String message;
  final ReservationDetailsEntity details;

  const ReservationDetailsOperationSuccess(this.message, this.details);

  @override
  List<Object?> get props => [message, details];
}

class ReservationDetailsOperationFailure extends ReservationDetailsState {
  final String message;
  final ReservationDetailsEntity details;

  const ReservationDetailsOperationFailure(this.message, this.details);

  @override
  List<Object?> get props => [message, details];
}
