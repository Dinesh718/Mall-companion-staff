import 'package:equatable/equatable.dart';
import '../../domain/entities/create_queue_entry_entity.dart';
import '../../domain/entities/queue_entity.dart';

abstract class AddWalkInState extends Equatable {
  const AddWalkInState();

  @override
  List<Object?> get props => [];
}

class AddWalkInInitial extends AddWalkInState {
  const AddWalkInInitial();
}

class AddWalkInEditing extends AddWalkInState {
  final CreateQueueEntryEntity formState;

  const AddWalkInEditing(this.formState);

  @override
  List<Object?> get props => [formState];
}

class AddWalkInSubmitting extends AddWalkInState {
  final CreateQueueEntryEntity formState;

  const AddWalkInSubmitting(this.formState);

  @override
  List<Object?> get props => [formState];
}

class AddWalkInSuccess extends AddWalkInState {
  final QueueEntity queueItem;

  const AddWalkInSuccess(this.queueItem);

  @override
  List<Object?> get props => [queueItem];
}

class AddWalkInValidationError extends AddWalkInState {
  final CreateQueueEntryEntity formState;

  const AddWalkInValidationError(this.formState);

  @override
  List<Object?> get props => [formState];
}

class AddWalkInFailure extends AddWalkInState {
  final String errorMessage;
  final CreateQueueEntryEntity? formState;

  const AddWalkInFailure(this.errorMessage, [this.formState]);

  @override
  List<Object?> get props => [errorMessage, formState];
}
