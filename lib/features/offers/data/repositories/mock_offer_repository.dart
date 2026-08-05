import '../../domain/entities/offer_entity.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../../domain/entities/offer_status.dart';
import '../../domain/repositories/offer_repository.dart';

class MockOfferRepository implements OfferRepository {
  // Prepopulated 24 offers representing campaign overview stats
  final List<OfferEntity> _offers = [
    // 1. Active Offer 1: Nike Flat 30% Off (with full details for Phase 3.2 details screen)
    OfferEntity(
      id: 'active_1',
      storeId: 'nike_flagship',
      storeName: 'Nike Flagship',
      storeLogoUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAfjw1trdoiYkG2FhmysKApG4k3T7_qIWd263QW5l7NlXYJMEYw_YYZN6Kl-4MIAv4jZHuIdirzwRKBJ8_SBaiknr-S8m2-BblZaR88Unsi1v97pJIClJ3GUKGUmGLMcp-hy4VFWq8HNT-YLkM576DJpt8IWja8yVLSif2dmfYk3Ffj6okrn3q8R8INInvXKJzO-NCb3GuJv_Fvj91TDjSdlSu2ifva2reuEZ-HlqzCJdduAfL0aj5V2RljB2wedwySYeF0EcuGLg',
      title: 'FLAT 30% OFF',
      description: "This strategic flash sale campaign aims to drive footfall to the Nike Flagship store during the mid-season transition. The offer covers the entire 'Active Lifestyle' and 'Performance Running' collections, allowing members to upgrade their gear at an exclusive price point. Mall staff should ensure secondary point-of-sale displays are clearly marked with the MC-8829 identifier for internal tracking.",
      bannerUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBsjpB05kZbTikvJVN6YKUlE5qvyFhT9G74Bz2hWo_QwwLnmHAChFfBtlw9fPm_aaNDSVDt_0CubYjgtBk4bI-twhjovZWk4I3qvQBwQ7Mne_pnsRJqvTolW5zfowxMIa7Dh642Lf_djyqenWhtmyYN8OI4A-CxBl-0NDzzJYYCdRLQDl5rQVieH1kUulyFknN5bbj1FAr0XuWnEHLSykZyaousr_-bMGquxFIsbgdXLQGI-gA4Ie5MzgF4cvbqJk1V683ibTTCLg',
      category: 'Fashion & Footwear',
      discountType: 'percentage',
      discountValue: 30.0,
      couponCode: 'NIKE30',
      status: 'Active',
      startDate: DateTime(2026, 7, 12),
      endDate: DateTime(2026, 7, 24),
      views: 12000,
      redemptions: 4200,
      createdAt: DateTime(2026, 7, 10),
      updatedAt: DateTime(2026, 7, 12),
      createdBy: 'Mall Admin',
      termsAndConditions: [
        'Offer valid only at Nike Flagship Store, Wing B.',
        'Cannot be combined with other ongoing mall-wide promotions.',
        '30% discount applies to MSRP on selected items only.',
        'Coupon NIKE30 must be presented at the point of sale.'
      ],
      conversionRate: 35.0,
      bestPerformingDay: 'Saturday',
      peakHour: '18:00 - 20:00',
      storeLocation: 'Ground Floor, Wing B (Elite Zone)',
      storeManagerName: 'John David',
      todayRedemptions: 248,
      todayViews: 1824,
      campaignHealth: 'EXCELLENT',
      campaignHealthDesc: 'Running for 12 Days | Ends in 12 Days | Performance Above Average',
      timeline: [
        {'title': 'Campaign Created', 'subtitle': 'Oct 10, 2023 • 09:12 AM', 'status': 'completed'},
        {'title': 'Activated & Verified', 'subtitle': 'Oct 12, 2023 • 10:00 AM', 'status': 'completed'},
        {'title': 'Currently Live', 'subtitle': 'Operational since 12 days', 'status': 'active'},
        {'title': 'Expires On', 'subtitle': 'Oct 24, 2023 • 11:59 PM', 'status': 'upcoming'},
      ],
      systemLogs: [
        {'title': 'Campaign Created', 'subtitle': 'By Admin at 09:12 AM', 'type': 'create'},
        {'title': 'Metadata Updated', 'subtitle': 'Banner assets replaced', 'type': 'update'},
        {'title': 'Campaign Activated', 'subtitle': 'Broadcasted to all users', 'type': 'activate'},
        {'title': 'Coupon Modified', 'subtitle': 'Usage limit increased by 500', 'type': 'edit'},
      ],
    ),
    // 2. Active Offer 2 (Expiring Alert): Weekend Flash Sale
    OfferEntity(
      id: 'active_2',
      storeId: 'nike_flagship',
      storeName: 'Nike Flagship',
      storeLogoUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAfjw1trdoiYkG2FhmysKApG4k3T7_qIWd263QW5l7NlXYJMEYw_YYZN6Kl-4MIAv4jZHuIdirzwRKBJ8_SBaiknr-S8m2-BblZaR88Unsi1v97pJIClJ3GUKGUmGLMcp-hy4VFWq8HNT-YLkM576DJpt8IWja8yVLSif2dmfYk3Ffj6okrn3q8R8INInvXKJzO-NCb3GuJv_Fvj91TDjSdlSu2ifva2reuEZ-HlqzCJdduAfL0aj5V2RljB2wedwySYeF0EcuGLg',
      title: 'Weekend Flash Sale',
      description: 'Flash sale ending in 24 hours. Get additional markdown.',
      bannerUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDc0_59cshgvhrQooSdcASpUom_um6RDK3V2cGlzPY5k-_UpV74KgybAHGKAPXZtcluX2gGBDHP54BLWHpl0R9DIMKmAeRapMPHIXI9hhdUkvQc8CKMbrL49ktEz958sFvFd9gyeOuANd6rtcC9dmuZNZ3W2sLaM9xtdpHkQlmrZKF_pu8eUxyUIAybaPU9vuM-9RtTxa1OXUO7MxIEgHSsfpnwj-gqnyZUmRLhaKEP-NIPwa6RKwM5lZ1tqRXP3CvHWx-XDhRJKA',
      category: 'Weekend Special',
      discountType: 'percentage',
      discountValue: 15.0,
      couponCode: 'FLASH15',
      status: 'Active',
      startDate: DateTime(2026, 7, 24),
      endDate: DateTime.now().add(const Duration(hours: 23)),
      views: 1200,
      redemptions: 312,
      createdAt: DateTime(2026, 7, 23),
      updatedAt: DateTime(2026, 7, 23),
      metadata: {'isAlert': true, 'alertType': 'expires_tomorrow'},
      createdBy: 'Store Manager',
      termsAndConditions: [
        'Offer valid only at Nike Flagship Store, Wing B.',
        'Flash sale discounts cannot be combined with other codes.',
      ],
      conversionRate: 26.0,
      bestPerformingDay: 'Sunday',
      peakHour: '12:00 - 14:00',
      storeLocation: 'Ground Floor, Wing B (Elite Zone)',
      storeManagerName: 'John David',
      todayRedemptions: 48,
      todayViews: 200,
      campaignHealth: 'GOOD',
      campaignHealthDesc: 'Active campaign with strong traction.',
    ),
    // 3. Draft Offer 1 (Alert 2): Back to School Campaign v2
    OfferEntity(
      id: 'draft_1',
      storeId: 'nike_flagship',
      storeName: 'Nike Flagship',
      storeLogoUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAfjw1trdoiYkG2FhmysKApG4k3T7_qIWd263QW5l7NlXYJMEYw_YYZN6Kl-4MIAv4jZHuIdirzwRKBJ8_SBaiknr-S8m2-BblZaR88Unsi1v97pJIClJ3GUKGUmGLMcp-hy4VFWq8HNT-YLkM576DJpt8IWja8yVLSif2dmfYk3Ffj6okrn3q8R8INInvXKJzO-NCb3GuJv_Fvj91TDjSdlSu2ifva2reuEZ-HlqzCJdduAfL0aj5V2RljB2wedwySYeF0EcuGLg',
      title: 'Back to School Campaign v2',
      description: 'Back to school bag discounts and accessories bundle.',
      bannerUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBsjpB05kZbTikvJVN6YKUlE5qvyFhT9G74Bz2hWo_QwwLnmHAChFfBtlw9fPm_aaNDSVDt_0CubYjgtBk4bI-twhjovZWk4I3qvQBwQ7Mne_pnsRJqvTolW5zfowxMIa7Dh642Lf_djyqenWhtmyYN8OI4A-CxBl-0NDzzJYYCdRLQDl5rQVieH1kUulyFknN5bbj1FAr0XuWnEHLSykZyaousr_-bMGquxFIsbgdXLQGI-gA4Ie5MzgF4cvbqJk1V683ibTTCLg',
      category: 'Accessories',
      discountType: 'percentage',
      discountValue: 20.0,
      couponCode: 'SCHOOL20',
      status: 'Draft',
      startDate: DateTime(2026, 8, 1),
      endDate: DateTime(2026, 8, 31),
      views: 0,
      redemptions: 0,
      createdAt: DateTime(2026, 7, 20),
      updatedAt: DateTime(2026, 7, 20),
      metadata: {'isAlert': true, 'alertType': 'awaiting_publication'},
      createdBy: 'Store Manager',
      termsAndConditions: ['TBD on launch approval.'],
      conversionRate: 0.0,
      bestPerformingDay: '-',
      peakHour: '-',
      storeLocation: 'Ground Floor, Wing B (Elite Zone)',
      storeManagerName: 'John David',
      todayRedemptions: 0,
      todayViews: 0,
      campaignHealth: 'PENDING',
      campaignHealthDesc: 'Awaiting publication approval.',
    ),
    // Additional 10 Active Offers (total 12 Active)
    ...List.generate(10, (index) => OfferEntity(
      id: 'active_extra_$index',
      storeId: 'nike_flagship',
      storeName: 'Nike Flagship',
      storeLogoUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAfjw1trdoiYkG2FhmysKApG4k3T7_qIWd263QW5l7NlXYJMEYw_YYZN6Kl-4MIAv4jZHuIdirzwRKBJ8_SBaiknr-S8m2-BblZaR88Unsi1v97pJIClJ3GUKGUmGLMcp-hy4VFWq8HNT-YLkM576DJpt8IWja8yVLSif2dmfYk3Ffj6okrn3q8R8INInvXKJzO-NCb3GuJv_Fvj91TDjSdlSu2ifva2reuEZ-HlqzCJdduAfL0aj5V2RljB2wedwySYeF0EcuGLg',
      title: 'Active Promo ${index + 3}',
      description: 'Description for active offer ${index + 3}',
      bannerUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBsjpB05kZbTikvJVN6YKUlE5qvyFhT9G74Bz2hWo_QwwLnmHAChFfBtlw9fPm_aaNDSVDt_0CubYjgtBk4bI-twhjovZWk4I3qvQBwQ7Mne_pnsRJqvTolW5zfowxMIa7Dh642Lf_djyqenWhtmyYN8OI4A-CxBl-0NDzzJYYCdRLQDl5rQVieH1kUulyFknN5bbj1FAr0XuWnEHLSykZyaousr_-bMGquxFIsbgdXLQGI-gA4Ie5MzgF4cvbqJk1V683ibTTCLg',
      category: 'Sports Gear',
      discountType: 'flat',
      discountValue: 10.0,
      couponCode: 'ACTIVE${index + 3}',
      status: 'Active',
      startDate: DateTime(2026, 7, 10),
      endDate: DateTime(2026, 8, 10),
      views: 150 + index * 10,
      redemptions: 40 + index * 2,
      createdAt: DateTime(2026, 7, 9),
      updatedAt: DateTime(2026, 7, 9),
      createdBy: 'Store Manager',
      termsAndConditions: ['Standard store terms apply.'],
      conversionRate: 20.0,
      bestPerformingDay: 'Friday',
      peakHour: '16:00 - 18:00',
      storeLocation: 'Ground Floor, Wing B (Elite Zone)',
      storeManagerName: 'John David',
      todayRedemptions: 12,
      todayViews: 50,
      campaignHealth: 'GOOD',
      campaignHealthDesc: 'Performance is within normal parameters.',
    )),
    // 5 Scheduled Offers
    ...List.generate(5, (index) => OfferEntity(
      id: 'scheduled_$index',
      storeId: 'nike_flagship',
      storeName: 'Nike Flagship',
      storeLogoUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAfjw1trdoiYkG2FhmysKApG4k3T7_qIWd263QW5l7NlXYJMEYw_YYZN6Kl-4MIAv4jZHuIdirzwRKBJ8_SBaiknr-S8m2-BblZaR88Unsi1v97pJIClJ3GUKGUmGLMcp-hy4VFWq8HNT-YLkM576DJpt8IWja8yVLSif2dmfYk3Ffj6okrn3q8R8INInvXKJzO-NCb3GuJv_Fvj91TDjSdlSu2ifva2reuEZ-HlqzCJdduAfL0aj5V2RljB2wedwySYeF0EcuGLg',
      title: 'Scheduled Promo ${index + 1}',
      description: 'Upcoming campaign details.',
      bannerUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBsjpB05kZbTikvJVN6YKUlE5qvyFhT9G74Bz2hWo_QwwLnmHAChFfBtlw9fPm_aaNDSVDt_0CubYjgtBk4bI-twhjovZWk4I3qvQBwQ7Mne_pnsRJqvTolW5zfowxMIa7Dh642Lf_djyqenWhtmyYN8OI4A-CxBl-0NDzzJYYCdRLQDl5rQVieH1kUulyFknN5bbj1FAr0XuWnEHLSykZyaousr_-bMGquxFIsbgdXLQGI-gA4Ie5MzgF4cvbqJk1V683ibTTCLg',
      category: 'Seasonal',
      discountType: 'percentage',
      discountValue: 25.0,
      couponCode: 'SCHED${index + 1}',
      status: 'Scheduled',
      startDate: DateTime(2026, 8, 15),
      endDate: DateTime(2026, 9, 15),
      views: 0,
      redemptions: 0,
      createdAt: DateTime(2026, 7, 24),
      updatedAt: DateTime(2026, 7, 24),
      createdBy: 'Store Manager',
      termsAndConditions: ['Launches automatically on start date.'],
      conversionRate: 0.0,
      bestPerformingDay: '-',
      peakHour: '-',
      storeLocation: 'Ground Floor, Wing B (Elite Zone)',
      storeManagerName: 'John David',
      todayRedemptions: 0,
      todayViews: 0,
      campaignHealth: 'SCHEDULED',
      campaignHealthDesc: 'Scheduled to start in future.',
    )),
    // 3 Draft Offers (remaining from total 4, since draft_1 is already declared)
    ...List.generate(3, (index) => OfferEntity(
      id: 'draft_extra_$index',
      storeId: 'nike_flagship',
      storeName: 'Nike Flagship',
      storeLogoUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAfjw1trdoiYkG2FhmysKApG4k3T7_qIWd263QW5l7NlXYJMEYw_YYZN6Kl-4MIAv4jZHuIdirzwRKBJ8_SBaiknr-S8m2-BblZaR88Unsi1v97pJIClJ3GUKGUmGLMcp-hy4VFWq8HNT-YLkM576DJpt8IWja8yVLSif2dmfYk3Ffj6okrn3q8R8INInvXKJzO-NCb3GuJv_Fvj91TDjSdlSu2ifva2reuEZ-HlqzCJdduAfL0aj5V2RljB2wedwySYeF0EcuGLg',
      title: 'Draft Promo ${index + 2}',
      description: 'Under review details.',
      bannerUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBsjpB05kZbTikvJVN6YKUlE5qvyFhT9G74Bz2hWo_QwwLnmHAChFfBtlw9fPm_aaNDSVDt_0CubYjgtBk4bI-twhjovZWk4I3qvQBwQ7Mne_pnsRJqvTolW5zfowxMIa7Dh642Lf_djyqenWhtmyYN8OI4A-CxBl-0NDzzJYYCdRLQDl5rQVieH1kUulyFknN5bbj1FAr0XuWnEHLSykZyaousr_-bMGquxFIsbgdXLQGI-gA4Ie5MzgF4cvbqJk1V683ibTTCLg',
      category: 'Seasonal',
      discountType: 'percentage',
      discountValue: 10.0,
      couponCode: 'DRAFT${index + 2}',
      status: 'Draft',
      startDate: DateTime(2026, 9, 1),
      endDate: DateTime(2026, 9, 30),
      views: 0,
      redemptions: 0,
      createdAt: DateTime(2026, 7, 24),
      updatedAt: DateTime(2026, 7, 24),
      createdBy: 'Store Manager',
      termsAndConditions: ['Undergoing review.'],
      conversionRate: 0.0,
      bestPerformingDay: '-',
      peakHour: '-',
      storeLocation: 'Ground Floor, Wing B (Elite Zone)',
      storeManagerName: 'John David',
      todayRedemptions: 0,
      todayViews: 0,
      campaignHealth: 'PENDING',
      campaignHealthDesc: 'Awaiting approval.',
    )),
    // 3 Expired Offers
    ...List.generate(3, (index) => OfferEntity(
      id: 'expired_$index',
      storeId: 'nike_flagship',
      storeName: 'Nike Flagship',
      storeLogoUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAfjw1trdoiYkG2FhmysKApG4k3T7_qIWd263QW5l7NlXYJMEYw_YYZN6Kl-4MIAv4jZHuIdirzwRKBJ8_SBaiknr-S8m2-BblZaR88Unsi1v97pJIClJ3GUKGUmGLMcp-hy4VFWq8HNT-YLkM576DJpt8IWja8yVLSif2dmfYk3Ffj6okrn3q8R8INInvXKJzO-NCb3GuJv_Fvj91TDjSdlSu2ifva2reuEZ-HlqzCJdduAfL0aj5V2RljB2wedwySYeF0EcuGLg',
      title: 'Expired Promo ${index + 1}',
      description: 'Past promo campaign.',
      bannerUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBsjpB05kZbTikvJVN6YKUlE5qvyFhT9G74Bz2hWo_QwwLnmHAChFfBtlw9fPm_aaNDSVDt_0CubYjgtBk4bI-twhjovZWk4I3qvQBwQ7Mne_pnsRJqvTolW5zfowxMIa7Dh642Lf_djyqenWhtmyYN8OI4A-CxBl-0NDzzJYYCdRLQDl5rQVieH1kUulyFknN5bbj1FAr0XuWnEHLSykZyaousr_-bMGquxFIsbgdXLQGI-gA4Ie5MzgF4cvbqJk1V683ibTTCLg',
      category: 'Fashion',
      discountType: 'flat',
      discountValue: 50.0,
      couponCode: 'EXP${index + 1}',
      status: 'Expired',
      startDate: DateTime(2026, 5, 1),
      endDate: DateTime(2026, 5, 31),
      views: 800 + index * 50,
      redemptions: 250 + index * 10,
      createdAt: DateTime(2026, 4, 25),
      updatedAt: DateTime(2026, 5, 31),
      createdBy: 'Store Manager',
      termsAndConditions: ['Offer expired.'],
      conversionRate: 31.0,
      bestPerformingDay: 'Saturday',
      peakHour: '17:00 - 19:00',
      storeLocation: 'Ground Floor, Wing B (Elite Zone)',
      storeManagerName: 'John David',
      todayRedemptions: 0,
      todayViews: 0,
      campaignHealth: 'EXPIRED',
      campaignHealthDesc: 'Campaign has ended.',
    )),
  ];

