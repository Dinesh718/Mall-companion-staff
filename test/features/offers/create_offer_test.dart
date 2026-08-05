import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/offers/data/repositories/mock_offer_repository.dart';
import 'package:mall_companion_staff/features/offers/domain/entities/create_offer_form_entity.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/create_offer_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/save_offer_draft_usecase.dart';
import 'package:mall_companion_staff/features/offers/domain/usecases/validate_offer_usecase.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/create_offer_bloc.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/create_offer_event.dart';
import 'package:mall_companion_staff/features/offers/presentation/bloc/create_offer_state.dart';
import 'package:mall_companion_staff/features/offers/presentation/pages/create_offer_page.dart';

void main() {
  late MockOfferRepository mockRepository;
  late CreateOfferUseCase createUseCase;
  late SaveOfferDraftUseCase saveDraftUseCase;
  late ValidateOfferUseCase validateUseCase;

  setUp(() {
    mockRepository = MockOfferRepository();
    createUseCase = CreateOfferUseCase(mockRepository);
    saveDraftUseCase = SaveOfferDraftUseCase(mockRepository);
    validateUseCase = ValidateOfferUseCase(mockRepository);
  });

  group('ValidateOfferUseCase Tests', () {
    test('should report errors for empty fields', () async {
      const form = CreateOfferFormEntity(
        title: '',
        discountValue: 0.0,
      );

      final validated = await validateUseCase(form);
      expect(validated.isValid, isFalse);
      expect(validated.validationErrors['title'], isNotNull);
      expect(validated.validationErrors['discountValue'], isNotNull);
    });

    test('should pass validation for correctly filled fields', () async {
      final form = CreateOfferFormEntity(
        title: 'Valid Summer Offer',
        category: 'Fashion & Apparel',
        discountType: 'Percentage',
        discountValue: 30.0,
        couponCode: 'SUMMER30',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
      );

      final validated = await validateUseCase(form);
      expect(validated.isValid, isTrue);
    });

    test('should report error for end date before start date', () async {
      final form = CreateOfferFormEntity(
        title: 'Invalid Date Offer',
        category: 'Fashion & Apparel',
        discountType: 'Percentage',
        discountValue: 20.0,
        couponCode: 'SAVE20',
        startDate: DateTime.now().add(const Duration(days: 2)),
        endDate: DateTime.now(),
      );

      final validated = await validateUseCase(form);
      expect(validated.validationErrors['endDate'], isNotNull);
    });
  });

  group('CreateOfferBloc Tests', () {
    test('initial state is CreateOfferInitial', () {
      final bloc = CreateOfferBloc(
        createOfferUseCase: createUseCase,
        saveOfferDraftUseCase: saveDraftUseCase,
        validateOfferUseCase: validateUseCase,
      );
      expect(bloc.state, const CreateOfferInitial());
      bloc.close();
    });

    test('InitializeCreateOffer yields CreateOfferEditing with initial form values', () async {
      final bloc = CreateOfferBloc(
        createOfferUseCase: createUseCase,
        saveOfferDraftUseCase: saveDraftUseCase,
        validateOfferUseCase: validateUseCase,
      );

      bloc.add(const InitializeCreateOffer());
      await qEvent();

      expect(bloc.state, isA<CreateOfferEditing>());
      final editingState = bloc.state as CreateOfferEditing;
      expect(editingState.formState.termsAndConditions, isNotEmpty);
      bloc.close();
    });

    test('TitleChanged updates form state title', () async {
      final bloc = CreateOfferBloc(
        createOfferUseCase: createUseCase,
        saveOfferDraftUseCase: saveDraftUseCase,
        validateOfferUseCase: validateUseCase,
      );

      bloc.add(const InitializeCreateOffer());
      await qEvent();

      bloc.add(const TitleChanged('Brand New Nike Shoes'));
      await qEvent();

      expect(bloc.state, isA<CreateOfferEditing>());
      final editingState = bloc.state as CreateOfferEditing;
      expect(editingState.formState.title, equals('Brand New Nike Shoes'));
      bloc.close();
    });

    test('Publishing a valid form yields Published state', () async {
      final bloc = CreateOfferBloc(
        createOfferUseCase: createUseCase,
        saveOfferDraftUseCase: saveDraftUseCase,
        validateOfferUseCase: validateUseCase,
      );

      bloc.add(const InitializeCreateOffer());
      await qEvent();

      bloc.add(const TitleChanged('Valid Campaign'));
      await qEvent();
      bloc.add(const DiscountValueChanged(25.0));
      await qEvent();
      bloc.add(const CouponCodeChanged('VALID25'));
      await qEvent();

      bloc.add(const PublishOfferRequested());
      // Wait for validation delay + repository mock delay
      await Future.delayed(const Duration(milliseconds: 1000));

      expect(bloc.state, isA<CreateOfferPublished>());
      final publishedState = bloc.state as CreateOfferPublished;
      expect(publishedState.offer.title, equals('Valid Campaign'));
      expect(publishedState.offer.status, equals('Active'));
      bloc.close();
    });
  });

  group('CreateOfferPage Widget Tests', () {
    Widget buildTestableWidget() {
      return MaterialApp(
        home: const CreateOfferPage(),
      );
    }

    testWidgets('renders CreateOfferPage with form elements', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Check for Header sections
      expect(find.text('Create Offer'), findsOneWidget);
      expect(find.text('Campaign Setup Progress'), findsOneWidget);

      // Check for form sections
      expect(find.text('Basic Information'), findsOneWidget);
      expect(find.text('Discount Details'), findsOneWidget);
      expect(find.text('Campaign Schedule'), findsOneWidget);
      expect(find.text('Eligible Customers'), findsOneWidget);
      expect(find.text('Applicable Categories'), findsOneWidget);
      expect(find.text('Campaign Banner'), findsOneWidget);

      // Check for Action buttons
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save Draft'), findsOneWidget);
      expect(find.text('Publish Offer'), findsOneWidget);
    });
  });
}

// Micro helper to wait for sync bloc event loops
Future<void> qEvent() => Future.delayed(Duration.zero);
