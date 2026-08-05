import '../entities/store_entity.dart';

abstract class StoreProfileRepository {
  Future<StoreEntity> getStoreProfile();
}
