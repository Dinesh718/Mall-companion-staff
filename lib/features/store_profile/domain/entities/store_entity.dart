class StoreEntity {
  final String id;
  final String name;
  final String brandName;
  final String category;
  final double rating;
  final int reviewsCount;
  final bool isOpen;
  final String floor;
  final String unitNumber;
  final String openingTime;
  final String closingTime;
  final String managerName;
  final String wing;
  final String visitorsCount;
  final int activeOffersCount;
  final int reservationsCount;
  final String mallName;
  final String nearestGate;
  final String accessPoint;
  final String walkingTime;
  final String mapImageUrl;
  final String crowdLevel;
  final String currentQueueTime;
  final String serviceElevatorsStatus;
  final List<String> amenities;
  final String phoneNumber;
  final String email;
  final String website;
  final String instagramUrl;
  final String facebookUrl;
  final String twitterUrl;
  final Map<String, String> weeklyHours;
  final List<String> galleryUrls;
  final String logoUrl;
  final String bannerUrl;
  final String lastUpdated;

  const StoreEntity({
    required this.id,
    required this.name,
    required this.brandName,
    required this.category,
    required this.rating,
    required this.reviewsCount,
    required this.isOpen,
    required this.floor,
    required this.unitNumber,
    required this.openingTime,
    required this.closingTime,
    required this.managerName,
    required this.wing,
    required this.visitorsCount,
    required this.activeOffersCount,
    required this.reservationsCount,
    required this.mallName,
    required this.nearestGate,
    required this.accessPoint,
    required this.walkingTime,
    required this.mapImageUrl,
    required this.crowdLevel,
    required this.currentQueueTime,
    required this.serviceElevatorsStatus,
    required this.amenities,
    required this.phoneNumber,
    required this.email,
    required this.website,
    required this.instagramUrl,
    required this.facebookUrl,
    required this.twitterUrl,
    required this.weeklyHours,
    required this.galleryUrls,
    required this.logoUrl,
    required this.bannerUrl,
    required this.lastUpdated,
  });
}
