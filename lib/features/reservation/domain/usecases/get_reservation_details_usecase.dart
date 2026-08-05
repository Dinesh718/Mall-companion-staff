import '../entities/reservation_details_entity.dart';
import '../repositories/reservation_repository.dart';

class GetReservationDetailsUseCase {
  final ReservationRepository repository;

  GetReservationDetailsUseCase(this.repository);

  Future<ReservationDetailsEntity> call(String id) async {
    return await repository.getReservationDetails(id);
  }
}
