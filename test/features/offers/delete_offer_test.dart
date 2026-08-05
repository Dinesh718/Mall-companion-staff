import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/offers/data/repositories/mock_offer_repository.dart';
import 'package:mall_companion_staff/features/offers/domain/entities/offer_entity.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/load_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/search_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/filter_offers_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/load_offer_details_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/delete_offer_usecase.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_event.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/offers_state.dart';
import 'package:mall_companion_staff/features/offers/presentation/widgets/destructive_confirmation_dialog.dart';

void main() {
  late MockOfferRepository repository;
  late LoadOffersUseCase loadUseCase;
  late SearchOffersUseCase searchUseCase;
  late FilterOffersUseCase filterUseCase;
  late LoadOfferDetailsUseCase loadDetailsUseCase;
  late DeleteOfferUseCase deleteUseCase;
  late OffersBloc bloc;

  final testOffer = OfferEntity(
    id: 'test_delete_id',
    storeId: 'nike_flagship',
    storeName: 'Nike Flagship',
    storeLogoUrl: 'logo.png',
    title: 'Original Nike Shoes Sale',
    description: 'Running shoes flat 20% discount description',
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

  setUp(() {
    repository = MockOfferRepository();
    loadUseCase = LoadOffersUseCase(repository);
    searchUseCase = SearchOffersUseCase(repository);
    filterUseCase = FilterOffersUseCase(repository);
    loadDetailsUseCase = LoadOfferDetailsUseCase(repository);
    deleteUseCase = DeleteOfferUseCase(repository);
    bloc = OffersBloc(
      loadOffersUseCase: loadUseCase,
      searchOffersUseCase: searchUseCase,
      filterOffersUseCase: filterUseCase,
      loadOfferDetailsUseCase: loadDetailsUseCase,
      deleteOfferUseCase: deleteUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('DeleteOfferUseCase and Mock Repository Tests', () {
    test('MockOfferRepository removes offer from memory and throws when not found', () async {
      // Setup: Add offer
      await repository.createOffer(testOffer);

      // Verify deletion works
      await deleteUseCase(testOffer.id);

      // Verify it throws when trying to delete again
      expect(
        () async => await deleteUseCase(testOffer.id),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('OffersBloc Delete Campaign State Flow Tests', () {
    test('DeleteOfferRequested emits state sequence [OffersDeleting, OffersDeleteSuccess]', () async {
      final states = <OffersState>[];
      bloc.stream.listen(states.add);

      bloc.add(const DeleteOfferRequested('active_1'));
      await bloc.stream.firstWhere((s) => s is OffersDeleteSuccess);

      expect(states[0], const OffersDeleting());
      expect(states[1], const OffersDeleteSuccess());
    });
  });

  group('DestructiveConfirmationDialog Widget Rendering Tests', () {
    Widget buildTestableWidget(Widget child) {
      return MaterialApp(
        home: Scaffold(
          body: child,
        ),
      );
    }

    testWidgets('renders DestructiveConfirmationDialog correctly with buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DestructiveConfirmationDialog(
            offerId: 'active_1',
            offersBloc: bloc,
          ),
        ),
      );

      // Verify Title and Content text
      expect(find.text('Delete Campaign?'), findsOneWidget);
      expect(
        find.text('Are you sure you want to delete this campaign? This action cannot be undone.'),
        findsOneWidget,
      );

      // Verify Cancel and Delete button labels
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('renders loading indicator in DestructiveConfirmationDialog when deleting', (WidgetTester tester) async {
      // Emit deleting state
      bloc.emit(const OffersDeleting());

      await tester.pumpWidget(
        buildTestableWidget(
          DestructiveConfirmationDialog(
            offerId: 'active_1',
            offersBloc: bloc,
          ),
        ),
      );

      // Verify progress indicator is rendered
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Verify Delete text label is replaced/hidden
      expect(find.text('Delete'), findsNothing);
    });
  });
}
