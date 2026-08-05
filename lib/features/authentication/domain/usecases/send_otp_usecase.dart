import '../entities/staff_role.dart';
import '../repositories/authentication_repository.dart';

class SendOtpUseCase {
  final AuthenticationRepository repository;

  SendOtpUseCase(this.repository);

  Future<void> call({
    required String phoneNumber,
    required StaffRole role,
  }) async {
    await repository.sendOtp(
      phoneNumber: phoneNumber,
      role: role,
    );
  }
}
