import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/load_store_profile_usecase.dart';
import 'store_profile_event.dart';
import 'store_profile_state.dart';

class StoreProfileBloc extends Bloc<StoreProfileEvent, StoreProfileState> {
  final LoadStoreProfileUseCase loadStoreProfileUseCase;

  StoreProfileBloc({
    required this.loadStoreProfileUseCase,
  }) : super(const StoreProfileInitial()) {
    on<LoadStoreProfile>(_onLoadStoreProfile);
    on<RefreshStoreProfile>(_onRefreshStoreProfile);
  }

  Future<void> _onLoadStoreProfile(
    LoadStoreProfile event,
    Emitter<StoreProfileState> emit,
  ) async {
    emit(const StoreProfileLoading());
    try {
      final store = await loadStoreProfileUseCase();
      emit(StoreProfileLoaded(store));
    } catch (e) {
      emit(StoreProfileError(e.toString()));
    }
  }

  Future<void> _onRefreshStoreProfile(
    RefreshStoreProfile event,
    Emitter<StoreProfileState> emit,
  ) async {
    emit(const StoreProfileLoading());
    try {
      final store = await loadStoreProfileUseCase();
      emit(StoreProfileLoaded(store));
    } catch (e) {
      emit(StoreProfileError(e.toString()));
    }
  }
}
