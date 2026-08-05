import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_ticket_details_usecase.dart';
import '../../../domain/usecases/update_ticket_status_usecase.dart';
import '../../../domain/usecases/accept_ticket_usecase.dart';
import '../../../domain/usecases/start_work_usecase.dart';
import '../../../domain/usecases/pause_work_usecase.dart';
import '../../../domain/usecases/resume_work_usecase.dart';
import '../../../domain/usecases/escalate_ticket_usecase.dart';
import '../../../domain/usecases/resolve_ticket_usecase.dart';
import '../../../domain/usecases/close_ticket_usecase.dart';
import '../../../domain/entities/ticket_details_entity.dart';
import '../../../domain/entities/ticket_resolution_entity.dart';
import 'ticket_details_event.dart';
import 'ticket_details_state.dart';

class TicketDetailsBloc extends Bloc<TicketDetailsEvent, TicketDetailsState> {
  final GetTicketDetailsUseCase getTicketDetailsUseCase;
  final UpdateTicketStatusUseCase updateTicketStatusUseCase;
  final AcceptTicketUseCase acceptTicketUseCase;
  final StartWorkUseCase startWorkUseCase;
  final PauseWorkUseCase pauseWorkUseCase;
  final ResumeWorkUseCase resumeWorkUseCase;
  final EscalateTicketUseCase escalateTicketUseCase;
  final ResolveTicketUseCase resolveTicketUseCase;
  final CloseTicketUseCase closeTicketUseCase;

  String? _currentTicketId;

  TicketDetailsBloc({
    required this.getTicketDetailsUseCase,
    required this.updateTicketStatusUseCase,
    required this.acceptTicketUseCase,
    required this.startWorkUseCase,
    required this.pauseWorkUseCase,
    required this.resumeWorkUseCase,
    required this.escalateTicketUseCase,
    required this.resolveTicketUseCase,
    required this.closeTicketUseCase,
  }) : super(TicketDetailsInitial()) {
    on<LoadTicketDetails>(_onLoadTicketDetails);
    on<UpdateTicketStatus>(_onUpdateTicketStatus);
    on<PerformTicketOperation>(_onPerformTicketOperation);
    on<OpenResolutionWorkflow>(_onOpenResolutionWorkflow);
    on<UpdateResolutionForm>(_onUpdateResolutionForm);
    on<SubmitResolution>(_onSubmitResolution);
  }

  Future<void> _onLoadTicketDetails(LoadTicketDetails event, Emitter<TicketDetailsState> emit) async {
    _currentTicketId = event.ticketId;
    emit(TicketDetailsLoading());
    try {
      final details = await getTicketDetailsUseCase.call(event.ticketId);
      emit(TicketDetailsLoaded(details));
    } catch (e) {
      emit(TicketDetailsError(e.toString()));
    }
  }

  Future<void> _onUpdateTicketStatus(UpdateTicketStatus event, Emitter<TicketDetailsState> emit) async {
    if (_currentTicketId == null) return;
    
    // Just wrap existing status update for backward compatibility if needed
    final currentState = state;
    if (currentState is TicketDetailsLoaded || currentState is TicketDetailsOperationSuccess || currentState is TicketResolutionFormState) {
      TicketDetailsEntity details;
      if (currentState is TicketDetailsLoaded) {
        details = currentState.details;
      } else if (currentState is TicketResolutionFormState) {
        details = currentState.details;
      } else {
        details = (currentState as TicketDetailsOperationSuccess).details;
      }
      emit(TicketDetailsOperationLoading(details));
      try {
        await updateTicketStatusUseCase.call(_currentTicketId!, event.status);
        final updatedDetails = await getTicketDetailsUseCase.call(_currentTicketId!);
        emit(TicketDetailsOperationSuccess(updatedDetails, 'Ticket updated successfully.'));
      } catch (e) {
        emit(TicketDetailsOperationFailure(details, e.toString()));
      }
    }
  }

