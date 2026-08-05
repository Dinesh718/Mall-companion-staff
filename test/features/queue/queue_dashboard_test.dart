import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/queue/data/repositories/mock_queue_repository.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_status.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_timeline_step_entity.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_timeline_step_status.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/load_queue_dashboard_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/get_queue_details_usecase.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_bloc.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_event.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_state.dart';
import 'package:mall_companion_staff/features/queue/presentation/pages/queue_details_page.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/queue_card.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/queue_timeline_widget.dart';

void main() {
  late MockQueueRepository repository;
  late LoadQueueDashboardUseCase loadUseCase;
  late GetQueueDetailsUseCase getDetailsUseCase;
  late QueueBloc bloc;

  setUp(() {
    repository = MockQueueRepository();
    loadUseCase = LoadQueueDashboardUseCase(repository);
    getDetailsUseCase = GetQueueDetailsUseCase(repository);
    bloc = QueueBloc(
      loadQueueDashboardUseCase: loadUseCase,
      getQueueDetailsUseCase: getDetailsUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('MockQueueRepository Tests', () {
    test('getCurrentQueue returns realistic mock data', () async {
      final queue = await repository.getCurrentQueue();
      expect(queue.length, 2);
      expect(queue[0].customerName, 'James Wilson');
      expect(queue[0].token, 'A012');
    });

    test('getQueueDetails returns detailed mock data for q1', () async {
      final detail = await repository.getQueueDetails('q1');
      expect(detail.id, 'q1');
      expect(detail.specialNotes, 'Customer requested window seating. Birthday celebration.');
      expect(detail.position, 4);
      expect(detail.serviceType, 'Walk-in');
      expect(detail.timelineSteps?.length, 5);
      expect(detail.timelineSteps?[0].title, 'Checked In');
    });
  });

  group('GetQueueDetailsUseCase Tests', () {
    test('GetQueueDetailsUseCase fetches details successfully', () async {
      final detail = await getDetailsUseCase('q1');
      expect(detail.id, 'q1');
      expect(detail.customerName, 'James Wilson');
    });
  });

  group('QueueBloc Tests', () {
    test('initial state is QueueInitial', () {
      expect(bloc.state, const QueueInitial());
    });

    test('LoadQueueDashboard event triggers Loading -> Loaded states', () async {
      bloc.add(const LoadQueueDashboard());
      await bloc.stream.firstWhere((s) => s is QueueLoaded);

      final loaded = bloc.state as QueueLoaded;
      expect(loaded.queue.length, 2);
      expect(loaded.summary.waitingCount, 32);
    });

    test('LoadQueueDetails event triggers DetailsLoading -> DetailsLoaded states', () async {
      bloc.add(const LoadQueueDetails('q1'));
      await bloc.stream.firstWhere((s) => s is QueueDetailsLoaded);

      final loaded = bloc.state as QueueDetailsLoaded;
      expect(loaded.queueItem.customerName, 'James Wilson');
    });

    test('Session management actions trigger refresh details state', () async {
      bloc.add(const CallCustomer('q1'));
      await bloc.stream.firstWhere((s) => s is QueueDetailsLoaded);

      expect(bloc.state, isA<QueueDetailsLoaded>());
    });
  });

  group('Queue Widgets & Page Tests', () {
    testWidgets('QueueCard renders customer information correctly', (WidgetTester tester) async {
      final item = QueueEntity(
        id: 'q1',
        token: 'A012',
        customerName: 'James Wilson',
        phoneNumber: '555-0123',
        avatarUrl: '',
        partySize: 2,
        estimatedWaitMinutes: 15,
        checkInTime: DateTime.now().subtract(const Duration(minutes: 15)),
        status: QueueStatus.waiting,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QueueCard(
              queue: item,
              onViewDetails: () {},
              onCallCustomer: () {},
            ),
          ),
        ),
      );

      expect(find.text('A012'), findsOneWidget);
      expect(find.text('James Wilson'), findsOneWidget);
      expect(find.text('2 people'), findsOneWidget);
      expect(find.text('555-0123'), findsOneWidget);
    });

    testWidgets('QueueTimelineWidget renders steps dynamically', (WidgetTester tester) async {
      final steps = [
        QueueTimelineStepEntity(
          title: 'Checked In',
          subtitle: '10:15 AM • Front Desk',
          timestamp: DateTime.now(),
          status: QueueTimelineStepStatus.completed,
        ),
        QueueTimelineStepEntity(
          title: 'Waiting',
          subtitle: 'Est. Call at 10:30 AM',
          timestamp: DateTime.now(),
          status: QueueTimelineStepStatus.current,
        ),
        QueueTimelineStepEntity(
          title: 'Called',
          subtitle: 'Next Step',
          timestamp: DateTime.now(),
          status: QueueTimelineStepStatus.future,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QueueTimelineWidget(steps: steps),
          ),
        ),
      );

      expect(find.text('Checked In'), findsOneWidget);
      expect(find.text('10:15 AM • Front Desk'), findsOneWidget);
      expect(find.text('Waiting'), findsOneWidget);
      expect(find.text('Est. Call at 10:30 AM'), findsOneWidget);
      expect(find.text('Called'), findsOneWidget);
      expect(find.text('Next Step'), findsOneWidget);
    });

    testWidgets('QueueDetailsPage renders detailed information and sections', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: QueueDetailsPage(queueId: 'q1', repository: repository),
        ),
      );

      // Wait for repository fetch
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Queue Details'), findsOneWidget);
      expect(find.text('James Wilson'), findsNWidgets(2));
      expect(find.text('TOKEN ID'), findsOneWidget);
      expect(find.text('Special Notes'), findsOneWidget);
      expect(find.text('Customer Information'), findsOneWidget);
      expect(find.text('Queue Information'), findsOneWidget);
      expect(find.text('Manage Session'), findsOneWidget);
      expect(find.text('Queue Timeline'), findsOneWidget);

      // Verify actions buttons
      expect(find.text('Call Customer'), findsAtLeastNWidgets(2)); // Card action + Bottom action
      expect(find.text('Mark Arrived'), findsOneWidget);
      expect(find.text('Complete Service'), findsNothing);
      expect(find.text('Skip Customer'), findsOneWidget);
      expect(find.text('Cancel Queue'), findsOneWidget);
      expect(find.text('Back to Queue'), findsOneWidget);
    });
  });
}
