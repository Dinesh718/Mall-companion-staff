import 'package:equatable/equatable.dart';

enum ReservationStatus { confirmed, checkedIn, seated, completed, cancelled, noShow, pending }

class ReservationEntity extends Equatable {
  final String id;
  final String customerName;
  final DateTime time;
  final int guestsCount;
  final ReservationStatus status;
  final String? contactNumber;
  final String? specialRequests;

  const ReservationEntity({
    required this.id,
    required this.customerName,
    required this.time,
    required this.guestsCount,
    required this.status,
    this.contactNumber,
    this.specialRequests,
  });

  @override
  List<Object?> get props => [
        id,
        customerName,
        time,
        guestsCount,
        status,
        contactNumber,
        specialRequests,
      ];
}
