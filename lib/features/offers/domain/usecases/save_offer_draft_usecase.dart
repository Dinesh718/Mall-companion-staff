import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

class SaveOfferDraftUseCase {
  final OfferRepository repository;

  SaveOfferDraftUseCase(this.repository);

  Future<OfferEntity> call(OfferEntity offer) async {
    return await repository.saveDraft(offer);
  }
}
