import '../../domain/entities/staff_profile_entity.dart';
import '../../domain/entities/staff_role.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../domain/errors/authentication_failure.dart';
import '../models/staff_profile_model.dart';

class AuthRepositoryImpl implements AuthenticationRepository {
  static StaffProfileModel? _currentUser;

  @override
  Future<void> sendOtp({
    required String phoneNumber,
    required StaffRole role,
  }) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));

    // Verify if this phone number matches the chosen staff role
    final expectedRole = _getRoleForPhone(phoneNumber);
    if (expectedRole != role) {
      throw ServerFailure('This mobile number is not registered for the selected role.');
    }
  }

  @override
  Future<StaffProfileEntity> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));

    if (otp != '123456') {
      throw const InvalidOtpFailure();
    }

    final role = _getRoleForPhone(phoneNumber);
    final name = _getNameForRole(role);
    final email = _getEmailForRole(role, phoneNumber);

    final isNewUser = phoneNumber == '9876543214';

    _currentUser = StaffProfileModel(
      uid: 'staff_$phoneNumber',
      phoneNumber: phoneNumber,
      name: isNewUser ? null : name,
      email: isNewUser ? null : email,
      role: role,
      isProfileComplete: !isNewUser,
    );

    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  @override
  Future<StaffProfileEntity?> getCurrentUser() async {
    return _currentUser;
  }

  static StaffRole _getRoleForPhone(String phoneNumber) {
    switch (phoneNumber) {
      case '9876543210':
        return StaffRole.security;
      case '9876543211':
        return StaffRole.admin;
      case '9876543212':
      case '9876543214':
        return StaffRole.maintenance;
      case '9876543213':
        return StaffRole.storeManager;
      default:
        throw const InvalidPhoneNumberFailure();
    }
  }

  static String _getNameForRole(StaffRole role) {
    switch (role) {
      case StaffRole.admin:
        return 'Mall Admin';
      case StaffRole.security:
        return 'Security Staff';
      case StaffRole.maintenance:
        return 'Maintenance Staff';
      case StaffRole.storeManager:
        return 'Store Manager';
    }
  }

  static String _getEmailForRole(StaffRole role, String phone) {
    final prefix = _getNameForRole(role).toLowerCase().replaceAll(' ', '.');
    return '$prefix@mallcompanion.com';
  }
}
