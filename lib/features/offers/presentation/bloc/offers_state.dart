import 'package:equatable/equatable.dart';
import '../../domain/entities/offer_entity.dart';
import '../../domain/entities/offer_status.dart';

abstract class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object?> get props => [];
}

class OffersInitial extends OffersState {
  const OffersInitial();
}

class OffersLoading extends OffersState {
  const OffersLoading();
}

class OffersLoaded extends OffersState {
  final List<OfferEntity> offers;
  final List<OfferEntity> allOffers; // keep track of all offers for stats overview calculations
  final OfferStatus activeFilter;
  final String searchQuery;

  const OffersLoaded({
    required this.offers,
    required this.allOffers,
    this.activeFilter = OfferStatus.all,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [offers, allOffers, activeFilter, searchQuery];

  OffersLoaded copyWith({
    List<OfferEntity>? offers,
    List<OfferEntity>? allOffers,
    OfferStatus? activeFilter,
    String? searchQuery,
  }) {
    return OffersLoaded(
      offers: offers ?? this.offers,
      allOffers: allOffers ?? this.allOffers,
      activeFilter: activeFilter ?? this.activeFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class OffersEmpty extends OffersState {
  final String message;

  const OffersEmpty({this.message = 'No offers found'});

  @override
  List<Object?> get props => [message];
}

class OffersError extends OffersState {
  final String errorMessage;

  const OffersError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// Offer Details States
class OfferDetailsLoading extends OffersState {
  const OfferDetailsLoading();
}

class OfferDetailsLoaded extends OffersState {
  final OfferEntity offer;

  const OfferDetailsLoaded(this.offer);

  @override
  List<Object?> get props => [offer];
}

class OfferDetailsError extends OffersState {
  final String errorMessage;

  const OfferDetailsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// Phase 3.5 Delete Offer
class OffersDeleting extends OffersState {
  const OffersDeleting();
}

class OffersDeleteSuccess extends OffersState {
  const OffersDeleteSuccess();
}

class OffersDeleteFailure extends OffersState {
  final String errorMessage;

  const OffersDeleteFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// Phase 3.6 Enable/Disable Campaign
class OffersStatusUpdateInProgress extends OffersState {
  const OffersStatusUpdateInProgress();
}

class OffersStatusUpdateFailure extends OffersState {
  final String errorMessage;

  const OffersStatusUpdateFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}


