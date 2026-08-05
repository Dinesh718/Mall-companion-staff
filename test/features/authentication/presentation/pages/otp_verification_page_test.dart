import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:mall_companion_staff/features/authentication/domain/usecases/send_otp_usecase.dart';
import 'package:mall_companion_staff/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:mall_companion_staff/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:mall_companion_staff/features/authentication/domain/entities/staff_profile_entity.dart';
import 'package:mall_companion_staff/features/authentication/domain/entities/staff_role.dart';
import 'package:mall_companion_staff/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:mall_companion_staff/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:mall_companion_staff/features/authentication/presentation/widgets/otp_input_row.dart';

class FakeAuthenticationRepository implements AuthenticationRepository {
  @override
  Future<void> sendOtp({required String phoneNumber, required StaffRole role}) async {}

  @override
  Future<StaffProfileEntity> verifyOtp({required String phoneNumber, required String otp}) async {
    return const StaffProfileEntity(
      uid: 'staff_123',
      phoneNumber: '9876543210',
      role: StaffRole.admin,
      isProfileComplete: true,
    );
  }

  @override
  Future<void> logout() async {}

  @override
  Future<StaffProfileEntity?> getCurrentUser() async => null;
}

void main() {
  testWidgets('OtpVerificationPage renders illustrations and input row',
      (WidgetTester tester) async {
    final repository = FakeAuthenticationRepository();
    final bloc = AuthenticationBloc(
      sendOtpUseCase: SendOtpUseCase(repository),
      verifyOtpUseCase: VerifyOtpUseCase(repository),
      logoutUseCase: LogoutUseCase(repository),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: bloc,
          child: const OtpVerificationPage(
            phoneNumber: '9876543210',
            role: 'Admin',
          ),
        ),
      ),
    );

    // Verify Title and Subtitle exist
    expect(find.text('Verify Your Number'), findsOneWidget);
    expect(
      find.textContaining('Enter the 6-digit verification code'),
      findsOneWidget,
    );

    // Verify presence of OtpInputRow
    expect(find.byType(OtpInputRow), findsOneWidget);

    // Verify verify OTP button
    expect(find.text('Verify OTP'), findsOneWidget);

    bloc.close();
  });
}
