class StoreDashboardEntity {
  final String managerName;
  final String managerRole;
  final String storeName;
  final String storeLogoUrl;
  final String storeLevel;
  final String storeUnit;
  final bool isOpen;
  final String closingTime;
  final int trafficPercentage;
  final int revenueTargetPercentage;
  final double csatScore;
  final double avgQueueTimeMinutes;
  final int waitingQueueCount;
  final int servingQueueCount;
  final String estimatedQueueWaitTime;
  final bool isQueueActive;
  final List<OfferEntity> todayOffers;
  final List<ReservationEntity> todayReservations;

  const StoreDashboardEntity({
    required this.managerName,
    required this.managerRole,
    required this.storeName,
    required this.storeLogoUrl,
    required this.storeLevel,
    required this.storeUnit,
    required this.isOpen,
    required this.closingTime,
    required this.trafficPercentage,
    required this.revenueTargetPercentage,
    required this.csatScore,
    required this.avgQueueTimeMinutes,
    required this.waitingQueueCount,
    required this.servingQueueCount,
    required this.estimatedQueueWaitTime,
    required this.isQueueActive,
    required this.todayOffers,
    required this.todayReservations,
  });
}

class OfferEntity {
  final String title;
  final String subtitle;
  final String imageUrl;

  const OfferEntity({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

class ReservationEntity {
  final String customerName;
  final String time;
  final int guestsCount;
  final bool isManageable;

  const ReservationEntity({
    required this.customerName,
    required this.time,
    required this.guestsCount,
    required this.isManageable,
  });
}
