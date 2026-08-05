import 'package:equatable/equatable.dart';

class ReservationSummaryEntity extends Equatable {
  final int totalReservations;
  final int completedReservations;
  final int upcomingReservations;
  final int cancelledReservations;
  final int totalGuests;

  const ReservationSummaryEntity({
    required this.totalReservations,
    required this.completedReservations,
    required this.upcomingReservations,
    required this.cancelledReservations,
    required this.totalGuests,
  });

  @override
  List<Object?> get props => [
        totalReservations,
        completedReservations,
        upcomingReservations,
        cancelledReservations,
        totalGuests,
      ];
}
