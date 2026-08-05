import '../repositories/authentication_repository.dart';

class LogoutUseCase {
  final AuthenticationRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() async {
    await repository.logout();
  }
}
