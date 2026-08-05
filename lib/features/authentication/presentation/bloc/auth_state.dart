import 'package:flutter/foundation.dart';
import '../../domain/entities/staff_profile_entity.dart';
import '../../domain/entities/staff_role.dart';

@immutable
sealed class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class SendingOtp extends AuthenticationState {
  const SendingOtp();
}

class OtpSent extends AuthenticationState {
  final String phoneNumber;
  final StaffRole role;

  const OtpSent({
    required this.phoneNumber,
    required this.role,
  });
}

class VerifyingOtp extends AuthenticationState {
  const VerifyingOtp();
}

class Authenticated extends AuthenticationState {
  final StaffProfileEntity user;

  const Authenticated(this.user);
}

class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;

  const AuthenticationFailure(this.errorMessage);
}
