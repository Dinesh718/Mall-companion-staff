import '../entities/reservation_details_entity.dart';
import '../repositories/reservation_repository.dart';

class MarkNoShowReservationUseCase {
  final ReservationRepository repository;

  MarkNoShowReservationUseCase(this.repository);

  Future<ReservationDetailsEntity> call(String id) {
    return repository.markReservationNoShow(id);
  }
}
