import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/offers/domain/entities/offer_entity.dart';
import 'package:mall_companion_staff/features/offers/domain/entities/offer_status.dart';
import 'package:mall_companion_staff/features/offers/data/models/offer_model.dart';
import 'package:mall_companion_staff/features/offers/data/repositories/mock_offer_repository.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/load_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/search_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/filter_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/load_offer_details_usecase.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_event.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_state.dart';
import 'package:mall_companion_staff/features/offers/presentation/pages/offers_dashboard_page.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/offer_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/offers_overview_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/offers_statistics_section.dart';

void main() {
  group('Offers Entity & Model Tests', () {
    test('OfferEntity can be created with valid parameters', () {
      final offer = OfferEntity(
        id: '1',
        storeId: 'nike_store',
        storeName: 'Nike Store',
        storeLogoUrl: 'https://logo.png',
        title: 'Discount',
        description: 'Promo info',
        bannerUrl: 'https://banner.jpg',
        category: 'Fashion',
        discountType: 'percentage',
        discountValue: 20.0,
        couponCode: 'SAVE20',
        status: 'Active',
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 1, 31),
        views: 100,
        redemptions: 10,
        createdAt: DateTime(2025, 12, 25),
        updatedAt: DateTime(2025, 12, 25),
      );

      expect(offer.id, '1');
      expect(offer.discountValue, 20.0);
    });

    test('OfferModel toJson/fromJson works correctly', () {
      final model = OfferModel(
        id: '2',
        storeId: 'adidas_store',
        storeName: 'Adidas Store',
        storeLogoUrl: 'https://logo2.png',
        title: 'FLAT 10%',
        description: 'Details',
        bannerUrl: 'https://banner2.jpg',
        category: 'Sports',
        discountType: 'percentage',
        discountValue: 10.0,
        couponCode: 'ADI10',
        status: 'Active',
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 1, 31),
        views: 200,
        redemptions: 20,
        createdAt: DateTime(2025, 12, 25),
        updatedAt: DateTime(2025, 12, 25),
      );

      final json = model.toJson();
      expect(json['id'], '2');

      final fromJson = OfferModel.fromJson(json);
      expect(fromJson.title, 'FLAT 10%');
    });
  });

  group('MockOfferRepository Tests', () {
    late MockOfferRepository repo;

    setUp(() {
      repo = MockOfferRepository();
    });

    test('loadOffers returns 24 mock offers', () async {
      final list = await repo.loadOffers();
      expect(list.length, 24);
    });

    test('searchOffers filters titles and descriptions correctly', () async {
      final list = await repo.searchOffers('Nike');
      expect(list.isNotEmpty, isTrue);
      for (final o in list) {
        expect(
          o.title.toLowerCase().contains('nike') ||
          o.description.toLowerCase().contains('nike') ||
          o.storeName.toLowerCase().contains('nike'),
          isTrue,
        );
      }
    });

    test('filterOffers filters statuses correctly', () async {
      final list = await repo.filterOffers('Draft');
      expect(list.length, 4); // pre-populated lists contain 4 drafts
    });
  });

  group('Offers UseCases Tests', () {
    late MockOfferRepository repo;
    late LoadOffersUseCase loadUseCase;
    late SearchOffersUseCase searchUseCase;
    late FilterOffersUseCase filterUseCase;

    setUp(() {
      repo = MockOfferRepository();
      loadUseCase = LoadOffersUseCase(repo);
      searchUseCase = SearchOffersUseCase(repo);
      filterUseCase = FilterOffersUseCase(repo);
    });

    test('LoadOffersUseCase loads data from repository', () async {
      final res = await loadUseCase();
      expect(res.length, 24);
    });

    test('SearchOffersUseCase searches data from repository', () async {
      final res = await searchUseCase('Weekend');
      expect(res.isNotEmpty, isTrue);
    });

    test('FilterOffersUseCase filters data from repository', () async {
      final res = await filterUseCase('Scheduled');
      expect(res.length, 5); // prepopulated list contains 5 scheduled
    });
  });

  group('OffersBloc Tests', () {
    late MockOfferRepository repo;
    late LoadOffersUseCase loadUseCase;
    late SearchOffersUseCase searchUseCase;
    late FilterOffersUseCase filterUseCase;
    late LoadOfferDetailsUseCase loadDetailsUseCase;
    late OffersBloc bloc;

    setUp(() {
      repo = MockOfferRepository();
      loadUseCase = LoadOffersUseCase(repo);
      searchUseCase = SearchOffersUseCase(repo);
      filterUseCase = FilterOffersUseCase(repo);
      loadDetailsUseCase = LoadOfferDetailsUseCase(repo);
      bloc = OffersBloc(
        loadOffersUseCase: loadUseCase,
        searchOffersUseCase: searchUseCase,
        filterOffersUseCase: filterUseCase,
        loadOfferDetailsUseCase: loadDetailsUseCase,
      );
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is OffersInitial', () {
      expect(bloc.state, const OffersInitial());
    });

    test('LoadOffers event triggers Loading -> Loaded states', () async {
      final states = <OffersState>[];
      bloc.stream.listen(states.add);

      bloc.add(const LoadOffers());
      await bloc.stream.firstWhere((s) => s is OffersLoaded);

      expect(states[0], const OffersLoading());
      expect(states[1], isA<OffersLoaded>());
      final loaded = states[1] as OffersLoaded;
      expect(loaded.allOffers.length, 24);
    });

    test('SearchOffers filters displayed list', () async {
      bloc.add(const LoadOffers());
      await bloc.stream.firstWhere((s) => s is OffersLoaded);

      bloc.add(const SearchOffers('Weekend'));
      await bloc.stream.firstWhere((s) => s is OffersLoaded && s.searchQuery == 'Weekend');

      final loadedState = bloc.state as OffersLoaded;
      expect(loadedState.searchQuery, 'Weekend');
      expect(loadedState.offers.length, lessThan(loadedState.allOffers.length));
    });

    test('FilterOffers updates active filter', () async {
      bloc.add(const LoadOffers());
      await bloc.stream.firstWhere((s) => s is OffersLoaded);

      bloc.add(const FilterOffers('Draft'));
      await bloc.stream.firstWhere((s) => s is OffersLoaded && s.activeFilter == OfferStatus.draft);

      final loadedState = bloc.state as OffersLoaded;
      expect(loadedState.activeFilter, OfferStatus.draft);
      expect(loadedState.offers.length, 4);
    });
  });

  group('Offers Dashboard Widgets Test', () {
    testWidgets('OffersDashboardPage renders stats cards, search bar, and fab', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OffersDashboardPage(),
        ),
      );

      // Verify loading is triggered initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for repository fetch
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(); // trigger rebuild after future resolves

      // Verify page layout widgets loaded successfully
      expect(find.text('Offers Management'), findsOneWidget);
      expect(find.byType(OffersOverviewCard), findsOneWidget);
      expect(find.byType(OffersStatisticsSection), findsOneWidget);
      expect(find.byType(OfferCard), findsWidgets);
      expect(find.text('Create Offer'), findsOneWidget);
    });
  });
}
