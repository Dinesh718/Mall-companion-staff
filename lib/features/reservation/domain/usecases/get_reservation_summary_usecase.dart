import '../entities/reservation_summary_entity.dart';
import '../repositories/reservation_repository.dart';

class GetReservationSummaryUseCase {
  final ReservationRepository repository;

  GetReservationSummaryUseCase(this.repository);

  Future<ReservationSummaryEntity> call() async {
    return await repository.getReservationSummary();
  }
}