  Future<void> _onPerformTicketOperation(PerformTicketOperation event, Emitter<TicketDetailsState> emit) async {
    if (_currentTicketId == null) return;
    
    final currentState = state;
    if (currentState is TicketDetailsLoaded || 
        currentState is TicketDetailsOperationSuccess || 
        currentState is TicketDetailsOperationFailure || 
        currentState is TicketResolutionFormState) {
      
      TicketDetailsEntity details;
      if (currentState is TicketDetailsLoaded) {
        details = currentState.details;
      } else if (currentState is TicketDetailsOperationSuccess) {
        details = currentState.details;
      } else if (currentState is TicketResolutionFormState) {
        details = currentState.details;
      } else {
        details = (currentState as TicketDetailsOperationFailure).details;
      }
        
      emit(TicketDetailsOperationLoading(details));
      
      try {
        String successMessage = '';
        
        switch (event.operation) {
          case TicketOperation.accept:
            await acceptTicketUseCase.call(event.ticketId);
            successMessage = 'Ticket Accepted';
            break;
          case TicketOperation.startWork:
            await startWorkUseCase.call(event.ticketId);
            successMessage = 'Work Started';
            break;
          case TicketOperation.pauseWork:
            await pauseWorkUseCase.call(event.ticketId);
            successMessage = 'Ticket Paused';
            break;
          case TicketOperation.resumeWork:
            await resumeWorkUseCase.call(event.ticketId);
            successMessage = 'Work Resumed';
            break;
          case TicketOperation.escalate:
            await escalateTicketUseCase.call(event.ticketId, event.optionalNotes ?? '');
            successMessage = 'Ticket Escalated';
            break;
          case TicketOperation.resolve:
            // Handled separately by SubmitResolution
            break;
          case TicketOperation.close:
            await closeTicketUseCase.call(event.ticketId);
            successMessage = 'Ticket Closed';
            break;
        }

        final updatedDetails = await getTicketDetailsUseCase.call(event.ticketId);
        emit(TicketDetailsOperationSuccess(updatedDetails, successMessage));
      } catch (e) {
        emit(TicketDetailsOperationFailure(details, e.toString()));
      }
    }
  }

  void _onOpenResolutionWorkflow(OpenResolutionWorkflow event, Emitter<TicketDetailsState> emit) {
    if (_currentTicketId == null) return;
    
    TicketDetailsEntity? details;
    if (state is TicketDetailsLoaded) {
      details = (state as TicketDetailsLoaded).details;
    } else if (state is TicketResolutionFormState) {
      details = (state as TicketResolutionFormState).details;
    } else if (state is TicketDetailsOperationSuccess) {
      details = (state as TicketDetailsOperationSuccess).details;
    } else if (state is TicketDetailsOperationFailure) {
      details = (state as TicketDetailsOperationFailure).details;
    }

    if (details != null) {
      emit(TicketResolutionFormState(
        details: details,
        workPerformed: '',
        resolutionType: '',
        partsUsed: const [],
        photos: const [],
        internalNotes: '',
        isValid: false,
        isSubmitting: false,
      ));
    }
  }

  void _onUpdateResolutionForm(UpdateResolutionForm event, Emitter<TicketDetailsState> emit) {
    if (_currentTicketId == null) return;
    
    // We must find the current details
    TicketDetailsEntity? details;
    if (state is TicketDetailsLoaded) {
      details = (state as TicketDetailsLoaded).details;
    } else if (state is TicketResolutionFormState) {
      details = (state as TicketResolutionFormState).details;
    } else if (state is TicketDetailsOperationSuccess) {
      details = (state as TicketDetailsOperationSuccess).details;
    } else if (state is TicketDetailsOperationFailure) {
      details = (state as TicketDetailsOperationFailure).details;
    }

    if (details != null) {
      final isValid = event.workPerformed.trim().isNotEmpty && event.resolutionType.trim().isNotEmpty;
      emit(TicketResolutionFormState(
        details: details,
        workPerformed: event.workPerformed,
        resolutionType: event.resolutionType,
        partsUsed: event.partsUsed,
        photos: event.photos,
        internalNotes: event.internalNotes,
        isValid: isValid,
        isSubmitting: false,
      ));
    }
  }

  Future<void> _onSubmitResolution(SubmitResolution event, Emitter<TicketDetailsState> emit) async {
    if (_currentTicketId == null) return;
    
    if (state is TicketResolutionFormState) {
      final formState = state as TicketResolutionFormState;
      
      if (!formState.isValid) {
        emit(formState.copyWith(submissionError: 'Please fill out all required fields.'));
        return;
      }
      
      emit(formState.copyWith(isSubmitting: true, submissionError: null));
      
      try {
        final resolution = TicketResolutionEntity(
          workPerformed: formState.workPerformed,
          resolutionType: formState.resolutionType,
          partsUsed: formState.partsUsed,
          photos: formState.photos,
          internalNotes: formState.internalNotes,
        );
        
        await resolveTicketUseCase.call(event.ticketId, resolution);
        
        final updatedDetails = await getTicketDetailsUseCase.call(event.ticketId);
        emit(TicketDetailsOperationSuccess(updatedDetails, 'Ticket Resolved Successfully'));
      } catch (e) {
        emit(formState.copyWith(
          isSubmitting: false,
          submissionError: e.toString(),
        ));
      }
    }
  }
}

