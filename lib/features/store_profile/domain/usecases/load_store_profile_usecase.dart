import '../entities/store_entity.dart';
import '../repositories/store_profile_repository.dart';

class LoadStoreProfileUseCase {
  final StoreProfileRepository repository;

  LoadStoreProfileUseCase(this.repository);

  Future<StoreEntity> call() async {
    return await repository.getStoreProfile();
  }
}
