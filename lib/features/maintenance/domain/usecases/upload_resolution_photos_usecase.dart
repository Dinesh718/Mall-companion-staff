import '../repositories/maintenance_repository.dart';

class UploadResolutionPhotosUseCase {
  final MaintenanceRepository repository;

  UploadResolutionPhotosUseCase({required this.repository});

  Future<void> call(String id, List<String> photoPaths) async {
    return repository.uploadResolutionPhotos(id, photoPaths);
  }
}
