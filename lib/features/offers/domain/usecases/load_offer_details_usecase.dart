import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

class LoadOfferDetailsUseCase {
  final OfferRepository repository;

  LoadOfferDetailsUseCase(this.repository);

  Future<OfferEntity> call(String offerId) async {
    return await repository.getOfferDetails(offerId);
  }
}
