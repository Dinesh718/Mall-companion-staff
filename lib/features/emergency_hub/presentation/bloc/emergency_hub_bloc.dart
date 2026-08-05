import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_emergency_hub_data_usecase.dart';
import 'emergency_hub_event.dart';
import 'emergency_hub_state.dart';

class EmergencyHubBloc extends Bloc<EmergencyHubEvent, EmergencyHubState> {
  final GetEmergencyHubDataUseCase getEmergencyHubDataUseCase;

  EmergencyHubBloc({required this.getEmergencyHubDataUseCase})
      : super(const EmergencyHubInitial()) {
    on<LoadEmergencyHubDataRequested>(_onLoadEmergencyHubData);
    on<RefreshEmergencyHubDataRequested>(_onRefreshEmergencyHubData);
  }

  Future<void> _onLoadEmergencyHubData(
    LoadEmergencyHubDataRequested event,
    Emitter<EmergencyHubState> emit,
  ) async {
    emit(const EmergencyHubLoading());

    try {
      final hubData = await getEmergencyHubDataUseCase();
      emit(EmergencyHubLoaded(hubData: hubData));
    } catch (e) {
      emit(EmergencyHubError(message: 'Failed to load emergency hub data: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshEmergencyHubData(
    RefreshEmergencyHubDataRequested event,
    Emitter<EmergencyHubState> emit,
  ) async {
    try {
      final hubData = await getEmergencyHubDataUseCase();
      emit(EmergencyHubLoaded(hubData: hubData));
    } catch (e) {
      // If refresh fails, we could potentially emit a specific state or keep the old data with a warning.
      emit(EmergencyHubError(message: 'Failed to refresh emergency hub data: ${e.toString()}'));
    }
  }
}
