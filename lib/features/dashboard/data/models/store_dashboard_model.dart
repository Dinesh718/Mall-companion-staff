import '../../domain/entities/store_dashboard_entity.dart';

class StoreDashboardModel extends StoreDashboardEntity {
  const StoreDashboardModel({
    required super.managerName,
    required super.managerRole,
    required super.storeName,
    required super.storeLogoUrl,
    required super.storeLevel,
    required super.storeUnit,
    required super.isOpen,
    required super.closingTime,
    required super.trafficPercentage,
    required super.revenueTargetPercentage,
    required super.csatScore,
    required super.avgQueueTimeMinutes,
    required super.waitingQueueCount,
    required super.servingQueueCount,
    required super.estimatedQueueWaitTime,
    required super.isQueueActive,
    required super.todayOffers,
    required super.todayReservations,
  });

  factory StoreDashboardModel.fromJson(Map<String, dynamic> json) {
    return StoreDashboardModel(
      managerName: json['managerName'] as String? ?? '',
      managerRole: json['managerRole'] as String? ?? '',
      storeName: json['storeName'] as String? ?? '',
      storeLogoUrl: json['storeLogoUrl'] as String? ?? '',
      storeLevel: json['storeLevel'] as String? ?? '',
      storeUnit: json['storeUnit'] as String? ?? '',
      isOpen: json['isOpen'] as bool? ?? false,
      closingTime: json['closingTime'] as String? ?? '',
      trafficPercentage: json['trafficPercentage'] as int? ?? 0,
      revenueTargetPercentage: json['revenueTargetPercentage'] as int? ?? 0,
      csatScore: (json['csatScore'] as num? ?? 0.0).toDouble(),
      avgQueueTimeMinutes: (json['avgQueueTimeMinutes'] as num? ?? 0.0).toDouble(),
      waitingQueueCount: json['waitingQueueCount'] as int? ?? 0,
      servingQueueCount: json['servingQueueCount'] as int? ?? 0,
      estimatedQueueWaitTime: json['estimatedQueueWaitTime'] as String? ?? '',
      isQueueActive: json['isQueueActive'] as bool? ?? false,
      todayOffers: (json['todayOffers'] as List<dynamic>? ?? [])
          .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      todayReservations: (json['todayReservations'] as List<dynamic>? ?? [])
          .map((e) => ReservationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'managerName': managerName,
      'managerRole': managerRole,
      'storeName': storeName,
      'storeLogoUrl': storeLogoUrl,
      'storeLevel': storeLevel,
      'storeUnit': storeUnit,
      'isOpen': isOpen,
      'closingTime': closingTime,
      'trafficPercentage': trafficPercentage,
      'revenueTargetPercentage': revenueTargetPercentage,
      'csatScore': csatScore,
      'avgQueueTimeMinutes': avgQueueTimeMinutes,
      'waitingQueueCount': waitingQueueCount,
      'servingQueueCount': servingQueueCount,
      'estimatedQueueWaitTime': estimatedQueueWaitTime,
      'isQueueActive': isQueueActive,
      'todayOffers': todayOffers.map((e) => (e as OfferModel).toJson()).toList(),
      'todayReservations': todayReservations.map((e) => (e as ReservationModel).toJson()).toList(),
    };
  }
}

class OfferModel extends OfferEntity {
  const OfferModel({
    required super.title,
    required super.subtitle,
    required super.imageUrl,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
    };
  }
}

class ReservationModel extends ReservationEntity {
  const ReservationModel({
    required super.customerName,
    required super.time,
    required super.guestsCount,
    required super.isManageable,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      customerName: json['customerName'] as String? ?? '',
      time: json['time'] as String? ?? '',
      guestsCount: json['guestsCount'] as int? ?? 0,
      isManageable: json['isManageable'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'time': time,
      'guestsCount': guestsCount,
      'isManageable': isManageable,
    };
  }
}
