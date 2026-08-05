import '../entities/offer_entity.dart';
import '../entities/offer_status.dart';
import '../repositories/offer_repository.dart';

class SearchAndFilterOffersUseCase {
  final OfferRepository repository;

  SearchAndFilterOffersUseCase(this.repository);

  Future<List<OfferEntity>> call(String query, OfferStatus status) async {
    return await repository.searchAndFilterOffers(query, status);
  }
}
