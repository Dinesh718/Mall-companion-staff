import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/reservation/data/repositories/mock_reservation_repository.dart';
import 'package:mall_companion_staff/features/reservation/domain/entities/reservation_entity.dart';

void main() {
  late MockReservationRepository repository;

  setUp(() {
    repository = MockReservationRepository();
  });

  group('MockReservationRepository Operations', () {
    test('confirmReservation updates status to confirmed and adds timeline event', () async {
      final details = await repository.confirmReservation('RES-123');
      expect(details.baseInfo.status, ReservationStatus.confirmed);
      expect(details.timeline.first.title, 'Reservation Confirmed');
    });

    test('checkInReservation updates status to checkedIn and adds timeline event', () async {
      final details = await repository.checkInReservation('RES-123');
      expect(details.baseInfo.status, ReservationStatus.checkedIn);
      expect(details.timeline.first.title, 'Customer Checked In');
    });

    test('seatReservation updates status to seated and adds timeline event', () async {
      final details = await repository.seatReservation('RES-123');
      expect(details.baseInfo.status, ReservationStatus.seated);
      expect(details.timeline.first.title, 'Customer Seated');
    });

    test('completeReservation updates status to completed and adds timeline event', () async {
      final details = await repository.completeReservation('RES-123');
      expect(details.baseInfo.status, ReservationStatus.completed);
      expect(details.timeline.first.title, 'Reservation Completed');
    });

    test('cancelReservation updates status to cancelled and adds timeline event', () async {
      final details = await repository.cancelReservation('RES-123');
      expect(details.baseInfo.status, ReservationStatus.cancelled);
      expect(details.timeline.first.title, 'Reservation Cancelled');
    });

    test('markReservationNoShow updates status to noShow and adds timeline event', () async {
      final details = await repository.markReservationNoShow('RES-123');
      expect(details.baseInfo.status, ReservationStatus.noShow);
      expect(details.timeline.first.title, 'Marked No Show');
    });
  });
}
