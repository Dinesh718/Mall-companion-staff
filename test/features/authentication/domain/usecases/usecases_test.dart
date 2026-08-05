import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/authentication/domain/entities/staff_profile_entity.dart';
import 'package:mall_companion_staff/features/authentication/domain/entities/staff_role.dart';
import 'package:mall_companion_staff/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:mall_companion_staff/features/authentication/domain/usecases/send_otp_usecase.dart';
import 'package:mall_companion_staff/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:mall_companion_staff/features/authentication/domain/usecases/logout_usecase.dart';

class MockAuthenticationRepository implements AuthenticationRepository {
  bool sendOtpCalled = false;
  bool verifyOtpCalled = false;
  bool logoutCalled = false;

  late String lastPhone;
  late StaffRole lastRole;
  late String lastOtp;

  @override
  Future<void> sendOtp({
    required String phoneNumber,
    required StaffRole role,
  }) async {
    sendOtpCalled = true;
    lastPhone = phoneNumber;
    lastRole = role;
  }

  @override
  Future<StaffProfileEntity> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    verifyOtpCalled = true;
    lastPhone = phoneNumber;
    lastOtp = otp;
    return const StaffProfileEntity(
      uid: 'staff_123',
      phoneNumber: '9876543210',
      role: StaffRole.security,
      isProfileComplete: true,
    );
  }

  @override
  Future<void> logout() async {
    logoutCalled = true;
  }

  @override
  Future<StaffProfileEntity?> getCurrentUser() async {
    return null;
  }
}

void main() {
  late MockAuthenticationRepository repository;
  late SendOtpUseCase sendOtpUseCase;
  late VerifyOtpUseCase verifyOtpUseCase;
  late LogoutUseCase logoutUseCase;

  setUp(() {
    repository = MockAuthenticationRepository();
    sendOtpUseCase = SendOtpUseCase(repository);
    verifyOtpUseCase = VerifyOtpUseCase(repository);
    logoutUseCase = LogoutUseCase(repository);
  });

  group('SendOtpUseCase', () {
    test('calls repository.sendOtp with correct parameters', () async {
      await sendOtpUseCase(phoneNumber: '9876543210', role: StaffRole.security);

      expect(repository.sendOtpCalled, isTrue);
      expect(repository.lastPhone, equals('9876543210'));
      expect(repository.lastRole, equals(StaffRole.security));
    });
  });

  group('VerifyOtpUseCase', () {
    test('calls repository.verifyOtp with correct parameters and returns user', () async {
      final user = await verifyOtpUseCase(phoneNumber: '9876543210', otp: '123456');

      expect(repository.verifyOtpCalled, isTrue);
      expect(repository.lastPhone, equals('9876543210'));
      expect(repository.lastOtp, equals('123456'));
      expect(user.uid, equals('staff_123'));
    });
  });

  group('LogoutUseCase', () {
    test('calls repository.logout', () async {
      await logoutUseCase();

      expect(repository.logoutCalled, isTrue);
    });
  });
}
