import '../entities/reservation_details_entity.dart';
import '../repositories/reservation_repository.dart';

class CancelReservationUseCase {
  final ReservationRepository repository;

  CancelReservationUseCase(this.repository);

  Future<ReservationDetailsEntity> call(String id) {
    return repository.cancelReservation(id);
  }
}
