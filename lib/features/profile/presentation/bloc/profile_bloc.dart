import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc({required this.getProfileUseCase}) : super(const ProfileInitial()) {
    on<LoadProfileRequested>(_onLoadProfileRequested);
    on<RefreshProfileRequested>(_onRefreshProfileRequested);
  }

  Future<void> _onLoadProfileRequested(
    LoadProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final profile = await getProfileUseCase();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onRefreshProfileRequested(
    RefreshProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    // Optionally preserve the old state while loading if we want silent refresh
    try {
      final profile = await getProfileUseCase();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
