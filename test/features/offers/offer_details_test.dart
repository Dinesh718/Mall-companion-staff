import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_companion_staff/features/offers/data/repositories/mock_offer_repository.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/load_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/search_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/filter_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/load_offer_details_usecase.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_event.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_state.dart';
import 'package:mall_companion_staff/features/offers/presentation/pages/offer_details_page.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/offer_banner_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/campaign_overview_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/campaign_validity_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/store_information_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/campaign_description_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/campaign_health_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/performance_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/timeline_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/terms_conditions_card.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/offer_action_section.dart';

void main() {
  group('MockOfferRepository Details Tests', () {
    late MockOfferRepository repo;

    setUp(() {
      repo = MockOfferRepository();
    });

    test('getOfferDetails returns correct details mapping for active_1', () async {
      final details = await repo.getOfferDetails('active_1');
      expect(details.id, 'active_1');
      expect(details.title, 'FLAT 30% OFF');
      expect(details.createdBy, 'Mall Admin');
      expect(details.termsAndConditions!.length, 4);
      expect(details.conversionRate, 35.0);
    });
  });

  group('LoadOfferDetailsUseCase Tests', () {
    test('LoadOfferDetailsUseCase delegates call to repository', () async {
      final repo = MockOfferRepository();
      final useCase = LoadOfferDetailsUseCase(repo);
      final details = await useCase('active_1');
      expect(details.id, 'active_1');
      expect(details.couponCode, 'NIKE30');
    });
  });

  group('OffersBloc Details State Transitions Tests', () {
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

    test('LoadOfferDetails dispatches state to details loaded', () async {
      final states = <OffersState>[];
      bloc.stream.listen(states.add);

      bloc.add(const LoadOfferDetails('active_1'));
      await Future.delayed(const Duration(milliseconds: 400));

      expect(states[0], const OfferDetailsLoading());
      expect(states[1], isA<OfferDetailsLoaded>());
      final loaded = states[1] as OfferDetailsLoaded;
      expect(loaded.offer.id, 'active_1');
      expect(loaded.offer.title, 'FLAT 30% OFF');
    });
  });

  group('OfferDetailsPage Widget Rendering Tests', () {
    late MockOfferRepository repo;
    late LoadOffersUseCase loadUseCase;
    late SearchOffersUseCase searchUseCase;
    late FilterOffersUseCase filterUseCase;
    late LoadOfferDetailsUseCase loadDetailsUseCase;

    setUp(() {
      repo = MockOfferRepository();
      loadUseCase = LoadOffersUseCase(repo);
      searchUseCase = SearchOffersUseCase(repo);
      filterUseCase = FilterOffersUseCase(repo);
      loadDetailsUseCase = LoadOfferDetailsUseCase(repo);
    });

    testWidgets('OfferDetailsPage renders skeleton loader initially then all details cards', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<OffersBloc>(
            create: (context) => OffersBloc(
              loadOffersUseCase: loadUseCase,
              searchOffersUseCase: searchUseCase,
              filterOffersUseCase: filterUseCase,
              loadOfferDetailsUseCase: loadDetailsUseCase,
            ),
            child: const OfferDetailsPage(offerId: 'active_1'),
          ),
        ),
      );

      // Verify skeleton placeholders are rendered initially
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Wait for Mock repository lookup latency
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(); // rebuild UI

      // Verify core widgets are successfully displayed
      expect(find.text('Offer Details'), findsOneWidget);
      expect(find.byType(OfferBannerCard), findsOneWidget);
      expect(find.byType(CampaignOverviewCard), findsOneWidget);
      expect(find.byType(CampaignValidityCard), findsOneWidget);
      expect(find.byType(StoreInformationCard), findsOneWidget);
      expect(find.byType(CampaignDescriptionCard), findsOneWidget);
      expect(find.byType(CampaignHealthCard), findsOneWidget);
      expect(find.byType(PerformanceCard), findsOneWidget);
      expect(find.byType(TimelineCard), findsOneWidget);
      expect(find.byType(TermsConditionsCard), findsOneWidget);
      expect(find.byType(OfferActionSection), findsOneWidget);

      // Verify specific details are correct
      expect(find.text('FLAT 30% OFF'), findsOneWidget);
      expect(find.text('NIKE30'), findsOneWidget);
    });
  });
}
