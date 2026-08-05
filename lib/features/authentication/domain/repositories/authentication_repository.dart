import '../entities/staff_profile_entity.dart';
import '../entities/staff_role.dart';

abstract class AuthenticationRepository {
  Future<void> sendOtp({
    required String phoneNumber,
    required StaffRole role,
  });

  Future<StaffProfileEntity> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  Future<StaffProfileEntity?> getCurrentUser();

  Future<void> logout();
}
