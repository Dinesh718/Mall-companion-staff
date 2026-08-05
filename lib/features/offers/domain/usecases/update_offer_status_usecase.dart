import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

class UpdateOfferStatusUseCase {
  final OfferRepository repository;

  UpdateOfferStatusUseCase(this.repository);

  Future<OfferEntity> call(String offerId, String status) async {
    return await repository.updateOfferStatus(offerId, status);
  }
}
