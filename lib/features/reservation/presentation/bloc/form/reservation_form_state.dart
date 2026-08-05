import 'package:equatable/equatable.dart';

enum ReservationFormStatus { initial, loading, success, failure }

class ReservationFormState extends Equatable {
  final ReservationFormStatus status;
  final String? errorMessage;
  final bool isEditing;
  final String? reservationId;

  // Customer
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String notificationPreference;

  // Schedule
  final DateTime? date;
  final String? time;
  final int durationMinutes;

  // Party
  final int adults;
  final int children;

  // Table
  final String? tableId;
  final String? area;

  // Preferences
  final String occasion;
  final String seatingPreference;
  final String specialRequests;
  final String internalNotes;

  const ReservationFormState({
    this.status = ReservationFormStatus.initial,
    this.errorMessage,
    this.isEditing = false,
    this.reservationId,
    this.customerName = '',
    this.customerEmail = '',
    this.customerPhone = '',
    this.notificationPreference = 'SMS',
    this.date,
    this.time,
    this.durationMinutes = 90,
    this.adults = 4,
    this.children = 0,
    this.tableId,
    this.area,
    this.occasion = 'Standard',
    this.seatingPreference = 'Any',
    this.specialRequests = '',
    this.internalNotes = '',
  });

  int get totalGuests => adults + children;

  ReservationFormState copyWith({
    ReservationFormStatus? status,
    String? errorMessage,
    bool? isEditing,
    String? reservationId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? notificationPreference,
    DateTime? date,
    String? time,
    int? durationMinutes,
    int? adults,
    int? children,
    String? tableId,
    String? area,
    String? occasion,
    String? seatingPreference,
    String? specialRequests,
    String? internalNotes,
  }) {
    return ReservationFormState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isEditing: isEditing ?? this.isEditing,
      reservationId: reservationId ?? this.reservationId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
      notificationPreference: notificationPreference ?? this.notificationPreference,
      date: date ?? this.date,
      time: time ?? this.time,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      tableId: tableId ?? this.tableId,
      area: area ?? this.area,
      occasion: occasion ?? this.occasion,
      seatingPreference: seatingPreference ?? this.seatingPreference,
      specialRequests: specialRequests ?? this.specialRequests,
      internalNotes: internalNotes ?? this.internalNotes,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        isEditing,
        reservationId,
        customerName,
        customerEmail,
        customerPhone,
        notificationPreference,
        date,
        time,
        durationMinutes,
        adults,
        children,
        tableId,
        area,
        occasion,
        seatingPreference,
        specialRequests,
        internalNotes,
      ];
}
