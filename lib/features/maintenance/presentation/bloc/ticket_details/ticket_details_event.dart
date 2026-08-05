import 'package:equatable/equatable.dart';

abstract class TicketDetailsEvent extends Equatable {
  const TicketDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTicketDetails extends TicketDetailsEvent {
  final String ticketId;

  const LoadTicketDetails(this.ticketId);

  @override
  List<Object?> get props => [ticketId];
}

class UpdateTicketStatus extends TicketDetailsEvent {
  final String status;

  const UpdateTicketStatus(this.status);

  @override
  List<Object?> get props => [status];
}

enum TicketOperation {
  accept,
  startWork,
  pauseWork,
  resumeWork,
  escalate,
  resolve,
  close,
}

class PerformTicketOperation extends TicketDetailsEvent {
  final String ticketId;
  final TicketOperation operation;
  final String? optionalNotes; // e.g., for resolve or escalate

  const PerformTicketOperation({
    required this.ticketId,
    required this.operation,
    this.optionalNotes,
  });

  @override
  List<Object?> get props => [ticketId, operation, optionalNotes];
}

class UpdateResolutionForm extends TicketDetailsEvent {
  final String workPerformed;
  final String resolutionType;
  final List<String> partsUsed;
  final List<String> photos;
  final String internalNotes;

  const UpdateResolutionForm({
    required this.workPerformed,
    required this.resolutionType,
    required this.partsUsed,
    required this.photos,
    required this.internalNotes,
  });

  @override
  List<Object?> get props => [workPerformed, resolutionType, partsUsed, photos, internalNotes];
}

class OpenResolutionWorkflow extends TicketDetailsEvent {
  const OpenResolutionWorkflow();

  @override
  List<Object?> get props => [];
}

class SubmitResolution extends TicketDetailsEvent {
  final String ticketId;

  const SubmitResolution(this.ticketId);

  @override
  List<Object?> get props => [ticketId];
}
