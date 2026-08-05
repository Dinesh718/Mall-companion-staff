import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/reservation/domain/usecases/get_reservation_details_usecase.dart';
import 'package:mall_companion_staff/features/reservation/domain/usecases/confirm_reservation_usecase.dart';
import 'package:mall_companion_staff/features/reservation/domain/usecases/check_in_reservation_usecase.dart';
import 'package:mall_companion_staff/features/reservation/domain/usecases/seat_reservation_usecase.dart';
import 'package:mall_companion_staff/features/reservation/domain/usecases/complete_reservation_usecase.dart';
import 'package:mall_companion_staff/features/reservation/domain/usecases/cancel_reservation_usecase.dart';
import 'package:mall_companion_staff/features/reservation/domain/usecases/mark_no_show_reservation_usecase.dart';
import 'package:mall_companion_staff/features/reservation/presentation/bloc/details/reservation_details_bloc.dart';
import 'package:mall_companion_staff/features/reservation/presentation/bloc/details/reservation_details_event.dart';
import 'package:mall_companion_staff/features/reservation/presentation/bloc/details/reservation_details_state.dart';
import 'package:mall_companion_staff/features/reservation/domain/entities/reservation_details_entity.dart';
import 'package:mall_companion_staff/features/reservation/domain/entities/reservation_entity.dart';
import 'package:mall_companion_staff/features/reservation/domain/repositories/reservation_repository.dart';

class FakeGetDetailsUseCase implements GetReservationDetailsUseCase {
  late ReservationDetailsEntity returnValue;
  
  @override
  late final ReservationRepository repository;

  @override
  Future<ReservationDetailsEntity> call(String id) async => returnValue;
}

class FakeConfirmUseCase implements ConfirmReservationUseCase {
  late ReservationDetailsEntity returnValue;
  @override late final ReservationRepository repository;
  @override Future<ReservationDetailsEntity> call(String id) async => returnValue;
}

class FakeCheckInUseCase implements CheckInReservationUseCase {
  late ReservationDetailsEntity returnValue;
  @override late final ReservationRepository repository;
  @override Future<ReservationDetailsEntity> call(String id) async => returnValue;
}

class FakeSeatUseCase implements SeatReservationUseCase {
  late ReservationDetailsEntity returnValue;
  @override late final ReservationRepository repository;
  @override Future<ReservationDetailsEntity> call(String id) async => returnValue;
}

class FakeCompleteUseCase implements CompleteReservationUseCase {
  late ReservationDetailsEntity returnValue;
  @override late final ReservationRepository repository;
  @override Future<ReservationDetailsEntity> call(String id) async => returnValue;
}

class FakeCancelUseCase implements CancelReservationUseCase {
  late ReservationDetailsEntity returnValue;
  @override late final ReservationRepository repository;
  @override Future<ReservationDetailsEntity> call(String id) async => returnValue;
}

class FakeNoShowUseCase implements MarkNoShowReservationUseCase {
  late ReservationDetailsEntity returnValue;
  @override late final ReservationRepository repository;
  @override Future<ReservationDetailsEntity> call(String id) async => returnValue;
}

void main() {
  late ReservationDetailsBloc bloc;
  late FakeGetDetailsUseCase getDetailsUseCase;
  late FakeConfirmUseCase confirmUseCase;
  late FakeCheckInUseCase checkInUseCase;
  late FakeSeatUseCase seatUseCase;
  late FakeCompleteUseCase completeUseCase;
  late FakeCancelUseCase cancelUseCase;
  late FakeNoShowUseCase noShowUseCase;

  final tReservation = ReservationEntity(
    id: 'RES-123',
    customerName: 'Test Customer',
    time: DateTime.now(),
    guestsCount: 2,
    status: ReservationStatus.pending,
    contactNumber: '1234567890',
  );

  final tDetails = ReservationDetailsEntity(
    baseInfo: tReservation,
    membershipLevel: 'Gold',
    email: 'test@example.com',
    avatarUrl: '',
    insightTitle: 'Insight',
    insightDescription: 'Desc',
    table: 'T1',
    area: 'Main',
    type: 'Dinner',
    preference: 'Window',
    occasion: 'Birthday',
    bookingSource: 'App',
    specialRequestTags: [],
    internalStaffNotes: '',
    timeline: [],
  );

  setUp(() {
    getDetailsUseCase = FakeGetDetailsUseCase();
    confirmUseCase = FakeConfirmUseCase();
    checkInUseCase = FakeCheckInUseCase();
    seatUseCase = FakeSeatUseCase();
    completeUseCase = FakeCompleteUseCase();
    cancelUseCase = FakeCancelUseCase();
    noShowUseCase = FakeNoShowUseCase();

    bloc = ReservationDetailsBloc(
      getReservationDetailsUseCase: getDetailsUseCase,
      confirmReservationUseCase: confirmUseCase,
      checkInReservationUseCase: checkInUseCase,
      seatReservationUseCase: seatUseCase,
      completeReservationUseCase: completeUseCase,
      cancelReservationUseCase: cancelUseCase,
      markNoShowReservationUseCase: noShowUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('ReservationDetailsBloc', () {
    test('initial state is ReservationDetailsInitial', () {
      expect(bloc.state, isA<ReservationDetailsInitial>());
    });

    test('LoadReservationDetails emits Loading and Loaded', () async {
      getDetailsUseCase.returnValue = tDetails;

      bloc.add(const LoadReservationDetails('RES-123'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ReservationDetailsLoading>(),
          isA<ReservationDetailsLoaded>(),
        ]),
      );
    });

    test('PerformReservationOperation emits OperationLoading and OperationSuccess', () async {
      // First load details
      getDetailsUseCase.returnValue = tDetails;
      bloc.add(const LoadReservationDetails('RES-123'));
      await Future.delayed(Duration.zero); // Wait for load to process

      // Then perform operation
      final tConfirmed = ReservationEntity(
        id: 'RES-123',
        customerName: 'Test Customer',
        time: DateTime.now(),
        guestsCount: 2,
        status: ReservationStatus.confirmed,
        contactNumber: '1234567890',
      );
      final tConfirmedDetails = ReservationDetailsEntity(
        baseInfo: tConfirmed, 
        membershipLevel: 'Gold', 
        email: 'test@example.com',
        avatarUrl: '',
        insightTitle: 'Insight',
        insightDescription: 'Desc',
        table: 'T1',
        area: 'Main',
        type: 'Dinner',
        preference: 'Window',
        occasion: 'Birthday',
        bookingSource: 'App',
        specialRequestTags: [],
        internalStaffNotes: '',
        timeline: []
      );
      confirmUseCase.returnValue = tConfirmedDetails;

      bloc.add(const PerformReservationOperation('RES-123', ReservationOperation.confirm));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ReservationDetailsOperationLoading>(),
          isA<ReservationDetailsOperationSuccess>(),
          isA<ReservationDetailsLoaded>(),
        ]),
      );
    });
  });
}
