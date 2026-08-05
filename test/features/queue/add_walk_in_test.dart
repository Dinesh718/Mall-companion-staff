import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/queue/data/repositories/mock_queue_repository.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/create_queue_entry_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_summary_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/create_queue_entry_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/validate_queue_entry_usecase.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/add_walk_in_bloc.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/add_walk_in_event.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/add_walk_in_state.dart';
import 'package:mall_companion_staff/features/queue/presentation/pages/add_walk_in_customer_page.dart';

void main() {
  late MockQueueRepository repository;
  late ValidateQueueEntryUseCase validateUseCase;
  late CreateQueueEntryUseCase createUseCase;
  late AddWalkInBloc bloc;

  final testSummary = const QueueSummaryEntity(
    waitingCount: 15,
    servingCount: 3,
    completedCount: 40,
    cancelledCount: 1,
    avgWaitTimeMinutes: 10,
    healthStatus: 'Healthy',
    currentDate: 'Oct 24',
  );

  setUp(() {
    repository = MockQueueRepository();
    validateUseCase = ValidateQueueEntryUseCase();
    createUseCase = CreateQueueEntryUseCase(repository);
    bloc = AddWalkInBloc(
      createQueueEntryUseCase: createUseCase,
      validateQueueEntryUseCase: validateUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('ValidateQueueEntryUseCase Tests', () {
    test('returns error when name is empty', () async {
      const entry = CreateQueueEntryEntity(customerName: '', phoneNumber: '555-0199');
      final errors = await validateUseCase(entry);
      expect(errors['customerName'], 'Customer name is required');
    });

    test('returns error when phone number is too short', () async {
      const entry = CreateQueueEntryEntity(customerName: 'Alex', phoneNumber: '123');
      final errors = await validateUseCase(entry);
      expect(errors['phoneNumber'], 'Enter a valid 10-digit mobile number');
    });

    test('returns error when email format is invalid', () async {
      const entry = CreateQueueEntryEntity(
        customerName: 'Alex',
        phoneNumber: '555-000-0000',
        email: 'invalid-email',
      );
      final errors = await validateUseCase(entry);
      expect(errors['email'], 'Enter a valid email address');
    });

    test('returns no errors when parameters are valid', () async {
      const entry = CreateQueueEntryEntity(
        customerName: 'Alex Pierce',
        phoneNumber: '555-123-4567',
        email: 'alex@example.com',
      );
      final errors = await validateUseCase(entry);
      expect(errors.isEmpty, true);
    });
  });

  group('CreateQueueEntryUseCase Tests', () {
    test('throws exception on invalid registration info', () async {
      const entry = CreateQueueEntryEntity(customerName: '', phoneNumber: '');
      expect(() => createUseCase(entry), throwsException);
    });

    test('delegates to repository and succeeds on valid registration info', () async {
      const entry = CreateQueueEntryEntity(
        customerName: 'Alex Pierce',
        phoneNumber: '555-123-4567',
      );
      final created = await createUseCase(entry);
      expect(created.customerName, 'Alex Pierce');
      expect(created.token, isNotEmpty);
    });
  });

  group('AddWalkInBloc State Flow Tests', () {
    test('initial state is AddWalkInInitial', () {
      expect(bloc.state, const AddWalkInInitial());
    });

    test('InitializeAddWalkIn event emits Editing with empty form state', () async {
      bloc.add(const InitializeAddWalkIn());
      await bloc.stream.firstWhere((s) => s is AddWalkInEditing);

      final state = bloc.state as AddWalkInEditing;
      expect(state.formState.customerName, '');
      expect(state.formState.partySize, 1);
    });

    test('Field change events update editing form state', () async {
      bloc.add(const InitializeAddWalkIn());
      await bloc.stream.firstWhere((s) => s is AddWalkInEditing);

      bloc.add(const CustomerNameChanged('Alexander'));
      await bloc.stream.firstWhere((s) => s is AddWalkInEditing && s.formState.customerName == 'Alexander');

      final state = bloc.state as AddWalkInEditing;
      expect(state.formState.customerName, 'Alexander');
    });

    test('SubmitWalkIn emits ValidationError on empty inputs', () async {
      bloc.add(const InitializeAddWalkIn());
      await bloc.stream.firstWhere((s) => s is AddWalkInEditing);

      bloc.add(const SubmitWalkIn());
      await bloc.stream.firstWhere((s) => s is AddWalkInValidationError);

      final state = bloc.state as AddWalkInValidationError;
      expect(state.formState.validationErrors.containsKey('customerName'), true);
    });

    test('SubmitWalkIn emits Success on valid inputs', () async {
      bloc.add(const InitializeAddWalkIn());
      await bloc.stream.firstWhere((s) => s is AddWalkInEditing);

      bloc.add(const CustomerNameChanged('Alexander Pierce'));
      bloc.add(const PhoneChanged('555-123-4567'));
      bloc.add(const SubmitWalkIn());

      await bloc.stream.firstWhere((s) => s is AddWalkInSuccess);
      expect(bloc.state, isA<AddWalkInSuccess>());
    });
  });

  group('AddWalkInCustomerPage Widget Tests', () {
    testWidgets('renders all form section cards successfully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AddWalkInCustomerPage(summary: testSummary),
        ),
      );

      await tester.pumpAndSettle();

      // Verify layout structures
      expect(find.text('Add Walk-in Customer'), findsOneWidget);
      expect(find.text('Walk-in Registration'), findsOneWidget);
      expect(find.text('Customer Information'), findsOneWidget);
      expect(find.text('Visit Information'), findsOneWidget);
      expect(find.text("Today's Queue Summary"), findsOneWidget);

      // Verify button layout
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Add to Queue'), findsOneWidget);
    });

    testWidgets('entering name and submitting with empty phone triggers validation indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AddWalkInCustomerPage(summary: testSummary),
        ),
      );

      await tester.pumpAndSettle();

      // Enter name
      await tester.enterText(find.byType(TextField).first, 'John');
      await tester.pumpAndSettle();

      // Click Add to Queue
      await tester.tap(find.text('Add to Queue'));
      await tester.pump(); // wait for validation call

      // Mobile number is required error
      expect(find.text('Mobile number is required'), findsOneWidget);
    });
  });
}
