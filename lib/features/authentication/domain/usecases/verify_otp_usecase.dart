import '../entities/staff_profile_entity.dart';
import '../repositories/authentication_repository.dart';

class VerifyOtpUseCase {
  final AuthenticationRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<StaffProfileEntity> call({
    required String phoneNumber,
    required String otp,
  }) async {
    return await repository.verifyOtp(
      phoneNumber: phoneNumber,
      otp: otp,
    );
  }
}
