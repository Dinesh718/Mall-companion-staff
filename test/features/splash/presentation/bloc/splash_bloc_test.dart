import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:mall_companion_staff/features/splash/presentation/bloc/splash_event.dart';
import 'package:mall_companion_staff/features/splash/presentation/bloc/splash_state.dart';

void main() {
  late SplashBloc splashBloc;

  setUp(() {
    splashBloc = SplashBloc();
  });

  tearDown(() {
    splashBloc.close();
  });

  test('initial state is correct', () {
    expect(splashBloc.state, SplashState.initial());
  });

  test('SplashInitEvent transitions status correctly to completed', () async {
    // Setup expectation stream
    final expectedStates = [
      const SplashState(status: SplashStatus.initializing),
      const SplashState(status: SplashStatus.loadingDependencies),
      const SplashState(status: SplashStatus.checkingAuth),
      const SplashState(status: SplashStatus.completed),
    ];

    expectLater(
      splashBloc.stream,
      emitsInOrder(expectedStates),
    );

    splashBloc.add(const SplashInitEvent());
  });
}
