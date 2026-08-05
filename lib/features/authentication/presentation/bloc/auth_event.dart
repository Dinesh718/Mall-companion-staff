import 'package:flutter/foundation.dart';
import '../../domain/entities/staff_role.dart';

@immutable
sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class SendOtpRequested extends AuthenticationEvent {
  final String phoneNumber;
  final StaffRole role;

  const SendOtpRequested({
    required this.phoneNumber,
    required this.role,
  });
}

class VerifyOtpRequested extends AuthenticationEvent {
  final String phoneNumber;
  final String otp;

  const VerifyOtpRequested({
    required this.phoneNumber,
    required this.otp,
  });
}

class LogoutRequested extends AuthenticationEvent {
  const LogoutRequested();
}
