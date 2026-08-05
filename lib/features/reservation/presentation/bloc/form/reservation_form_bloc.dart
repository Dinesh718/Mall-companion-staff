import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/reservation_entity.dart';
import '../../../domain/usecases/create_reservation_usecase.dart';
import '../../../domain/usecases/edit_reservation_usecase.dart';
import 'reservation_form_event.dart';
import 'reservation_form_state.dart';

class ReservationFormBloc extends Bloc<ReservationFormEvent, ReservationFormState> {
  final CreateReservationUseCase createReservationUseCase;
  final EditReservationUseCase editReservationUseCase;

  ReservationFormBloc({
    required this.createReservationUseCase,
    required this.editReservationUseCase,
  }) : super(const ReservationFormState()) {
    on<UpdateCustomerDetails>(_onUpdateCustomerDetails);
    on<UpdateSchedule>(_onUpdateSchedule);
    on<UpdateParty>(_onUpdateParty);
    on<UpdateTable>(_onUpdateTable);
    on<UpdatePreferences>(_onUpdatePreferences);
    on<SubmitReservation>(_onSubmitReservation);
    on<SubmitEditReservation>(_onSubmitEditReservation);
    on<LoadEditData>(_onLoadEditData);
  }

  void _onLoadEditData(LoadEditData event, Emitter<ReservationFormState> emit) {
    emit(state.copyWith(
      isEditing: true,
      reservationId: event.reservationId,
      customerName: event.customerName,
      customerEmail: event.customerEmail,
      customerPhone: event.customerPhone,
      date: event.date,
      time: event.time,
      adults: event.guestsCount,
      children: 0,
      specialRequests: event.specialRequests ?? '',
    ));
  }

  void _onUpdateCustomerDetails(UpdateCustomerDetails event, Emitter<ReservationFormState> emit) {
    emit(state.copyWith(
      customerName: event.name,
      customerEmail: event.email,
      customerPhone: event.phone,
      notificationPreference: event.notificationPreference,
    ));
  }

  void _onUpdateSchedule(UpdateSchedule event, Emitter<ReservationFormState> emit) {
    emit(state.copyWith(
      date: event.date,
      time: event.time,
      durationMinutes: event.durationMinutes,
    ));
  }

  void _onUpdateParty(UpdateParty event, Emitter<ReservationFormState> emit) {
    emit(state.copyWith(
      adults: event.adults,
      children: event.children,
    ));
  }

  void _onUpdateTable(UpdateTable event, Emitter<ReservationFormState> emit) {
    emit(state.copyWith(
      tableId: event.tableId,
      area: event.area,
    ));
  }

  void _onUpdatePreferences(UpdatePreferences event, Emitter<ReservationFormState> emit) {
    emit(state.copyWith(
      occasion: event.occasion,
      seatingPreference: event.seatingPreference,
      specialRequests: event.specialRequests,
      internalNotes: event.internalNotes,
    ));
  }

  Future<void> _onSubmitReservation(SubmitReservation event, Emitter<ReservationFormState> emit) async {
    emit(state.copyWith(status: ReservationFormStatus.loading));
    try {
      final now = DateTime.now();
      // Combine date and time if available, otherwise just use now
      DateTime reservationTime = now;
      if (state.date != null) {
        reservationTime = state.date!;
      }

      final entity = ReservationEntity(
        id: 'RES-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        customerName: state.customerName.isNotEmpty ? state.customerName : 'Walk-in Guest',
        time: reservationTime,
        guestsCount: state.totalGuests,
        status: ReservationStatus.confirmed,
        contactNumber: state.customerPhone.isNotEmpty ? state.customerPhone : null,
        specialRequests: state.specialRequests.isNotEmpty ? state.specialRequests : null,
      );

      await createReservationUseCase(entity);
      
      emit(state.copyWith(status: ReservationFormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ReservationFormStatus.failure, errorMessage: 'Failed to create reservation: ${e.toString()}'));
    }
  }

  Future<void> _onSubmitEditReservation(SubmitEditReservation event, Emitter<ReservationFormState> emit) async {
    emit(state.copyWith(status: ReservationFormStatus.loading));
    try {
      if (state.reservationId == null) {
        throw Exception('Reservation ID is null');
      }
      
      final now = DateTime.now();
      DateTime reservationTime = state.date ?? now;

      final entity = ReservationEntity(
        id: state.reservationId!,
        customerName: state.customerName.isNotEmpty ? state.customerName : 'Walk-in Guest',
        time: reservationTime,
        guestsCount: state.totalGuests,
        status: ReservationStatus.confirmed, // Usually we keep the previous status, but mock will suffice
        contactNumber: state.customerPhone.isNotEmpty ? state.customerPhone : null,
        specialRequests: state.specialRequests.isNotEmpty ? state.specialRequests : null,
      );

      await editReservationUseCase(entity);
      
      emit(state.copyWith(status: ReservationFormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ReservationFormStatus.failure, errorMessage: 'Failed to update reservation: ${e.toString()}'));
    }
  }
}
