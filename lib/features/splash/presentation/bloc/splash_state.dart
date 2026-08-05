import 'package:equatable/equatable.dart';

enum SplashStatus {
  initial,
  initializing,
  loadingDependencies,
  checkingAuth,
  completed,
  failure,
}

class SplashState extends Equatable {
  final SplashStatus status;
  final String? errorMessage;

  const SplashState({
    required this.status,
    this.errorMessage,
  });

  factory SplashState.initial() {
    return const SplashState(
      status: SplashStatus.initial,
    );
  }

  SplashState copyWith({
    SplashStatus? status,
    String? errorMessage,
  }) {
    return SplashState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
