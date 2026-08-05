enum OfferStatus {
  all,
  active,
  scheduled,
  draft,
  expired;

  static OfferStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return OfferStatus.active;
      case 'scheduled':
        return OfferStatus.scheduled;
      case 'draft':
        return OfferStatus.draft;
      case 'expired':
        return OfferStatus.expired;
      case 'all':
      default:
        return OfferStatus.all;
    }
  }

  String toDisplayString() {
    switch (this) {
      case OfferStatus.all:
        return 'All Offers';
      case OfferStatus.active:
        return 'Active';
      case OfferStatus.scheduled:
        return 'Scheduled';
      case OfferStatus.draft:
        return 'Draft';
      case OfferStatus.expired:
        return 'Expired';
    }
  }
}
