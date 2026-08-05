import 'package:equatable/equatable.dart';

abstract class ReservationFormEvent extends Equatable {
  const ReservationFormEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCustomerDetails extends ReservationFormEvent {
  final String name;
  final String email;
  final String phone;
  final String notificationPreference;

  const UpdateCustomerDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.notificationPreference,
  });

  @override
  List<Object?> get props => [name, email, phone, notificationPreference];
}

class UpdateSchedule extends ReservationFormEvent {
  final DateTime? date;
  final String? time;
  final int durationMinutes;

  const UpdateSchedule({
    this.date,
    this.time,
    required this.durationMinutes,
  });

  @override
  List<Object?> get props => [date, time, durationMinutes];
}

class UpdateParty extends ReservationFormEvent {
  final int adults;
  final int children;

  const UpdateParty({
    required this.adults,
    required this.children,
  });

  @override
  List<Object?> get props => [adults, children];
}

class UpdateTable extends ReservationFormEvent {
  final String? tableId;
  final String? area;

  const UpdateTable({
    this.tableId,
    this.area,
  });

  @override
  List<Object?> get props => [tableId, area];
}

class UpdatePreferences extends ReservationFormEvent {
  final String occasion;
  final String seatingPreference;
  final String specialRequests;
  final String internalNotes;

  const UpdatePreferences({
    required this.occasion,
    required this.seatingPreference,
    required this.specialRequests,
    required this.internalNotes,
  });

  @override
  List<Object?> get props => [occasion, seatingPreference, specialRequests, internalNotes];
}

class SubmitReservation extends ReservationFormEvent {}

class SubmitEditReservation extends ReservationFormEvent {}

class LoadEditData extends ReservationFormEvent {
  final String reservationId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final DateTime date;
  final String time;
  final int guestsCount;
  final String? specialRequests;

  const LoadEditData({
    required this.reservationId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.date,
    required this.time,
    required this.guestsCount,
    this.specialRequests,
  });

  @override
  List<Object?> get props => [
        reservationId,
        customerName,
        customerEmail,
        customerPhone,
        date,
        time,
        guestsCount,
        specialRequests,
      ];
}
