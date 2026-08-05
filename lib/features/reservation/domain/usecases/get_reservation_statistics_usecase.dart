import '../entities/reservation_statistics_entity.dart';
import '../repositories/reservation_repository.dart';

class GetReservationStatisticsUseCase {
  final ReservationRepository repository;

  GetReservationStatisticsUseCase(this.repository);

  Future<ReservationStatisticsEntity> call() async {
    return await repository.getReservationStatistics();
  }
}
