import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

class SearchOffersUseCase {
  final OfferRepository repository;

  SearchOffersUseCase(this.repository);

  Future<List<OfferEntity>> call(String query) async {
    return await repository.searchOffers(query);
  }
}
