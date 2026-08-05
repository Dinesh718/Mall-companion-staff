import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/mock_queue_repository.dart';
import '../../domain/usecases/load_queue_dashboard_usecase.dart';
import '../../domain/usecases/get_queue_details_usecase.dart';
import '../../domain/usecases/call_customer_usecase.dart';
import '../../domain/usecases/mark_arrived_usecase.dart';
import '../../domain/usecases/start_service_usecase.dart';
import '../../domain/usecases/complete_service_usecase.dart';
import '../../domain/usecases/skip_customer_usecase.dart';
import '../../domain/usecases/cancel_queue_usecase.dart';
import '../../domain/entities/queue_entity.dart';
import '../../domain/entities/queue_filter.dart';
import '../../domain/entities/queue_sort_option.dart';
import '../../domain/usecases/search_queue_usecase.dart';
import '../../domain/usecases/filter_queue_usecase.dart';
import '../../domain/usecases/sort_queue_usecase.dart';
import 'queue_event.dart';
import 'queue_state.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  final LoadQueueDashboardUseCase loadQueueDashboardUseCase;
  final GetQueueDetailsUseCase getQueueDetailsUseCase;
  final CallCustomerUseCase? callCustomerUseCase;
  final MarkArrivedUseCase? markArrivedUseCase;
  final StartServiceUseCase? startServiceUseCase;
  final CompleteServiceUseCase? completeServiceUseCase;
  final SkipCustomerUseCase? skipCustomerUseCase;
  final CancelQueueUseCase? cancelQueueUseCase;
  final SearchQueueUseCase? searchQueueUseCase;
  final FilterQueueUseCase? filterQueueUseCase;
  final SortQueueUseCase? sortQueueUseCase;

  QueueBloc({
    required this.loadQueueDashboardUseCase,
    required this.getQueueDetailsUseCase,
    this.callCustomerUseCase,
    this.markArrivedUseCase,
    this.startServiceUseCase,
    this.completeServiceUseCase,
    this.skipCustomerUseCase,
    this.cancelQueueUseCase,
    this.searchQueueUseCase,
    this.filterQueueUseCase,
    this.sortQueueUseCase,
  }) : super(const QueueInitial()) {
    on<LoadQueueDashboard>(_onLoadQueueDashboard);
    on<RefreshQueueDashboard>(_onRefreshQueueDashboard);
    on<LoadQueueDetails>(_onLoadQueueDetails);
    on<RefreshQueueDetails>(_onRefreshQueueDetails);
    
    // Operations events
    on<CallCustomerRequested>(_onCallCustomerRequested);
    on<MarkArrivedRequested>(_onMarkArrivedRequested);
    on<StartServiceRequested>(_onStartServiceRequested);
    on<CompleteServiceRequested>(_onCompleteServiceRequested);
    on<SkipCustomerRequested>(_onSkipCustomerRequested);
    on<CancelQueueRequested>(_onCancelQueueRequested);

    // Search and Filter events
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<FilterChanged>(_onFilterChanged);
    on<SortChanged>(_onSortChanged);
    on<ClearFilters>(_onClearFilters);

    // Legacy events compatibility mapping
    on<CallCustomer>((event, emit) => add(CallCustomerRequested(event.queueId)));
    on<MarkArrived>((event, emit) => add(MarkArrivedRequested(event.queueId)));
    on<CompleteService>((event, emit) => add(CompleteServiceRequested(event.queueId)));
    on<SkipCustomer>((event, emit) => add(SkipCustomerRequested(event.queueId)));
    on<CancelQueue>((event, emit) => add(CancelQueueRequested(event.queueId)));
  }

  Future<void> _onLoadQueueDashboard(
    LoadQueueDashboard event,
    Emitter<QueueState> emit,
  ) async {
    emit(const QueueLoading());
    try {
      final (queue, summary) = await loadQueueDashboardUseCase();
      final sortUseCase = sortQueueUseCase ?? SortQueueUseCase(MockQueueRepository());
      final sortedQueue = await sortUseCase(QueueSortOption.oldestFirst, localList: queue);
      emit(QueueLoaded(queue: sortedQueue, allQueue: queue, summary: summary));
    } catch (e) {
      emit(QueueError(e.toString()));
    }
  }

  Future<void> _onRefreshQueueDashboard(
    RefreshQueueDashboard event,
    Emitter<QueueState> emit,
  ) async {
    try {
      final (queue, summary) = await loadQueueDashboardUseCase();
      final sortUseCase = sortQueueUseCase ?? SortQueueUseCase(MockQueueRepository());
      final searchUseCase = searchQueueUseCase ?? SearchQueueUseCase(MockQueueRepository());
      final filterUseCase = filterQueueUseCase ?? FilterQueueUseCase(MockQueueRepository());
      
      final current = state;
      if (current is QueueLoaded) {
        var filtered = List<QueueEntity>.from(queue);
        filtered = await filterUseCase(current.selectedFilter, localList: filtered);
        filtered = await searchUseCase(current.searchQuery, localList: filtered);
        filtered = await sortUseCase(current.selectedSort, localList: filtered);
        emit(QueueLoaded(
          queue: filtered,
          allQueue: queue,
          summary: summary,
          searchQuery: current.searchQuery,
          selectedFilter: current.selectedFilter,
          selectedSort: current.selectedSort,
        ));
      } else {
        final sortedQueue = await sortUseCase(QueueSortOption.oldestFirst, localList: queue);
        emit(QueueLoaded(queue: sortedQueue, allQueue: queue, summary: summary));
      }
    } catch (e) {
      emit(QueueError(e.toString()));
    }
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<QueueState> emit,
  ) async {
    final s = state;
    if (s is QueueLoaded) {
      final query = event.query;
      final searchUseCase = searchQueueUseCase ?? SearchQueueUseCase(MockQueueRepository());
      final filterUseCase = filterQueueUseCase ?? FilterQueueUseCase(MockQueueRepository());
      final sortUseCase = sortQueueUseCase ?? SortQueueUseCase(MockQueueRepository());

      var filtered = List<QueueEntity>.from(s.allQueue);
      filtered = await filterUseCase(s.selectedFilter, localList: filtered);
      filtered = await searchUseCase(query, localList: filtered);
      filtered = await sortUseCase(s.selectedSort, localList: filtered);

      emit(s.copyWith(
        queue: filtered,
        searchQuery: query,
      ));
    }
  }

  Future<void> _onFilterChanged(
    FilterChanged event,
    Emitter<QueueState> emit,
  ) async {
    final s = state;
    if (s is QueueLoaded) {
      final filter = event.filter;
      final searchUseCase = searchQueueUseCase ?? SearchQueueUseCase(MockQueueRepository());
      final filterUseCase = filterQueueUseCase ?? FilterQueueUseCase(MockQueueRepository());
      final sortUseCase = sortQueueUseCase ?? SortQueueUseCase(MockQueueRepository());

      var filtered = List<QueueEntity>.from(s.allQueue);
      filtered = await filterUseCase(filter, localList: filtered);
      filtered = await searchUseCase(s.searchQuery, localList: filtered);
      filtered = await sortUseCase(s.selectedSort, localList: filtered);

      emit(s.copyWith(
        queue: filtered,
        selectedFilter: filter,
      ));
    }
  }

  Future<void> _onSortChanged(
    SortChanged event,
    Emitter<QueueState> emit,
  ) async {
    final s = state;
    if (s is QueueLoaded) {
      final sort = event.sortOption;
      final searchUseCase = searchQueueUseCase ?? SearchQueueUseCase(MockQueueRepository());
      final filterUseCase = filterQueueUseCase ?? FilterQueueUseCase(MockQueueRepository());
      final sortUseCase = sortQueueUseCase ?? SortQueueUseCase(MockQueueRepository());

      var filtered = List<QueueEntity>.from(s.allQueue);
      filtered = await filterUseCase(s.selectedFilter, localList: filtered);
      filtered = await searchUseCase(s.searchQuery, localList: filtered);
      filtered = await sortUseCase(sort, localList: filtered);

      emit(s.copyWith(
        queue: filtered,
        selectedSort: sort,
      ));
    }
  }

  Future<void> _onClearFilters(
    ClearFilters event,
    Emitter<QueueState> emit,
  ) async {
    final s = state;
    if (s is QueueLoaded) {
      final sortUseCase = sortQueueUseCase ?? SortQueueUseCase(MockQueueRepository());

      var resetList = List<QueueEntity>.from(s.allQueue);
      resetList = await sortUseCase(QueueSortOption.oldestFirst, localList: resetList);

      emit(s.copyWith(
        queue: resetList,
        searchQuery: '',
        selectedFilter: QueueFilter.all,
        selectedSort: QueueSortOption.oldestFirst,
      ));
    }
  }

  Future<void> _onLoadQueueDetails(
    LoadQueueDetails event,
    Emitter<QueueState> emit,
  ) async {
    emit(const QueueDetailsLoading());
    try {
      final queueItem = await getQueueDetailsUseCase(event.queueId);
      emit(QueueDetailsLoaded(queueItem));
    } catch (e) {
      emit(QueueDetailsError(e.toString()));
    }
  }

  Future<void> _onRefreshQueueDetails(
    RefreshQueueDetails event,
    Emitter<QueueState> emit,
  ) async {
    try {
      final queueItem = await getQueueDetailsUseCase(event.queueId);
      emit(QueueDetailsLoaded(queueItem));
    } catch (e) {
      emit(QueueDetailsError(e.toString()));
    }
  }

  Future<void> _onCallCustomerRequested(
    CallCustomerRequested event,
    Emitter<QueueState> emit,
  ) async {
    final s = state;
    if (s is QueueDetailsLoaded) {
      emit(s.copyWith(activeAction: 'call'));
    }
    try {
      final useCase = callCustomerUseCase ?? CallCustomerUseCase(MockQueueRepository());
      final updated = await useCase(event.queueId);
      emit(QueueDetailsLoaded(updated, activeAction: null));
    } catch (e) {
      emit(QueueDetailsError(e.toString()));
    }
  }

  Future<void> _onMarkArrivedRequested(
    MarkArrivedRequested event,
    Emitter<QueueState> emit,
  ) async {
    final s = state;
    if (s is QueueDetailsLoaded) {
      emit(s.copyWith(activeAction: 'arrive'));
    }
    try {
      final useCase = markArrivedUseCase ?? MarkArrivedUseCase(MockQueueRepository());
      final updated = await useCase(event.queueId);
      emit(QueueDetailsLoaded(updated, activeAction: null));
    } catch (e) {
      emit(QueueDetailsError(e.toString()));
    }
  }

  Future<void> _onStartServiceRequested(
    StartServiceRequested event,
    Emitter<QueueState> emit,
  ) async {
    final s = state;
    if (s is QueueDetailsLoaded) {
      emit(s.copyWith(activeAction: 'start'));
    }
    try {
      final useCase = startServiceUseCase ?? StartServiceUseCase(MockQueueRepository());
      final updated = await useCase(event.queueId);
      emit(QueueDetailsLoaded(updated, activeAction: null));
    } catch (e) {
      emit(QueueDetailsError(e.toString()));
    }
  }

  Future<void> _onCompleteServiceRequested(
    CompleteServiceRequested event,
    Emitter<QueueState> emit,
  ) async {
    final s = state;
    if (s is QueueDetailsLoaded) {
      emit(s.copyWith(activeAction: 'complete'));
    }
    try {
      final useCase = completeServiceUseCase ?? CompleteServiceUseCase(MockQueueRepository());
      final updated = await useCase(event.queueId);
      emit(QueueDetailsLoaded(updated, activeAction: null));
    } catch (e) {
      emit(QueueDetailsError(e.toString()));
    }
  }

  Future<void> _onSkipCustomerRequested(
    SkipCustomerRequested event,
    Emitter<QueueState> emit,
  ) async {
    final s = state;
    if (s is QueueDetailsLoaded) {
      emit(s.copyWith(activeAction: 'skip'));
    }
    try {
      final useCase = skipCustomerUseCase ?? SkipCustomerUseCase(MockQueueRepository());
      final updated = await useCase(event.queueId);
      emit(QueueDetailsLoaded(updated, activeAction: null));
    } catch (e) {
      emit(QueueDetailsError(e.toString()));
    }
  }

  Future<void> _onCancelQueueRequested(
    CancelQueueRequested event,
    Emitter<QueueState> emit,
  ) async {
    final s = state;
    if (s is QueueDetailsLoaded) {
      emit(s.copyWith(activeAction: 'cancel'));
    }
    try {
      final useCase = cancelQueueUseCase ?? CancelQueueUseCase(MockQueueRepository());
      final updated = await useCase(event.queueId);
      emit(QueueDetailsLoaded(updated, activeAction: null));
    } catch (e) {
      emit(QueueDetailsError(e.toString()));
    }
  }
}
