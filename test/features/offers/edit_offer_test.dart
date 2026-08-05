import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/offers/data/repositories/mock_offer_repository.dart';
import 'package:mall_companion_staff/features/offers/domain/entities/create_offer_form_entity.dart';
import 'package:mall_companion_staff/features/offers/domain/entities/offer_entity.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/create_offer_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/save_offer_draft_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/validate_offer_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/update_offer_usecase.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/create_offer_bloc.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/create_offer_event.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/create_offer_state.dart';
import 'package:mall_companion_staff/features/offers/presentation/pages/edit_offer_page.dart';

void main() {
  late MockOfferRepository mockRepository;
  late CreateOfferUseCase createUseCase;
  late SaveOfferDraftUseCase saveDraftUseCase;
  late ValidateOfferUseCase validateUseCase;
  late UpdateOfferUseCase updateUseCase;

  final testOffer = OfferEntity(
    id: 'test_offer_id',
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
    systemLogs: const [
      {'version': 'Version 1.0', 'description': 'Created by Admin'}
    ],
  );

  setUp(() {
    mockRepository = MockOfferRepository();
    createUseCase = CreateOfferUseCase(mockRepository);
    saveDraftUseCase = SaveOfferDraftUseCase(mockRepository);
    validateUseCase = ValidateOfferUseCase(mockRepository);
    updateUseCase = UpdateOfferUseCase(mockRepository);
  });

  group('CreateOfferFormEntity.fromEntity Mapping Tests', () {
    test('should map all fields correctly from OfferEntity', () {
      final form = CreateOfferFormEntity.fromEntity(testOffer);
      expect(form.title, equals('Original Nike Shoes Sale'));
      expect(form.discountType, equals('Percentage'));
      expect(form.discountValue, equals(20.0));
      expect(form.couponCode, equals('NIKE20'));
      expect(form.category, equals('Footwear'));

      final testOfferFashionFootwear = OfferEntity(
        id: 'test_offer_id_2',
        storeId: 'nike_flagship',
        storeName: 'Nike Flagship',
        storeLogoUrl: 'logo.png',
        title: 'Original Nike Shoes Sale',
        description: 'Running shoes flat 20% discount description',
        bannerUrl: '',
        category: 'Fashion & Footwear',
        discountType: 'percentage',
        discountValue: 20.0,
        couponCode: 'NIKE20',
        status: 'Active',
        startDate: testOffer.startDate,
        endDate: testOffer.endDate,
        views: 0,
        redemptions: 0,
        createdAt: testOffer.createdAt,
        updatedAt: testOffer.updatedAt,
      );
      final form2 = CreateOfferFormEntity.fromEntity(testOfferFashionFootwear);
      expect(form2.category, equals('Fashion & Apparel'));
    });
  });

  group('Edit Offer State Management (BLoC) Tests', () {
    test('InitializeEditOffer yields CreateOfferEditing state prefilled with values', () async {
      final bloc = CreateOfferBloc(
        createOfferUseCase: createUseCase,
        saveOfferDraftUseCase: saveDraftUseCase,
        validateOfferUseCase: validateUseCase,
        updateOfferUseCase: updateUseCase,
      );

      bloc.add(InitializeEditOffer(testOffer));
      await qEvent();

      expect(bloc.state, isA<CreateOfferEditing>());
      final editing = bloc.state as CreateOfferEditing;
      expect(editing.formState.title, equals('Original Nike Shoes Sale'));
      expect(editing.formState.discountValue, equals(20.0));
      bloc.close();
    });

    test('Updating campaign yields CreateOfferUpdated state', () async {
      final bloc = CreateOfferBloc(
        createOfferUseCase: createUseCase,
        saveOfferDraftUseCase: saveDraftUseCase,
        validateOfferUseCase: validateUseCase,
        updateOfferUseCase: updateUseCase,
      );

      bloc.add(InitializeEditOffer(testOffer));
      await qEvent();

      bloc.add(const TitleChanged('Updated Shoes Sale'));
      await qEvent();

      bloc.add(UpdateOfferRequested(originalId: testOffer.id));
      await Future.delayed(const Duration(milliseconds: 1000));

      expect(bloc.state, isA<CreateOfferUpdated>());
      final updated = bloc.state as CreateOfferUpdated;
      expect(updated.offer.title, equals('Updated Shoes Sale'));
      expect(updated.offer.id, equals(testOffer.id));
      bloc.close();
    });
  });

  group('EditOfferPage Widget Rendering Tests', () {
    Widget buildTestableWidget() {
      return MaterialApp(
        home: EditOfferPage(offer: testOffer),
      );
    }

    testWidgets('renders EditOfferPage with summary cards and accordions', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Check header app bar
      expect(find.text('Edit Offer'), findsOneWidget);
      expect(find.text('Update your campaign details'), findsOneWidget);

      // Check campaign summary card values
      expect(find.text('Original Nike Shoes Sale'), findsNWidgets(2));
      expect(find.text('TEST_OFFER_ID'), findsOneWidget);
      expect(find.text('Nike Flagship'), findsOneWidget);

      // Check save indicator chip
      expect(find.text('All Changes Saved'), findsOneWidget);

      // Check form fields accordion headers
      expect(find.text('Basic Information'), findsOneWidget);
      expect(find.text('Campaign History'), findsOneWidget);

      // Check bottom action buttons
      expect(find.text('Discard'), findsOneWidget);
      expect(find.text('Save Draft'), findsOneWidget);
      expect(find.text('Update Campaign'), findsOneWidget);
    });
  });
}

Future<void> qEvent() => Future.delayed(Duration.zero);
