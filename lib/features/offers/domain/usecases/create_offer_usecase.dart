import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

class CreateOfferUseCase {
  final OfferRepository repository;

  CreateOfferUseCase(this.repository);

  Future<OfferEntity> call(OfferEntity offer) async {
    return await repository.createOffer(offer);
  }
}
