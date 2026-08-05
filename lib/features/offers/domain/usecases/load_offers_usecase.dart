import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

class LoadOffersUseCase {
  final OfferRepository repository;

  LoadOffersUseCase(this.repository);

  Future<List<OfferEntity>> call() async {
    return await repository.loadOffers();
  }
}
