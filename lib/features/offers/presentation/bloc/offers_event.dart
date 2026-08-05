import 'package:equatable/equatable.dart';

abstract class OffersEvent extends Equatable {
  const OffersEvent();

  @override
  List<Object?> get props => [];
}

class LoadOffers extends OffersEvent {
  const LoadOffers();
}

class RefreshOffers extends OffersEvent {
  const RefreshOffers();
}

class SearchOffers extends OffersEvent {
  final String query;

  const SearchOffers(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterOffers extends OffersEvent {
  final String status;

  const FilterOffers(this.status);

  @override
  List<Object?> get props => [status];
}

class LoadOfferDetails extends OffersEvent {
  final String offerId;

  const LoadOfferDetails(this.offerId);

  @override
  List<Object?> get props => [offerId];
}

class DeleteOfferRequested extends OffersEvent {
  final String offerId;

  const DeleteOfferRequested(this.offerId);

  @override
  List<Object?> get props => [offerId];
}

class UpdateOfferStatusRequested extends OffersEvent {
  final String offerId;
  final String status;

  const UpdateOfferStatusRequested(this.offerId, this.status);

  @override
  List<Object?> get props => [offerId, status];
}

class ClearFilters extends OffersEvent {
  const ClearFilters();
}


