import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;

  SettingsBloc({required this.getSettingsUseCase})
      : super(const SettingsInitial()) {
    on<LoadSettingsRequested>(_onLoadSettings);
    on<RefreshSettingsRequested>(_onRefreshSettings);
  }

  Future<void> _onLoadSettings(
    LoadSettingsRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());
    try {
      final settings = await getSettingsUseCase();
      emit(SettingsLoaded(settings: settings));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _onRefreshSettings(
    RefreshSettingsRequested event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final settings = await getSettingsUseCase();
      emit(SettingsLoaded(settings: settings));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
