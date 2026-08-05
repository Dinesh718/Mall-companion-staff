import '../entities/reservation_entity.dart';
import '../repositories/reservation_repository.dart';

class EditReservationUseCase {
  final ReservationRepository repository;

  EditReservationUseCase(this.repository);

  Future<void> call(ReservationEntity reservation) async {
    return await repository.updateReservation(reservation);
  }
}
