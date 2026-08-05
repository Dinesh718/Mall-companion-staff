import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_reservation_details_usecase.dart';
import '../../../domain/usecases/confirm_reservation_usecase.dart';
import '../../../domain/usecases/check_in_reservation_usecase.dart';
import '../../../domain/usecases/seat_reservation_usecase.dart';
import '../../../domain/usecases/complete_reservation_usecase.dart';
import '../../../domain/usecases/cancel_reservation_usecase.dart';
import '../../../domain/usecases/mark_no_show_reservation_usecase.dart';
import 'reservation_details_event.dart';
import 'reservation_details_state.dart';
import '../../../domain/entities/reservation_details_entity.dart';

class ReservationDetailsBloc extends Bloc<ReservationDetailsEvent, ReservationDetailsState> {
  final GetReservationDetailsUseCase getReservationDetailsUseCase;
  final ConfirmReservationUseCase confirmReservationUseCase;
  final CheckInReservationUseCase checkInReservationUseCase;
  final SeatReservationUseCase seatReservationUseCase;
  final CompleteReservationUseCase completeReservationUseCase;
  final CancelReservationUseCase cancelReservationUseCase;
  final MarkNoShowReservationUseCase markNoShowReservationUseCase;

  ReservationDetailsBloc({
    required this.getReservationDetailsUseCase,
    required this.confirmReservationUseCase,
    required this.checkInReservationUseCase,
    required this.seatReservationUseCase,
    required this.completeReservationUseCase,
    required this.cancelReservationUseCase,
    required this.markNoShowReservationUseCase,
  }) : super(ReservationDetailsInitial()) {
    on<LoadReservationDetails>(_onLoadReservationDetails);
    on<PerformReservationOperation>(_onPerformReservationOperation);
  }

  Future<void> _onLoadReservationDetails(
    LoadReservationDetails event,
    Emitter<ReservationDetailsState> emit,
  ) async {
    emit(ReservationDetailsLoading());
    try {
      final details = await getReservationDetailsUseCase(event.id);
      emit(ReservationDetailsLoaded(details));
    } catch (e) {
      emit(ReservationDetailsError('Failed to load reservation details: ${e.toString()}'));
    }
  }

  Future<void> _onPerformReservationOperation(
    PerformReservationOperation event,
    Emitter<ReservationDetailsState> emit,
  ) async {
    ReservationDetailsEntity? currentDetails;
    if (state is ReservationDetailsLoaded) {
      currentDetails = (state as ReservationDetailsLoaded).details;
    } else if (state is ReservationDetailsOperationSuccess) {
      currentDetails = (state as ReservationDetailsOperationSuccess).details;
    } else if (state is ReservationDetailsOperationFailure) {
      currentDetails = (state as ReservationDetailsOperationFailure).details;
    }

    if (currentDetails == null) return;

    emit(ReservationDetailsOperationLoading(currentDetails));

    try {
      ReservationDetailsEntity updatedDetails;
      String successMessage;

      switch (event.operation) {
        case ReservationOperation.confirm:
          updatedDetails = await confirmReservationUseCase(event.id);
          successMessage = 'Reservation Confirmed';
          break;
        case ReservationOperation.checkIn:
          updatedDetails = await checkInReservationUseCase(event.id);
          successMessage = 'Customer Checked In';
          break;
        case ReservationOperation.seat:
          updatedDetails = await seatReservationUseCase(event.id);
          successMessage = 'Customer Seated';
          break;
        case ReservationOperation.complete:
          updatedDetails = await completeReservationUseCase(event.id);
          successMessage = 'Reservation Completed';
          break;
        case ReservationOperation.cancel:
          updatedDetails = await cancelReservationUseCase(event.id);
          successMessage = 'Reservation Cancelled';
          break;
        case ReservationOperation.noShow:
          updatedDetails = await markNoShowReservationUseCase(event.id);
          successMessage = 'Customer Marked as No Show';
          break;
      }

      emit(ReservationDetailsOperationSuccess(successMessage, updatedDetails));
      emit(ReservationDetailsLoaded(updatedDetails));
    } catch (e) {
      emit(ReservationDetailsOperationFailure('Operation failed: ${e.toString()}', currentDetails));
      emit(ReservationDetailsLoaded(currentDetails));
    }
  }
}
