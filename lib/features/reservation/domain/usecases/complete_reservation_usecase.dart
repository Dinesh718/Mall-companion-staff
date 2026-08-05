import '../entities/reservation_details_entity.dart';
import '../repositories/reservation_repository.dart';

class CompleteReservationUseCase {
  final ReservationRepository repository;

  CompleteReservationUseCase(this.repository);

  Future<ReservationDetailsEntity> call(String id) {
    return repository.completeReservation(id);
  }
}
