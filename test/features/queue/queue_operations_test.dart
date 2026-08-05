import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/queue/data/repositories/mock_queue_repository.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_status.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/call_customer_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/mark_arrived_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/start_service_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/complete_service_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/skip_customer_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/cancel_queue_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/load_queue_dashboard_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/get_queue_details_usecase.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_bloc.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_event.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_state.dart';
import 'package:mall_companion_staff/features/queue/presentation/pages/queue_details_page.dart';

void main() {
  late MockQueueRepository repository;
  late CallCustomerUseCase callUseCase;
  late MarkArrivedUseCase arriveUseCase;
  late StartServiceUseCase startUseCase;
  late CompleteServiceUseCase completeUseCase;
  late SkipCustomerUseCase skipUseCase;
  late CancelQueueUseCase cancelUseCase;
  late QueueBloc bloc;

  setUp(() {
    repository = MockQueueRepository();
    callUseCase = CallCustomerUseCase(repository);
    arriveUseCase = MarkArrivedUseCase(repository);
    startUseCase = StartServiceUseCase(repository);
    completeUseCase = CompleteServiceUseCase(repository);
    skipUseCase = SkipCustomerUseCase(repository);
    cancelUseCase = CancelQueueUseCase(repository);

    bloc = QueueBloc(
      loadQueueDashboardUseCase: LoadQueueDashboardUseCase(repository),
      getQueueDetailsUseCase: GetQueueDetailsUseCase(repository),
      callCustomerUseCase: callUseCase,
      markArrivedUseCase: arriveUseCase,
      startServiceUseCase: startUseCase,
      completeServiceUseCase: completeUseCase,
      skipCustomerUseCase: skipUseCase,
      cancelQueueUseCase: cancelUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('Queue Operations UseCases & Repository Tests', () {
    test('calling customer updates status to called and appends timeline step', () async {
      final updated = await callUseCase('q1');
      expect(updated.status, QueueStatus.called);
      expect(updated.timelineSteps?.last.title, 'Customer Called');
    });

    test('marking arrived updates status to arrived and appends timeline step', () async {
      final updated = await arriveUseCase('q1');
      expect(updated.status, QueueStatus.arrived);
      expect(updated.timelineSteps?.last.title, 'Customer Arrived');
    });

    test('starting service updates status to serving and appends timeline step', () async {
      final updated = await startUseCase('q1');
      expect(updated.status, QueueStatus.serving);
      expect(updated.timelineSteps?.last.title, 'Service Started');
    });

    test('completing service updates status to completed and appends timeline step', () async {
      final updated = await completeUseCase('q1');
      expect(updated.status, QueueStatus.completed);
      expect(updated.timelineSteps?.last.title, 'Service Completed');
    });

    test('skipping customer updates status to waiting and appends timeline step', () async {
      final updated = await skipUseCase('q1');
      expect(updated.status, QueueStatus.waiting);
      expect(updated.timelineSteps?.last.title, 'Customer Skipped');
    });

    test('cancelling queue updates status to cancelled and appends timeline step', () async {
      final updated = await cancelUseCase('q1');
      expect(updated.status, QueueStatus.cancelled);
      expect(updated.timelineSteps?.last.title, 'Queue Cancelled');
    });
  });

  group('Queue Operations BLoC Flow Tests', () {
    test('dispatching CallCustomerRequested triggers status transition', () async {
      bloc.add(const LoadQueueDetails('q1'));
      await bloc.stream.firstWhere((s) => s is QueueDetailsLoaded);

      bloc.add(const CallCustomerRequested('q1'));
      await bloc.stream.firstWhere((s) => s is QueueDetailsLoaded && s.activeAction == 'call');
      await bloc.stream.firstWhere((s) => s is QueueDetailsLoaded && s.activeAction == null);

      final state = bloc.state as QueueDetailsLoaded;
      expect(state.queueItem.status, QueueStatus.called);
    });
  });

  group('QueueDetailsPage Dynamic Buttons Widget Tests', () {
    testWidgets('renders Call Customer, Mark Arrived, Skip, Cancel when status is waiting', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: QueueDetailsPage(queueId: 'q1', repository: repository),
        ),
      );

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Call Customer'), findsNWidgets(2)); // Bottom bar + card
      expect(find.text('Mark Arrived'), findsOneWidget);
      expect(find.text('Skip Customer'), findsOneWidget);
      expect(find.text('Cancel Queue'), findsOneWidget);
    });

    testWidgets('renders Completed Successfully card when status is completed', (WidgetTester tester) async {
      // Start completion and tick the fake clock to let mock delayed complete
      repository.completeService('q1');
      await tester.pump(const Duration(milliseconds: 200));

      await tester.pumpWidget(
        MaterialApp(
          home: QueueDetailsPage(queueId: 'q1', repository: repository),
        ),
      );

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Completed Successfully'), findsOneWidget);
      expect(find.text('Mark Arrived'), findsNothing);
      expect(find.text('Skip Customer'), findsNothing);
      expect(find.text('Cancel Queue'), findsNothing);
    });
  });
}
