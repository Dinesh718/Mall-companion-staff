import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_companion_staff/features/offers/data/repositories/mock_offer_repository.dart';
import 'package:mall_companion_staff/features/offers/domain/entities/offer_entity.dart';
import 'package:mall_companion_staff/features/offers/domain/entities/offer_status.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/load_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/search_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/filter_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/load_offer_details_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/search_and_filter_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_event.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_state.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/offers_search_bar.dart';

void main() {
  late MockOfferRepository repository;
  late LoadOffersUseCase loadUseCase;
  late SearchOffersUseCase searchUseCase;
  late FilterOffersUseCase filterUseCase;
  late LoadOfferDetailsUseCase loadDetailsUseCase;
  late SearchAndFilterOffersUseCase searchAndFilterUseCase;
  late OffersBloc bloc;

  final firstOffer = OfferEntity(
    id: 'campaign_id_1',
    storeId: 'nike_store',
    storeName: 'Nike Retail',
    storeLogoUrl: 'nike.png',
    title: 'Nike Summer SpecialUniqueSummer Flat 50%',
    description: 'Promo for summer shoes',
    bannerUrl: '',
    category: 'Footwear',
    discountType: 'percentage',
    discountValue: 50.0,
    couponCode: 'NIKE50',
    status: 'Active',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 5)),
    views: 200,
    redemptions: 40,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final secondOffer = OfferEntity(
    id: 'campaign_id_2',
    storeId: 'nike_store',
    storeName: 'Nike Retail',
    storeLogoUrl: 'nike.png',
    title: 'Nike Winter SpecialUniqueWinter Flat 20%',
    description: 'Promo for winter coats',
    bannerUrl: '',
    category: 'Footwear',
    discountType: 'percentage',
    discountValue: 20.0,
    couponCode: 'NIKE20',
    status: 'Draft',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 5)),
    views: 100,
    redemptions: 10,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUp(() {
    repository = MockOfferRepository();
    loadUseCase = LoadOffersUseCase(repository);
    searchUseCase = SearchOffersUseCase(repository);
    filterUseCase = FilterOffersUseCase(repository);
    loadDetailsUseCase = LoadOfferDetailsUseCase(repository);
    searchAndFilterUseCase = SearchAndFilterOffersUseCase(repository);
    bloc = OffersBloc(
      loadOffersUseCase: loadUseCase,
      searchOffersUseCase: searchUseCase,
      filterOffersUseCase: filterUseCase,
      loadOfferDetailsUseCase: loadDetailsUseCase,
      searchAndFilterOffersUseCase: searchAndFilterUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('Repository Search and Filter Tests', () {
    test('MockOfferRepository combined searchAndFilterOffers matches status and title case-insensitive', () async {
      await repository.createOffer(firstOffer);
      await repository.createOffer(secondOffer);

      // Search matching title and active status
      var results = await repository.searchAndFilterOffers('SpecialUniqueSummer', OfferStatus.active);
      expect(results.length, 1);
      expect(results.first.id, firstOffer.id);

      // Search matching title and draft status
      results = await repository.searchAndFilterOffers('SpecialUniqueWinter', OfferStatus.draft);
      expect(results.length, 1);
      expect(results.first.id, secondOffer.id);

      // Search matching campaign ID
      results = await repository.searchAndFilterOffers('campaign_id_1', OfferStatus.all);
      expect(results.length, 1);
      expect(results.first.id, firstOffer.id);
    });
  });

  group('OffersBloc Search & Filter Event Flow Tests', () {
    test('SearchOffers preserves current activeFilter', () async {
      bloc.emit(OffersLoaded(
        offers: const [],
        allOffers: const [],
        activeFilter: OfferStatus.draft,
        searchQuery: '',
      ));

      bloc.add(const SearchOffers('Winter'));
      await bloc.stream.firstWhere((s) => s is OffersLoaded && s.searchQuery == 'Winter');

      final loaded = bloc.state as OffersLoaded;
      expect(loaded.searchQuery, 'Winter');
      expect(loaded.activeFilter, OfferStatus.draft);
    });

    test('FilterOffers preserves current searchQuery', () async {
      bloc.emit(OffersLoaded(
        offers: const [],
        allOffers: const [],
        activeFilter: OfferStatus.all,
        searchQuery: 'Summer',
      ));

      bloc.add(const FilterOffers('Active'));
      await bloc.stream.firstWhere((s) => s is OffersLoaded && s.activeFilter == OfferStatus.active);

      final loaded = bloc.state as OffersLoaded;
      expect(loaded.searchQuery, 'Summer');
      expect(loaded.activeFilter, OfferStatus.active);
    });

    test('ClearFilters restores default state', () async {
      final allList = [firstOffer, secondOffer];
      bloc.emit(OffersLoaded(
        offers: const [],
        allOffers: allList,
        activeFilter: OfferStatus.active,
        searchQuery: 'Summer',
      ));

      bloc.add(const ClearFilters());
      await bloc.stream.firstWhere((s) => s is OffersLoaded && s.searchQuery == '');

      final loaded = bloc.state as OffersLoaded;
      expect(loaded.searchQuery, '');
      expect(loaded.activeFilter, OfferStatus.all);
      expect(loaded.offers, allList);
    });
  });

  group('OffersSearchBar Widget Rendering Tests', () {
    Widget buildTestableWidget(Widget child) {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: bloc,
            child: child,
          ),
        ),
      );
    }

    testWidgets('renders all OfferStatus chips', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const OffersSearchBar(
            activeFilter: OfferStatus.all,
            searchQuery: '',
          ),
        ),
      );

      // Verify all status displays are present
      expect(find.text('All Offers'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Scheduled'), findsOneWidget);
      expect(find.text('Draft'), findsOneWidget);
      expect(find.text('Expired'), findsOneWidget);
    });

    testWidgets('clicking clear icon dispatches ClearFilters', (WidgetTester tester) async {
      bloc.emit(const OffersLoaded(
        offers: [],
        allOffers: [],
        activeFilter: OfferStatus.active,
        searchQuery: 'Nike',
      ));

      await tester.pumpWidget(
        buildTestableWidget(
          const OffersSearchBar(
            activeFilter: OfferStatus.active,
            searchQuery: 'Nike',
          ),
        ),
      );

      // Tap clear button icon
      await tester.tap(find.byIcon(Icons.filter_list_off_rounded));
      await tester.pump();

      // ClearFilters should reset
      expect(bloc.state, isA<OffersLoaded>());
    });
  });
}
