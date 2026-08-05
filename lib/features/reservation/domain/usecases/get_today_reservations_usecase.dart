import '../entities/reservation_entity.dart';
import '../repositories/reservation_repository.dart';

class GetTodayReservationsUseCase {
  final ReservationRepository repository;

  GetTodayReservationsUseCase(this.repository);

  Future<List<ReservationEntity>> call() async {
    return await repository.getTodayReservations();
  }
}
