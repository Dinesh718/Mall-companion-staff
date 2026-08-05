import 'package:equatable/equatable.dart';
import '../../../domain/entities/ticket_details_entity.dart';

abstract class TicketDetailsState extends Equatable {
  const TicketDetailsState();

  @override
  List<Object?> get props => [];
}

class TicketDetailsInitial extends TicketDetailsState {}

class TicketDetailsLoading extends TicketDetailsState {}

class TicketDetailsLoaded extends TicketDetailsState {
  final TicketDetailsEntity details;

  const TicketDetailsLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

class TicketDetailsError extends TicketDetailsState {
  final String errorMessage;

  const TicketDetailsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class TicketDetailsOperationLoading extends TicketDetailsState {
  final TicketDetailsEntity details;

  const TicketDetailsOperationLoading(this.details);

  @override
  List<Object?> get props => [details];
}

class TicketDetailsOperationSuccess extends TicketDetailsState {
  final TicketDetailsEntity details;
  final String message;

  const TicketDetailsOperationSuccess(this.details, this.message);

  @override
  List<Object?> get props => [details, message];
}

class TicketDetailsOperationFailure extends TicketDetailsState {
  final TicketDetailsEntity details;
  final String errorMessage;

  const TicketDetailsOperationFailure(this.details, this.errorMessage);

  @override
  List<Object?> get props => [details, errorMessage];
}

class TicketResolutionFormState extends TicketDetailsState {
  final TicketDetailsEntity details;
  final String workPerformed;
  final String resolutionType;
  final List<String> partsUsed;
  final List<String> photos;
  final String internalNotes;
  final bool isValid;
  final bool isSubmitting;
  final String? submissionError;

  const TicketResolutionFormState({
    required this.details,
    this.workPerformed = '',
    this.resolutionType = '',
    this.partsUsed = const [],
    this.photos = const [],
    this.internalNotes = '',
    this.isValid = false,
    this.isSubmitting = false,
    this.submissionError,
  });

  TicketResolutionFormState copyWith({
    TicketDetailsEntity? details,
    String? workPerformed,
    String? resolutionType,
    List<String>? partsUsed,
    List<String>? photos,
    String? internalNotes,
    bool? isValid,
    bool? isSubmitting,
    String? submissionError,
  }) {
    return TicketResolutionFormState(
      details: details ?? this.details,
      workPerformed: workPerformed ?? this.workPerformed,
      resolutionType: resolutionType ?? this.resolutionType,
      partsUsed: partsUsed ?? this.partsUsed,
      photos: photos ?? this.photos,
      internalNotes: internalNotes ?? this.internalNotes,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submissionError: submissionError ?? this.submissionError,
    );
  }

  @override
  List<Object?> get props => [
        details,
        workPerformed,
        resolutionType,
        partsUsed,
        photos,
        internalNotes,
        isValid,
        isSubmitting,
        submissionError,
      ];
}
