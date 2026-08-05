import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_companion_staff/features/offers/data/repositories/mock_offer_repository.dart';
import 'package:mall_companion_staff/features/offers/domain/entities/offer_entity.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/load_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/search_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/filter_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/load_offer_details_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/update_offer_status_usecase.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_event.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_state.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/offer_action_section.dart';

void main() {
  late MockOfferRepository repository;
  late LoadOffersUseCase loadUseCase;
  late SearchOffersUseCase searchUseCase;
  late FilterOffersUseCase filterUseCase;
  late LoadOfferDetailsUseCase loadDetailsUseCase;
  late UpdateOfferStatusUseCase updateStatusUseCase;
  late OffersBloc bloc;

  final activeOffer = OfferEntity(
    id: 'test_active_status_id',
    storeId: 'nike_flagship',
    storeName: 'Nike Flagship',
    storeLogoUrl: 'logo.png',
    title: 'Nike Shoes Sale',
    description: 'Flat 20% discount',
    bannerUrl: '',
    category: 'Footwear',
    discountType: 'percentage',
    discountValue: 20.0,
    couponCode: 'NIKE20',
    status: 'Active',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 10)),
    views: 120,
    redemptions: 34,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final pausedOffer = OfferEntity(
    id: 'test_paused_status_id',
    storeId: 'nike_flagship',
    storeName: 'Nike Flagship',
    storeLogoUrl: 'logo.png',
    title: 'Nike Shoes Sale',
    description: 'Flat 20% discount',
    bannerUrl: '',
    category: 'Footwear',
    discountType: 'percentage',
    discountValue: 20.0,
    couponCode: 'NIKE20',
    status: 'Paused',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 10)),
    views: 120,
    redemptions: 34,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUp(() {
    repository = MockOfferRepository();
    loadUseCase = LoadOffersUseCase(repository);
    searchUseCase = SearchOffersUseCase(repository);
    filterUseCase = FilterOffersUseCase(repository);
    loadDetailsUseCase = LoadOfferDetailsUseCase(repository);
    updateStatusUseCase = UpdateOfferStatusUseCase(repository);
    bloc = OffersBloc(
      loadOffersUseCase: loadUseCase,
      searchOffersUseCase: searchUseCase,
      filterOffersUseCase: filterUseCase,
      loadOfferDetailsUseCase: loadDetailsUseCase,
      updateOfferStatusUseCase: updateStatusUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('UpdateOfferStatusUseCase and Mock Repository Tests', () {
    test('MockOfferRepository updates status and throws when not found', () async {
      await repository.createOffer(activeOffer);

      final updated = await updateStatusUseCase(activeOffer.id, 'Paused');
      expect(updated.status, 'Paused');

      expect(
        () async => await updateStatusUseCase('invalid_id', 'Active'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('OffersBloc Status Toggle State Flow Tests', () {
    test('UpdateOfferStatusRequested emits sequence [OffersStatusUpdateInProgress, OfferDetailsLoaded]', () async {
      await repository.createOffer(activeOffer);
      final states = <OffersState>[];
      bloc.stream.listen(states.add);

      bloc.add(UpdateOfferStatusRequested(activeOffer.id, 'Paused'));
      await bloc.stream.firstWhere((s) => s is OfferDetailsLoaded);

      expect(states[0], const OffersStatusUpdateInProgress());
      expect(states[1], isA<OfferDetailsLoaded>());
      expect((states[1] as OfferDetailsLoaded).offer.status, 'Paused');
    });
  });

  group('OfferActionSection Toggling Widget Rendering Tests', () {
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

    testWidgets('renders Pause Campaign button when status is Active', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          OfferActionSection(offer: activeOffer),
        ),
      );

      expect(find.text('Pause'), findsOneWidget);
      expect(find.byIcon(Icons.pause_circle_outline_rounded), findsOneWidget);
    });

    testWidgets('renders Activate Campaign button when status is Paused', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          OfferActionSection(offer: pausedOffer),
        ),
      );

      expect(find.text('Activate'), findsOneWidget);
      expect(find.byIcon(Icons.play_circle_outline_rounded), findsOneWidget);
    });

    testWidgets('renders CircularProgressIndicator when status update is in progress', (WidgetTester tester) async {
      bloc.emit(const OffersStatusUpdateInProgress());

      await tester.pumpWidget(
        buildTestableWidget(
          OfferActionSection(offer: activeOffer),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Pause'), findsNothing);
    });
  });
}
