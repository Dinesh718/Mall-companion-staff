import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

class FilterOffersUseCase {
  final OfferRepository repository;

  FilterOffersUseCase(this.repository);

  Future<List<OfferEntity>> call(String status) async {
    return await repository.filterOffers(status);
  }
}
