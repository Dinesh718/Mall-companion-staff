import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final LogoutUseCase logoutUseCase;

  AuthenticationBloc({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.logoutUseCase,
  }) : super(const AuthenticationInitial()) {
    on<SendOtpRequested>(_onSendOtpRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onSendOtpRequested(
    SendOtpRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const SendingOtp());
    try {
      await sendOtpUseCase(
        phoneNumber: event.phoneNumber,
        role: event.role,
      );
      emit(OtpSent(
        phoneNumber: event.phoneNumber,
        role: event.role,
      ));
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onVerifyOtpRequested(
    VerifyOtpRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const VerifyingOtp());
    try {
      final user = await verifyOtpUseCase(
        phoneNumber: event.phoneNumber,
        otp: event.otp,
      );
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const VerifyingOtp()); // temporary loading state for transition
    try {
      await logoutUseCase();
      emit(const AuthenticationInitial());
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }
}
