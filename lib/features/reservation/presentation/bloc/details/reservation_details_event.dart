import 'package:equatable/equatable.dart';

abstract class ReservationDetailsEvent extends Equatable {
  const ReservationDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadReservationDetails extends ReservationDetailsEvent {
  final String id;

  const LoadReservationDetails(this.id);

  @override
  List<Object> get props => [id];
}

enum ReservationOperation { confirm, checkIn, seat, complete, cancel, noShow }

class PerformReservationOperation extends ReservationDetailsEvent {
  final String id;
  final ReservationOperation operation;

  const PerformReservationOperation(this.id, this.operation);

  @override
  List<Object> get props => [id, operation];
}
