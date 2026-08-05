import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/store_profile/domain/entities/store_entity.dart';
import 'package:mall_companion_staff/features/store_profile/domain/repositories/store_profile_repository.dart';
import 'package:mall_companion_staff/features/store_profile/domain/usecases/load_store_profile_usecase.dart';
import 'package:mall_companion_staff/features/store_profile/data/models/store_model.dart';
import 'package:mall_companion_staff/features/store_profile/data/repositories/mock_store_profile_repository.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/bloc/store_profile_bloc.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/bloc/store_profile_event.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/bloc/store_profile_state.dart';

class FakeStoreProfileRepository implements StoreProfileRepository {
  bool getProfileCalled = false;

  @override
  Future<StoreEntity> getStoreProfile() async {
    getProfileCalled = true;
    return const StoreModel(
      id: 'nike_flagship',
      name: 'Nike Flagship Store',
      brandName: 'Nike',
      category: 'Fashion & Sports',
      rating: 4.8,
      reviewsCount: 174,
      isOpen: true,
      floor: 'Level 1',
      unitNumber: 'Unit F-104',
      openingTime: '10:00 AM',
      closingTime: '10:00 PM',
      managerName: 'John David',
      wing: 'North Wing',
      visitorsCount: '1.2k',
      activeOffersCount: 5,
      reservationsCount: 12,
      mallName: 'Elite Plaza Mall',
      nearestGate: 'North Gate',
      accessPoint: 'Lift Lobby B',
      walkingTime: '2 mins from Escalator 4',
      mapImageUrl: 'https://map-url',
      crowdLevel: 'MEDIUM',
      currentQueueTime: '~4 MINS',
      serviceElevatorsStatus: 'ACTIVE',
      amenities: ['WiFi', 'Digital Pay'],
      phoneNumber: '+1 (555) 012-3456',
      email: 'flagship@nike-elite.com',
      website: 'nike-eliteplaza.com',
      instagramUrl: 'https://instagram.com/nike',
      facebookUrl: 'https://facebook.com/nike',
      twitterUrl: 'https://twitter.com/nike',
      weeklyHours: {},
      galleryUrls: [],
      logoUrl: 'https://logo-url',
      bannerUrl: 'https://banner-url',
      lastUpdated: 'Today, 09:42 AM',
    );
  }
}

void main() {
  group('StoreModel JSON mapping', () {
    test('fromJson and toJson map fields correctly', () {
      final json = {
        'id': 'nike_flagship',
        'name': 'Nike Flagship Store',
        'brandName': 'Nike',
        'category': 'Fashion & Sports',
        'rating': 4.8,
        'reviewsCount': 174,
        'isOpen': true,
        'floor': 'Level 1',
        'unitNumber': 'Unit F-104',
        'openingTime': '10:00 AM',
        'closingTime': '10:00 PM',
        'managerName': 'John David',
        'wing': 'North Wing',
        'visitorsCount': '1.2k',
        'activeOffersCount': 5,
        'reservationsCount': 12,
        'mallName': 'Elite Plaza Mall',
        'nearestGate': 'North Gate',
        'accessPoint': 'Lift Lobby B',
        'walkingTime': '2 mins from Escalator 4',
        'mapImageUrl': 'https://map-url',
        'crowdLevel': 'MEDIUM',
        'currentQueueTime': '~4 MINS',
        'serviceElevatorsStatus': 'ACTIVE',
        'amenities': ['WiFi', 'Digital Pay'],
        'phoneNumber': '+1 (555) 012-3456',
        'email': 'flagship@nike-elite.com',
        'website': 'nike-eliteplaza.com',
        'instagramUrl': 'https://instagram.com/nike',
        'facebookUrl': 'https://facebook.com/nike',
        'twitterUrl': 'https://twitter.com/nike',
        'weeklyHours': {'Monday': '10:00 AM – 10:00 PM'},
        'galleryUrls': ['url1', 'url2'],
        'logoUrl': 'https://logo-url',
        'bannerUrl': 'https://banner-url',
        'lastUpdated': 'Today, 09:42 AM',
      };

      final model = StoreModel.fromJson(json);
      expect(model.name, equals('Nike Flagship Store'));
      expect(model.rating, equals(4.8));
      expect(model.reviewsCount, equals(174));
      expect(model.weeklyHours['Monday'], equals('10:00 AM – 10:00 PM'));

      final mappedJson = model.toJson();
      expect(mappedJson['name'], equals('Nike Flagship Store'));
      expect(mappedJson['rating'], equals(4.8));
    });
  });

  group('MockStoreProfileRepository', () {
    test('getStoreProfile returns store data with latency', () async {
      final repository = MockStoreProfileRepository();
      final store = await repository.getStoreProfile();

      expect(store.id, equals('nike_flagship'));
      expect(store.name, equals('Nike Flagship Store'));
      expect(store.isOpen, isTrue);
      expect(store.galleryUrls, hasLength(3));
    });
  });

  group('LoadStoreProfileUseCase', () {
    test('delegates profile request to repository', () async {
      final repository = FakeStoreProfileRepository();
      final useCase = LoadStoreProfileUseCase(repository);

      final store = await useCase();
      expect(repository.getProfileCalled, isTrue);
      expect(store.name, equals('Nike Flagship Store'));
    });
  });

  group('StoreProfileBloc', () {
    test('initial state is StoreProfileInitial', () {
      final repository = FakeStoreProfileRepository();
      final bloc = StoreProfileBloc(
        loadStoreProfileUseCase: LoadStoreProfileUseCase(repository),
      );

      expect(bloc.state, isA<StoreProfileInitial>());
      bloc.close();
    });

    test('LoadStoreProfile emits [StoreProfileLoading, StoreProfileLoaded] on success', () async {
      final repository = FakeStoreProfileRepository();
      final bloc = StoreProfileBloc(
        loadStoreProfileUseCase: LoadStoreProfileUseCase(repository),
      );

      final states = <StoreProfileState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(const LoadStoreProfile());

      // Let bloc execute async operations
      await Future.delayed(Duration.zero);

      expect(states, [
        isA<StoreProfileLoading>(),
        isA<StoreProfileLoaded>(),
      ]);

      final loadedState = states[1] as StoreProfileLoaded;
      expect(loadedState.store.name, equals('Nike Flagship Store'));

      await subscription.cancel();
      bloc.close();
    });
  });
}
