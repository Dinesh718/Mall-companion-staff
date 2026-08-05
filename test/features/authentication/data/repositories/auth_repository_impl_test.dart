import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:mall_companion_staff/features/authentication/domain/entities/staff_role.dart';
import 'package:mall_companion_staff/features/authentication/domain/errors/authentication_failure.dart';

void main() {
  late AuthRepositoryImpl repository;

  setUp(() {
    repository = AuthRepositoryImpl();
  });

  group('AuthRepositoryImpl - sendOtp', () {
    test('succeeds for matching role and phone', () async {
      expect(
        repository.sendOtp(phoneNumber: '9876543210', role: StaffRole.security),
        completes,
      );
    });

    test('throws ServerFailure for mismatched role and phone', () async {
      expect(
        () => repository.sendOtp(phoneNumber: '9876543210', role: StaffRole.admin),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('throws InvalidPhoneNumberFailure for unregistered phone', () async {
      expect(
        () => repository.sendOtp(phoneNumber: '9999999999', role: StaffRole.admin),
        throwsA(isA<InvalidPhoneNumberFailure>()),
      );
    });
  });

  group('AuthRepositoryImpl - verifyOtp', () {
    test('succeeds with correct OTP 123456', () async {
      final user = await repository.verifyOtp(
        phoneNumber: '9876543211',
        otp: '123456',
      );

      expect(user.uid, equals('staff_9876543211'));
      expect(user.role, equals(StaffRole.admin));
      expect(user.name, equals('Mall Admin'));
      expect(user.email, equals('mall.admin@mallcompanion.com'));
      expect(user.isProfileComplete, isTrue);

      // Verify cached user matches
      final cached = await repository.getCurrentUser();
      expect(cached, isNotNull);
      expect(cached!.uid, equals('staff_9876543211'));
    });

    test('succeeds for new user 9876543214 with incomplete profile', () async {
      final user = await repository.verifyOtp(
        phoneNumber: '9876543214',
        otp: '123456',
      );

      expect(user.uid, equals('staff_9876543214'));
      expect(user.role, equals(StaffRole.maintenance));
      expect(user.name, isNull);
      expect(user.email, isNull);
      expect(user.isProfileComplete, isFalse);
    });

    test('throws InvalidOtpFailure for incorrect OTP', () async {
      expect(
        () => repository.verifyOtp(phoneNumber: '9876543211', otp: '111111'),
        throwsA(isA<InvalidOtpFailure>()),
      );
    });
  });

  group('AuthRepositoryImpl - logout', () {
    test('clears current user session', () async {
      await repository.verifyOtp(phoneNumber: '9876543212', otp: '123456');
      expect(await repository.getCurrentUser(), isNotNull);

      await repository.logout();
      expect(await repository.getCurrentUser(), isNull);
    });
  });
}
