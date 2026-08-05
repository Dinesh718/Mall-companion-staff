import '../entities/reservation_details_entity.dart';
import '../repositories/reservation_repository.dart';

class CheckInReservationUseCase {
  final ReservationRepository repository;

  CheckInReservationUseCase(this.repository);

  Future<ReservationDetailsEntity> call(String id) {
    return repository.checkInReservation(id);
  }
}
