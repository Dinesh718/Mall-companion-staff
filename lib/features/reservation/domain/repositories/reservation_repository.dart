import '../entities/reservation_entity.dart';
import '../entities/reservation_summary_entity.dart';
import '../entities/reservation_statistics_entity.dart';
import '../entities/reservation_details_entity.dart';

abstract class ReservationRepository {
  Future<ReservationSummaryEntity> getReservationSummary();
  Future<ReservationStatisticsEntity> getReservationStatistics();
  Future<List<ReservationEntity>> getTodayReservations();
  Future<ReservationDetailsEntity> getReservationDetails(String id);
  Future<void> createReservation(ReservationEntity reservation);
  Future<void> updateReservation(ReservationEntity reservation);
  
  // Reservation Operations
  Future<ReservationDetailsEntity> confirmReservation(String id);
  Future<ReservationDetailsEntity> checkInReservation(String id);
  Future<ReservationDetailsEntity> seatReservation(String id);
  Future<ReservationDetailsEntity> completeReservation(String id);
  Future<ReservationDetailsEntity> cancelReservation(String id);
  Future<ReservationDetailsEntity> markReservationNoShow(String id);
}
