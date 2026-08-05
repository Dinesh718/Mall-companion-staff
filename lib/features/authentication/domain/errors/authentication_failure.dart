abstract class AuthenticationFailure implements Exception {
  final String message;
  const AuthenticationFailure(this.message);

  @override
  String toString() => message;
}

class InvalidPhoneNumberFailure extends AuthenticationFailure {
  const InvalidPhoneNumberFailure() : super('The phone number entered is invalid.');
}

class InvalidOtpFailure extends AuthenticationFailure {
  const InvalidOtpFailure() : super('The verification code entered is incorrect.');
}

class NetworkFailure extends AuthenticationFailure {
  const NetworkFailure() : super('A network error occurred. Please check your internet connection.');
}

class ServerFailure extends AuthenticationFailure {
  const ServerFailure([super.message = 'An unexpected server error occurred. Please try again.']);
}
