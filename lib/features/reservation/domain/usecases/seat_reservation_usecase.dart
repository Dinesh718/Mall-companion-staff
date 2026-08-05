import '../entities/reservation_details_entity.dart';
import '../repositories/reservation_repository.dart';

class SeatReservationUseCase {
  final ReservationRepository repository;

  SeatReservationUseCase(this.repository);

  Future<ReservationDetailsEntity> call(String id) {
    return repository.seatReservation(id);
  }
}
