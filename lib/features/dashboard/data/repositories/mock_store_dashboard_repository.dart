import '../../domain/entities/store_dashboard_entity.dart';
import '../../domain/repositories/store_dashboard_repository.dart';
import '../models/store_dashboard_model.dart';

class MockStoreDashboardRepository implements StoreDashboardRepository {
  @override
  Future<StoreDashboardEntity> getDashboardData() async {
    // Simulate minor network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return const StoreDashboardModel(
      managerName: 'John David',
      managerRole: 'Store Manager',
      storeName: 'Nike Flagship Store',
      storeLogoUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAHVVgTUdaxmhmBAP0ovpHiRC4i8Ua0Rbk7v_ca-YGW6KsTe-ZVBUDRdqLevm6E772FfuhLmjbjr4aUwSeeNFsoYaxsQd_SjO94yOZFCTQEL4-aRNx2CwZjC7uKI2i0cshmbUCHgRNGBPB9Vze_9dT1Nv6rGFJwcU9HiTcXBcAKb4wzfx0x1ImXYQSicazkV-nBx4EXYufecpBd52sZYFeQWvs3vlWDBuJfv7tG3hJa3AtNmd-edq_JOhGgqwPbH2Wg9Q394QF0nQ',
      storeLevel: 'Level 1',
      storeUnit: 'Unit F-104',
      isOpen: true,
      closingTime: '10:00 PM',
      trafficPercentage: 80,
      revenueTargetPercentage: 70,
      csatScore: 4.8,
      avgQueueTimeMinutes: 8.5,
      waitingQueueCount: 8,
      servingQueueCount: 3,
      estimatedQueueWaitTime: '15m',
      isQueueActive: true,
      todayOffers: [
        OfferModel(
          title: 'Flat 30% OFF',
          subtitle: 'Valid until 9:00 PM',
          imageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCzCz_XiTTjBJXKLhwyYzKuosXjuclwweSSE35TBwFdCIjmKWDq7wtRbAwuUwLRbdgq5mRSvs4YfN0XghWeez6mCwdxQkcPJIxelvMu_sF0SsThTsW2B1_G1OLVf2Z2dDixOxsiAnC89gjZpMxblWDEPP0i2VrVcVM4VeaLtJ_FIyEgQrnqmdId-H0xLneoBAj7DdLqOoVktqkIrXSC_6PD8Wq-Oid2HX4-B8nhl-lzv1lbVqJTv3e1Cj9SbEdWBSpECj09astu8w',
        ),
        OfferModel(
          title: 'Buy 2 Get 1',
          subtitle: 'Member Exclusive',
          imageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDUZvGINtACNR3un7xJTrqjy-nhP2zHW8sj9fCVRzBtlcTxJLzWO5wy9XJfJAn9kBKicYXYbaw-mnPoIJPZWzkWkAysT2Tqx_cTKPs2BjGQoQFXjMZKx-A8KxBYPa4d8eu6pl3mVQ4Znd7X1zi_9ncImu_9EB-tsZKeEC6ZhAgSmE6MjDmZ8hOaC1CGYoBmrs7wLg-Tzs-Vgrey4g17BSjZcgZA6QAG9Z_Y2WtO9nklfQljfcjM2kskmYs0fDazJL6Bpgmp0J6DUg',
        ),
      ],
      todayReservations: [
        ReservationModel(
          customerName: 'Alice Smith',
          time: '2:00 PM',
          guestsCount: 2,
          isManageable: true,
        ),
        ReservationModel(
          customerName: 'Marcus Chen',
          time: '4:30 PM',
          guestsCount: 1,
          isManageable: false,
        ),
      ],
    );
  }
}
