import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/load_offers_usecase.dart';
import '../../domain/usecases/search_offers_usecase.dart';
import '../../domain/usecases/filter_offers_usecase.dart';
import '../../domain/usecases/load_offer_details_usecase.dart';
import '../../domain/usecases/delete_offer_usecase.dart';
import '../../domain/usecases/update_offer_status_usecase.dart';
import '../../domain/usecases/search_and_filter_offers_usecase.dart';
import '../../domain/entities/offer_status.dart';
import '../../domain/entities/offer_entity.dart';
import 'offers_event.dart';
import 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final LoadOffersUseCase loadOffersUseCase;
  final SearchOffersUseCase searchOffersUseCase;
  final FilterOffersUseCase filterOffersUseCase;
  final LoadOfferDetailsUseCase loadOfferDetailsUseCase;
  final DeleteOfferUseCase? deleteOfferUseCase;
  final UpdateOfferStatusUseCase? updateOfferStatusUseCase;
  final SearchAndFilterOffersUseCase? searchAndFilterOffersUseCase;

  OffersBloc({
    required this.loadOffersUseCase,
    required this.searchOffersUseCase,
    required this.filterOffersUseCase,
    required this.loadOfferDetailsUseCase,
    this.deleteOfferUseCase,
    this.updateOfferStatusUseCase,
    this.searchAndFilterOffersUseCase,
  }) : super(const OffersInitial()) {
    on<LoadOffers>(_onLoadOffers);
    on<RefreshOffers>(_onRefreshOffers);
    on<SearchOffers>(_onSearchOffers);
    on<FilterOffers>(_onFilterOffers);
    on<LoadOfferDetails>(_onLoadOfferDetails);
    on<DeleteOfferRequested>(_onDeleteOfferRequested);
    on<UpdateOfferStatusRequested>(_onUpdateOfferStatusRequested);
    on<ClearFilters>(_onClearFilters);
  }

  Future<void> _onLoadOffers(LoadOffers event, Emitter<OffersState> emit) async {
    emit(const OffersLoading());
    try {
      final all = await loadOffersUseCase();
      if (all.isEmpty) {
        emit(const OffersEmpty());
      } else {
        emit(OffersLoaded(offers: all, allOffers: all));
      }
    } catch (e) {
      emit(OffersError(e.toString()));
    }
  }

  Future<void> _onRefreshOffers(RefreshOffers event, Emitter<OffersState> emit) async {
    try {
      final all = await loadOffersUseCase();
      if (all.isEmpty) {
        emit(const OffersEmpty());
      } else {
        emit(OffersLoaded(offers: all, allOffers: all));
      }
    } catch (e) {
      emit(OffersError(e.toString()));
    }
  }

  Future<void> _onSearchOffers(SearchOffers event, Emitter<OffersState> emit) async {
    final currentState = state;
    if (currentState is OffersLoaded) {
      try {
        final query = event.query;
        final List<OfferEntity> filteredList;
        if (searchAndFilterOffersUseCase != null) {
          filteredList = await searchAndFilterOffersUseCase!(query, currentState.activeFilter);
        } else {
          filteredList = await searchOffersUseCase(query);
        }
        emit(currentState.copyWith(
          offers: filteredList,
          searchQuery: query,
        ));
      } catch (e) {
        emit(OffersError(e.toString()));
      }
    }
  }

  Future<void> _onFilterOffers(FilterOffers event, Emitter<OffersState> emit) async {
    final currentState = state;
    if (currentState is OffersLoaded) {
      try {
        final filterEnum = OfferStatus.fromString(event.status);
        final List<OfferEntity> filteredList;
        if (searchAndFilterOffersUseCase != null) {
          filteredList = await searchAndFilterOffersUseCase!(currentState.searchQuery, filterEnum);
        } else {
          filteredList = await filterOffersUseCase(event.status);
        }
        emit(currentState.copyWith(
          offers: filteredList,
          activeFilter: filterEnum,
        ));
      } catch (e) {
        emit(OffersError(e.toString()));
      }
    }
  }

  Future<void> _onLoadOfferDetails(LoadOfferDetails event, Emitter<OffersState> emit) async {
    emit(const OfferDetailsLoading());
    try {
      final details = await loadOfferDetailsUseCase(event.offerId);
      emit(OfferDetailsLoaded(details));
    } catch (e) {
      emit(OfferDetailsError(e.toString()));
    }
  }

  Future<void> _onDeleteOfferRequested(DeleteOfferRequested event, Emitter<OffersState> emit) async {
    emit(const OffersDeleting());
    try {
      if (deleteOfferUseCase != null) {
        await deleteOfferUseCase!(event.offerId);
      } else {
        await Future.delayed(const Duration(milliseconds: 500));
      }
      emit(const OffersDeleteSuccess());
    } catch (e) {
      emit(OffersDeleteFailure(e.toString()));
    }
  }

  Future<void> _onUpdateOfferStatusRequested(UpdateOfferStatusRequested event, Emitter<OffersState> emit) async {
    emit(const OffersStatusUpdateInProgress());
    try {
      if (updateOfferStatusUseCase != null) {
        final updated = await updateOfferStatusUseCase!(event.offerId, event.status);
        emit(OfferDetailsLoaded(updated));
      } else {
        await Future.delayed(const Duration(milliseconds: 500));
        final details = await loadOfferDetailsUseCase(event.offerId);
        emit(OfferDetailsLoaded(details));
      }
    } catch (e) {
      emit(OffersStatusUpdateFailure(e.toString()));
    }
  }

  Future<void> _onClearFilters(ClearFilters event, Emitter<OffersState> emit) async {
    final currentState = state;
    if (currentState is OffersLoaded) {
      final all = currentState.allOffers;
      emit(OffersLoaded(
        offers: all,
        allOffers: all,
        activeFilter: OfferStatus.all,
        searchQuery: '',
      ));
    }
  }
}
