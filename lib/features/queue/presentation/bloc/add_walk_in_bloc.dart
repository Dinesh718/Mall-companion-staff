import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/create_queue_entry_entity.dart';
import '../../domain/usecases/create_queue_entry_usecase.dart';
import '../../domain/usecases/validate_queue_entry_usecase.dart';
import 'add_walk_in_event.dart';
import 'add_walk_in_state.dart';

class AddWalkInBloc extends Bloc<AddWalkInEvent, AddWalkInState> {
  final CreateQueueEntryUseCase createQueueEntryUseCase;
  final ValidateQueueEntryUseCase validateQueueEntryUseCase;

  AddWalkInBloc({
    required this.createQueueEntryUseCase,
    required this.validateQueueEntryUseCase,
  }) : super(const AddWalkInInitial()) {
    on<InitializeAddWalkIn>(_onInitializeAddWalkIn);
    on<CustomerNameChanged>(_onCustomerNameChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PartySizeChanged>(_onPartySizeChanged);
    on<PreferredContactChanged>(_onPreferredContactChanged);
    on<PriorityChanged>(_onPriorityChanged);
    on<ServiceTypeChanged>(_onServiceTypeChanged);
    on<DurationChanged>(_onDurationChanged);
    on<SpecialRequestToggled>(_onSpecialRequestToggled);
    on<InternalNotesChanged>(_onInternalNotesChanged);
    on<QueueSourceChanged>(_onQueueSourceChanged);
    on<SubmitWalkIn>(_onSubmitWalkIn);
    on<ResetWalkInForm>(_onResetWalkInForm);
  }

  void _onInitializeAddWalkIn(InitializeAddWalkIn event, Emitter<AddWalkInState> emit) {
    emit(const AddWalkInEditing(CreateQueueEntryEntity()));
  }

  void _onCustomerNameChanged(CustomerNameChanged event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    emit(AddWalkInEditing(cur.copyWith(
      customerName: event.name,
      validationErrors: Map.from(cur.validationErrors)..remove('customerName'),
    )));
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    emit(AddWalkInEditing(cur.copyWith(
      phoneNumber: event.phone,
      validationErrors: Map.from(cur.validationErrors)..remove('phoneNumber'),
    )));
  }

  void _onEmailChanged(EmailChanged event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    emit(AddWalkInEditing(cur.copyWith(
      email: event.email,
      validationErrors: Map.from(cur.validationErrors)..remove('email'),
    )));
  }

  void _onPartySizeChanged(PartySizeChanged event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    emit(AddWalkInEditing(cur.copyWith(partySize: event.partySize)));
  }

  void _onPreferredContactChanged(PreferredContactChanged event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    emit(AddWalkInEditing(cur.copyWith(contactPreference: event.preference)));
  }

  void _onPriorityChanged(PriorityChanged event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    emit(AddWalkInEditing(cur.copyWith(priority: event.priority)));
  }

  void _onServiceTypeChanged(ServiceTypeChanged event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    emit(AddWalkInEditing(cur.copyWith(serviceType: event.serviceType)));
  }

  void _onDurationChanged(DurationChanged event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    emit(AddWalkInEditing(cur.copyWith(estimatedDurationMinutes: event.durationMinutes)));
  }

  void _onSpecialRequestToggled(SpecialRequestToggled event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    final list = List<String>.from(cur.specialRequests);
    if (list.contains(event.request)) {
      list.remove(event.request);
    } else {
      list.add(event.request);
    }
    emit(AddWalkInEditing(cur.copyWith(specialRequests: list)));
  }

  void _onInternalNotesChanged(InternalNotesChanged event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    emit(AddWalkInEditing(cur.copyWith(internalNotes: event.notes)));
  }

  void _onQueueSourceChanged(QueueSourceChanged event, Emitter<AddWalkInState> emit) {
    final cur = _getFormState();
    emit(AddWalkInEditing(cur.copyWith(queueSource: event.source)));
  }

  Future<void> _onSubmitWalkIn(SubmitWalkIn event, Emitter<AddWalkInState> emit) async {
    final cur = _getFormState();
    emit(AddWalkInSubmitting(cur));

    try {
      final errors = await validateQueueEntryUseCase(cur);
      if (errors.isNotEmpty) {
        emit(AddWalkInValidationError(cur.copyWith(validationErrors: errors)));
        return;
      }

      final created = await createQueueEntryUseCase(cur);
      emit(AddWalkInSuccess(created));
    } catch (e) {
      emit(AddWalkInFailure(e.toString(), cur));
    }
  }

  void _onResetWalkInForm(ResetWalkInForm event, Emitter<AddWalkInState> emit) {
    emit(const AddWalkInEditing(CreateQueueEntryEntity()));
  }

  CreateQueueEntryEntity _getFormState() {
    final s = state;
    if (s is AddWalkInEditing) return s.formState;
    if (s is AddWalkInSubmitting) return s.formState;
    if (s is AddWalkInValidationError) return s.formState;
    if (s is AddWalkInFailure && s.formState != null) return s.formState!;
    return const CreateQueueEntryEntity();
  }
}
