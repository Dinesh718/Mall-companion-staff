import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:mall_companion_staff/features/reservation/domain/usecases/edit_reservation_usecase.dart';
import 'package:mall_companion_staff/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:mall_companion_staff/features/reservation/domain/entities/reservation_entity.dart';
import 'package:mall_companion_staff/features/reservation/domain/entities/reservation_details_entity.dart';
import 'package:mall_companion_staff/features/reservation/domain/entities/reservation_statistics_entity.dart';
import 'package:mall_companion_staff/features/reservation/domain/entities/reservation_summary_entity.dart';
import 'package:mall_companion_staff/features/reservation/presentation/bloc/form/reservation_form_bloc.dart';
import 'package:mall_companion_staff/features/reservation/presentation/bloc/form/reservation_form_event.dart';
import 'package:mall_companion_staff/features/reservation/presentation/bloc/form/reservation_form_state.dart';

class FakeReservationRepository implements ReservationRepository {
  bool shouldThrow = false;
  
  @override
  Future<void> createReservation(ReservationEntity reservation) async {
    if (shouldThrow) throw Exception('Network Error');
  }

  @override
  Future<void> updateReservation(ReservationEntity reservation) async {
    if (shouldThrow) throw Exception('Network Error');
  }

  @override
  Future<ReservationStatisticsEntity> getReservationStatistics() async => throw UnimplementedError();

  @override
  Future<ReservationSummaryEntity> getReservationSummary() async => throw UnimplementedError();

  @override
  Future<List<ReservationEntity>> getTodayReservations() async => throw UnimplementedError();

  @override
  Future<ReservationDetailsEntity> getReservationDetails(String id) async => throw UnimplementedError();

  @override
  Future<ReservationDetailsEntity> confirmReservation(String id) async => throw UnimplementedError();

  @override
  Future<ReservationDetailsEntity> checkInReservation(String id) async => throw UnimplementedError();

  @override
  Future<ReservationDetailsEntity> seatReservation(String id) async => throw UnimplementedError();

  @override
  Future<ReservationDetailsEntity> completeReservation(String id) async => throw UnimplementedError();

  @override
  Future<ReservationDetailsEntity> cancelReservation(String id) async => throw UnimplementedError();

  @override
  Future<ReservationDetailsEntity> markReservationNoShow(String id) async => throw UnimplementedError();
}

void main() {
  late ReservationFormBloc bloc;
  late FakeReservationRepository fakeRepo;
  late CreateReservationUseCase createUseCase;
  late EditReservationUseCase editUseCase;

  setUp(() {
    fakeRepo = FakeReservationRepository();
    createUseCase = CreateReservationUseCase(fakeRepo);
    editUseCase = EditReservationUseCase(fakeRepo);
    bloc = ReservationFormBloc(
      createReservationUseCase: createUseCase,
      editReservationUseCase: editUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is correct', () {
    expect(bloc.state, const ReservationFormState());
  });

  test('UpdateCustomerDetails updates state', () {
    bloc.add(const UpdateCustomerDetails(
      name: 'John Doe',
      email: 'john@test.com',
      phone: '1234567890',
      notificationPreference: 'Email',
    ));
    expectLater(
      bloc.stream,
      emits(const ReservationFormState(
        customerName: 'John Doe',
        customerEmail: 'john@test.com',
        customerPhone: '1234567890',
        notificationPreference: 'Email',
      )),
    );
  });

  test('UpdateParty updates adults and children', () {
    bloc.add(const UpdateParty(adults: 6, children: 2));
    expectLater(
      bloc.stream,
      emits(const ReservationFormState(adults: 6, children: 2)),
    );
  });

  test('SubmitReservation handles success', () {
    final expectedStates = [
      const ReservationFormState(status: ReservationFormStatus.loading),
      const ReservationFormState(status: ReservationFormStatus.success),
    ];

    expectLater(bloc.stream, emitsInOrder(expectedStates));

    bloc.add(SubmitReservation());
  });

  test('SubmitReservation handles failure', () {
    fakeRepo.shouldThrow = true;
    final expectedStates = [
      const ReservationFormState(status: ReservationFormStatus.loading),
      const ReservationFormState(status: ReservationFormStatus.failure, errorMessage: 'Failed to create reservation: Exception: Network Error'),
    ];

    expectLater(bloc.stream, emitsInOrder(expectedStates));

    bloc.add(SubmitReservation());
  });
}
