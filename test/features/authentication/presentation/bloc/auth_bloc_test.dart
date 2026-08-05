import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/authentication/domain/entities/staff_profile_entity.dart';
import 'package:mall_companion_staff/features/authentication/domain/entities/staff_role.dart';
import 'package:mall_companion_staff/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:mall_companion_staff/features/authentication/domain/usecases/send_otp_usecase.dart';
import 'package:mall_companion_staff/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:mall_companion_staff/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:mall_companion_staff/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:mall_companion_staff/features/authentication/presentation/bloc/auth_event.dart';
import 'package:mall_companion_staff/features/authentication/presentation/bloc/auth_state.dart';

class MockAuthenticationRepository implements AuthenticationRepository {
  bool shouldFail = false;

  @override
  Future<void> sendOtp({
    required String phoneNumber,
    required StaffRole role,
  }) async {
    if (shouldFail) throw Exception('Failed to send OTP');
  }

  @override
  Future<StaffProfileEntity> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    if (shouldFail || otp != '123456') throw Exception('Invalid OTP');
    return const StaffProfileEntity(
      uid: 'staff_123',
      phoneNumber: '9876543210',
      role: StaffRole.security,
      isProfileComplete: true,
      name: 'Security Guard',
    );
  }

  @override
  Future<void> logout() async {
    if (shouldFail) throw Exception('Logout failed');
  }

  @override
  Future<StaffProfileEntity?> getCurrentUser() async {
    return null;
  }
}

void main() {
  late MockAuthenticationRepository mockRepository;
  late SendOtpUseCase sendOtpUseCase;
  late VerifyOtpUseCase verifyOtpUseCase;
  late LogoutUseCase logoutUseCase;
  late AuthenticationBloc bloc;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    sendOtpUseCase = SendOtpUseCase(mockRepository);
    verifyOtpUseCase = VerifyOtpUseCase(mockRepository);
    logoutUseCase = LogoutUseCase(mockRepository);
    bloc = AuthenticationBloc(
      sendOtpUseCase: sendOtpUseCase,
      verifyOtpUseCase: verifyOtpUseCase,
      logoutUseCase: logoutUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is AuthenticationInitial', () {
    expect(bloc.state, isA<AuthenticationInitial>());
  });

  group('SendOtpRequested', () {
    test('emits [SendingOtp, OtpSent] on success', () async {
      final expectedStates = [
        isA<SendingOtp>(),
        isA<OtpSent>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const SendOtpRequested(
        phoneNumber: '9876543210',
        role: StaffRole.security,
      ));
    });

    test('emits [SendingOtp, AuthenticationFailure] on failure', () async {
      mockRepository.shouldFail = true;
      final expectedStates = [
        isA<SendingOtp>(),
        isA<AuthenticationFailure>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const SendOtpRequested(
        phoneNumber: '9876543210',
        role: StaffRole.security,
      ));
    });
  });

  group('VerifyOtpRequested', () {
    test('emits [VerifyingOtp, Authenticated] on success', () async {
      final expectedStates = [
        isA<VerifyingOtp>(),
        isA<Authenticated>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const VerifyOtpRequested(
        phoneNumber: '9876543210',
        otp: '123456',
      ));
    });

    test('emits [VerifyingOtp, AuthenticationFailure] on failure', () async {
      mockRepository.shouldFail = true;
      final expectedStates = [
        isA<VerifyingOtp>(),
        isA<AuthenticationFailure>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const VerifyOtpRequested(
        phoneNumber: '9876543210',
        otp: '123456',
      ));
    });
  });

  group('LogoutRequested', () {
    test('emits [VerifyingOtp, AuthenticationInitial] on success', () async {
      final expectedStates = [
        isA<VerifyingOtp>(),
        isA<AuthenticationInitial>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const LogoutRequested());
    });
  });
}
