import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.initial()) {
    on<SplashInitEvent>(_onSplashInit);
  }

  Future<void> _onSplashInit(
    SplashInitEvent event,
    Emitter<SplashState> emit,
  ) async {
    // 1. Initializing state
    emit(state.copyWith(status: SplashStatus.initializing));
    await Future.delayed(const Duration(milliseconds: 1000));

    // 2. Loading dependencies (future Firebase, secure storage, etc.)
    emit(state.copyWith(status: SplashStatus.loadingDependencies));
    await Future.delayed(const Duration(milliseconds: 1000));

    // 3. Checking Authentication placeholder
    emit(state.copyWith(status: SplashStatus.checkingAuth));
    await Future.delayed(const Duration(milliseconds: 1000));

    // 4. Initialization completed
    emit(state.copyWith(status: SplashStatus.completed));
  }
}
