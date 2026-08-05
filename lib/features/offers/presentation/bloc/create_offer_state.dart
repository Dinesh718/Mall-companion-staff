import 'package:equatable/equatable.dart';
import '../../domain/entities/offer_entity.dart';
import '../../domain/entities/create_offer_form_entity.dart';

abstract class CreateOfferState extends Equatable {
  const CreateOfferState();

  @override
  List<Object?> get props => [];
}

class CreateOfferInitial extends CreateOfferState {
  const CreateOfferInitial();
}

class CreateOfferEditing extends CreateOfferState {
  final CreateOfferFormEntity formState;

  const CreateOfferEditing(this.formState);

  @override
  List<Object?> get props => [formState];
}

class CreateOfferValidating extends CreateOfferState {
  final CreateOfferFormEntity formState;

  const CreateOfferValidating(this.formState);

  @override
  List<Object?> get props => [formState];
}

class CreateOfferDraftSaved extends CreateOfferState {
  final OfferEntity offer;

  const CreateOfferDraftSaved(this.offer);

  @override
  List<Object?> get props => [offer];
}

class CreateOfferPublishing extends CreateOfferState {
  final CreateOfferFormEntity formState;

  const CreateOfferPublishing(this.formState);

  @override
  List<Object?> get props => [formState];
}

class CreateOfferPublished extends CreateOfferState {
  final OfferEntity offer;

  const CreateOfferPublished(this.offer);

  @override
  List<Object?> get props => [offer];
}

class CreateOfferValidationError extends CreateOfferState {
  final CreateOfferFormEntity formState;

  const CreateOfferValidationError(this.formState);

  @override
  List<Object?> get props => [formState];
}

class CreateOfferFailure extends CreateOfferState {
  final String errorMessage;
  final CreateOfferFormEntity? formState;

  const CreateOfferFailure(this.errorMessage, [this.formState]);

  @override
  List<Object?> get props => [errorMessage, formState];
}

// Phase 3.4 Edit Offer
class CreateOfferUpdated extends CreateOfferState {
  final OfferEntity offer;

  const CreateOfferUpdated(this.offer);

  @override
  List<Object?> get props => [offer];
}

