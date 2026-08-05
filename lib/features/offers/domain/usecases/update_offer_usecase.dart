import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

class UpdateOfferUseCase {
  final OfferRepository repository;

  UpdateOfferUseCase(this.repository);

  Future<OfferEntity> call(OfferEntity offer) async {
    return await repository.updateOffer(offer);
  }
}
