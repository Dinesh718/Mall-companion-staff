import '../entities/offer_entity.dart';
import '../entities/create_offer_form_entity.dart';
import '../entities/offer_status.dart';

abstract class OfferRepository {
  Future<List<OfferEntity>> loadOffers();
  Future<List<OfferEntity>> searchOffers(String query);
  Future<List<OfferEntity>> filterOffers(String status);
  Future<OfferEntity> getOfferDetails(String offerId);

  // Phase 3.3 Create Offer
  Future<OfferEntity> createOffer(OfferEntity offer);
  Future<OfferEntity> saveDraft(OfferEntity offer);
  Future<Map<String, String>> validateOffer(CreateOfferFormEntity form);

  // Phase 3.4 Edit Offer
  Future<OfferEntity> updateOffer(OfferEntity offer);

  // Phase 3.5 Delete Offer
  Future<void> deleteOffer(String offerId);

  // Phase 3.6 Enable/Disable Campaign
  Future<OfferEntity> updateOfferStatus(String offerId, String status);

  // Phase 3.7 Search & Filter
  Future<List<OfferEntity>> searchAndFilterOffers(String query, OfferStatus status);
}
