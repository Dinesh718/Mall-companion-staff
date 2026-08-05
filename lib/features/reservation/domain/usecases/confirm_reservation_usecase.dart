import '../entities/reservation_details_entity.dart';
import '../repositories/reservation_repository.dart';

class ConfirmReservationUseCase {
  final ReservationRepository repository;

  ConfirmReservationUseCase(this.repository);

  Future<ReservationDetailsEntity> call(String id) {
    return repository.confirmReservation(id);
  }
}
