import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_companion_staff/features/queue/data/repositories/mock_queue_repository.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_filter.dart';
import 'package:mall_companion_staff/features/queue/domain/entities/queue_sort_option.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/search_queue_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/filter_queue_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/sort_queue_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/load_queue_dashboard_usecase.dart';
import 'package:mall_companion_staff/features/queue/domain/usecases/get_queue_details_usecase.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_bloc.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_event.dart';
import 'package:mall_companion_staff/features/queue/presentation/bloc/queue_state.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/queue_search_bar.dart';
import 'package:mall_companion_staff/features/queue/presentation/widgets/queue_sort_sheet.dart';

void main() {
  late MockQueueRepository repository;
  late SearchQueueUseCase searchUseCase;
  late FilterQueueUseCase filterUseCase;
  late SortQueueUseCase sortUseCase;
  late LoadQueueDashboardUseCase loadUseCase;
  late GetQueueDetailsUseCase getDetailsUseCase;
  late QueueBloc bloc;

  setUp(() {
    repository = MockQueueRepository(populateAll: true);
    searchUseCase = SearchQueueUseCase(repository);
    filterUseCase = FilterQueueUseCase(repository);
    sortUseCase = SortQueueUseCase(repository);
    loadUseCase = LoadQueueDashboardUseCase(repository);
    getDetailsUseCase = GetQueueDetailsUseCase(repository);
    bloc = QueueBloc(
      loadQueueDashboardUseCase: loadUseCase,
      getQueueDetailsUseCase: getDetailsUseCase,
      searchQueueUseCase: searchUseCase,
      filterQueueUseCase: filterUseCase,
      sortQueueUseCase: sortUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('Queue Search & Filter UseCase Tests', () {
    test('SearchQueueUseCase filters by name, token, phone, and id', () async {
      final allQueue = await repository.getCurrentQueue();

      // Search by Name
      final searchResultName = await searchUseCase('James', localList: allQueue);
      expect(searchResultName.length, 1);
      expect(searchResultName.first.customerName, 'James Wilson');

      // Search by Token
      final searchResultToken = await searchUseCase('A015', localList: allQueue);
      expect(searchResultToken.length, 1);
      expect(searchResultToken.first.customerName, 'Sarah Mitchell');

      // Search by Phone
      final searchResultPhone = await searchUseCase('555-0123', localList: allQueue);
      expect(searchResultPhone.length, 1);
      expect(searchResultPhone.first.customerName, 'James Wilson');
    });

    test('FilterQueueUseCase filters by status and timeline event skipped', () async {
      final allQueue = await repository.getCurrentQueue();

      // Filter by Waiting
      final waitingFiltered = await filterUseCase(QueueFilter.waiting, localList: allQueue);
      // waiting status items include James Wilson, Sarah Mitchell, and Linda Johnson (skipped is waiting status)
      expect(waitingFiltered.length, 3);

      // Filter by Called
      final calledFiltered = await filterUseCase(QueueFilter.called, localList: allQueue);
      expect(calledFiltered.length, 1);
      expect(calledFiltered.first.customerName, 'David Lee');

      // Filter by Skipped
      final skippedFiltered = await filterUseCase(QueueFilter.skipped, localList: allQueue);
      expect(skippedFiltered.length, 1);
      expect(skippedFiltered.first.customerName, 'Linda Johnson');
    });

    test('SortQueueUseCase sorts by check-in time, priority, and party size', () async {
      final allQueue = await repository.getCurrentQueue();

      // Sort by Oldest First
      final oldestSorted = await sortUseCase(QueueSortOption.oldestFirst, localList: allQueue);
      // q6 checked in 60 mins ago (oldest)
      expect(oldestSorted.first.id, 'q6');

      // Sort by Newest First
      final newestSorted = await sortUseCase(QueueSortOption.newestFirst, localList: allQueue);
      // q2 checked in 8 mins ago (newest)
      expect(newestSorted.first.id, 'q2');

      // Sort by Highest Priority
      final prioritySorted = await sortUseCase(QueueSortOption.highestPriority, localList: allQueue);
      // VIPs first
      expect(prioritySorted[0].priority, 'VIP');
      expect(prioritySorted[1].priority, 'VIP');

      // Sort by Largest Party Size
      final partySorted = await sortUseCase(QueueSortOption.largestPartySize, localList: allQueue);
      // q7 has party size 5
      expect(partySorted.first.partySize, 5);
    });
  });

  group('Queue Repository Contracts Tests', () {
    test('MockQueueRepository implements repository operations directly', () async {
      final searchResult = await repository.searchQueue('James');
      expect(searchResult.length, 1);

      final filterResult = await repository.filterQueue(QueueFilter.called);
      expect(filterResult.length, 1);

      final sortResult = await repository.sortQueue(QueueSortOption.largestPartySize);
      expect(sortResult.first.partySize, 5);
    });
  });

  group('Queue Search & Filter BLoC Tests', () {
    test('SearchQueryChanged event filters list in BLoC', () async {
      bloc.add(const LoadQueueDashboard());
      await bloc.stream.firstWhere((s) => s is QueueLoaded);

      bloc.add(const SearchQueryChanged('James'));
      await bloc.stream.firstWhere((s) => s is QueueLoaded && s.searchQuery == 'James');

      final state = bloc.state as QueueLoaded;
      expect(state.queue.length, 1);
      expect(state.queue.first.customerName, 'James Wilson');
    });

    test('FilterChanged event filters list in BLoC', () async {
      bloc.add(const LoadQueueDashboard());
      await bloc.stream.firstWhere((s) => s is QueueLoaded);

      bloc.add(const FilterChanged(QueueFilter.called));
      await bloc.stream.firstWhere((s) => s is QueueLoaded && s.selectedFilter == QueueFilter.called);

      final state = bloc.state as QueueLoaded;
      expect(state.queue.length, 1);
      expect(state.queue.first.customerName, 'David Lee');
    });

    test('SortChanged event sorts list in BLoC', () async {
      bloc.add(const LoadQueueDashboard());
      await bloc.stream.firstWhere((s) => s is QueueLoaded);

      bloc.add(const SortChanged(QueueSortOption.largestPartySize));
      await bloc.stream.firstWhere((s) => s is QueueLoaded && s.selectedSort == QueueSortOption.largestPartySize);

      final state = bloc.state as QueueLoaded;
      expect(state.queue.first.partySize, 5);
    });

    test('ClearFilters event resets BLoC search/filter state', () async {
      bloc.add(const LoadQueueDashboard());
      await bloc.stream.firstWhere((s) => s is QueueLoaded);

      bloc.add(const SearchQueryChanged('James'));
      await bloc.stream.firstWhere((s) => s is QueueLoaded && s.searchQuery == 'James');

      bloc.add(const ClearFilters());
      await bloc.stream.firstWhere((s) => s is QueueLoaded && s.searchQuery.isEmpty);

      final state = bloc.state as QueueLoaded;
      expect(state.selectedFilter, QueueFilter.all);
      expect(state.selectedSort, QueueSortOption.oldestFirst);
      expect(state.searchQuery, '');
    });
  });

  group('Queue Search & Sort Widgets Tests', () {
    testWidgets('QueueSearchBar renders text field and filter chips', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: bloc,
              child: const QueueSearchBar(
                activeFilter: QueueFilter.all,
                searchQuery: '',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search customer, token or phone...'), findsOneWidget);
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Waiting'), findsOneWidget);
      expect(find.text('Called'), findsOneWidget);
    });

    testWidgets('QueueSortSheet renders all sort options', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QueueSortSheet(
              activeSort: QueueSortOption.oldestFirst,
            ),
          ),
        ),
      );

      expect(find.text('Sort Queue By'), findsOneWidget);
      expect(find.text('Oldest First'), findsOneWidget);
      expect(find.text('Newest First'), findsOneWidget);
      expect(find.text('Longest Waiting'), findsOneWidget);
      expect(find.text('Shortest Waiting'), findsOneWidget);
      expect(find.text('Highest Priority'), findsOneWidget);
      expect(find.text('Largest Party Size'), findsOneWidget);
    });
  });
}