  @override
  Future<List<OfferEntity>> loadOffers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _offers;
  }

  @override
  Future<List<OfferEntity>> searchOffers(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (query.isEmpty) return _offers;
    final term = query.toLowerCase();
    return _offers.where((o) {
      return o.title.toLowerCase().contains(term) ||
             o.description.toLowerCase().contains(term) ||
             o.storeName.toLowerCase().contains(term);
    }).toList();
  }

  @override
  Future<List<OfferEntity>> filterOffers(String status) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (status.isEmpty || status.toLowerCase() == 'all') return _offers;
    final target = status.toLowerCase();
    return _offers.where((o) => o.status.toLowerCase() == target).toList();
  }

  @override
  Future<OfferEntity> getOfferDetails(String offerId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final match = _offers.firstWhere(
      (o) => o.id == offerId,
      orElse: () => _offers.first,
    );
    return match;
  }

  @override
  Future<OfferEntity> createOffer(OfferEntity offer) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _offers.insert(0, offer);
    return offer;
  }

  @override
  Future<OfferEntity> saveDraft(OfferEntity offer) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _offers.insert(0, offer);
    return offer;
  }

  @override
  Future<Map<String, String>> validateOffer(CreateOfferFormEntity form) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return {};
  }

  @override
  Future<OfferEntity> updateOffer(OfferEntity offer) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final idx = _offers.indexWhere((o) => o.id == offer.id);
    if (idx != -1) {
      _offers[idx] = offer;
    } else {
      _offers.insert(0, offer);
    }
    return offer;
  }

  @override
  Future<void> deleteOffer(String offerId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final idx = _offers.indexWhere((o) => o.id == offerId);
    if (idx != -1) {
      _offers.removeAt(idx);
    } else {
      throw Exception('Offer with ID $offerId not found');
    }
  }

  @override
  Future<OfferEntity> updateOfferStatus(String offerId, String status) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final idx = _offers.indexWhere((o) => o.id == offerId);
    if (idx != -1) {
      final original = _offers[idx];
      final updated = OfferEntity(
        id: original.id,
        storeId: original.storeId,
        storeName: original.storeName,
        storeLogoUrl: original.storeLogoUrl,
        title: original.title,
        description: original.description,
        bannerUrl: original.bannerUrl,
        category: original.category,
        discountType: original.discountType,
        discountValue: original.discountValue,
        couponCode: original.couponCode,
        status: status,
        startDate: original.startDate,
        endDate: original.endDate,
        views: original.views,
        redemptions: original.redemptions,
        createdAt: original.createdAt,
        updatedAt: DateTime.now(),
        createdBy: original.createdBy,
        termsAndConditions: original.termsAndConditions,
        conversionRate: original.conversionRate,
        bestPerformingDay: original.bestPerformingDay,
        peakHour: original.peakHour,
        storeLocation: original.storeLocation,
        storeManagerName: original.storeManagerName,
        todayRedemptions: original.todayRedemptions,
        todayViews: original.todayViews,
        campaignHealth: original.campaignHealth,
        campaignHealthDesc: original.campaignHealthDesc,
        timeline: original.timeline,
        systemLogs: original.systemLogs,
      );
      _offers[idx] = updated;
      return updated;
    } else {
      throw Exception('Offer with ID $offerId not found');
    }
  }

  @override
  Future<List<OfferEntity>> searchAndFilterOffers(String query, OfferStatus status) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final term = query.trim().toLowerCase();
    
    return _offers.where((o) {
      if (status != OfferStatus.all) {
        final target = status.name.toLowerCase();
        if (o.status.toLowerCase() != target) {
          return false;
        }
      }
      if (term.isNotEmpty) {
        final matchTitle = o.title.toLowerCase().contains(term);
        final matchDesc = o.description.toLowerCase().contains(term);
        final matchStore = o.storeName.toLowerCase().contains(term);
        final matchId = o.id.toLowerCase().contains(term);
        return matchTitle || matchDesc || matchStore || matchId;
      }
      return true;
    }).toList();
  }
}
