import 'package:equatable/equatable.dart';
import '../../domain/entities/queue_priority.dart';
import '../../domain/entities/queue_source.dart';

abstract class AddWalkInEvent extends Equatable {
  const AddWalkInEvent();

  @override
  List<Object?> get props => [];
}

class InitializeAddWalkIn extends AddWalkInEvent {
  const InitializeAddWalkIn();
}

class CustomerNameChanged extends AddWalkInEvent {
  final String name;
  const CustomerNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class PhoneChanged extends AddWalkInEvent {
  final String phone;
  const PhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class EmailChanged extends AddWalkInEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PartySizeChanged extends AddWalkInEvent {
  final int partySize;
  const PartySizeChanged(this.partySize);

  @override
  List<Object?> get props => [partySize];
}

class PreferredContactChanged extends AddWalkInEvent {
  final String preference;
  const PreferredContactChanged(this.preference);

  @override
  List<Object?> get props => [preference];
}

class PriorityChanged extends AddWalkInEvent {
  final QueuePriority priority;
  const PriorityChanged(this.priority);

  @override
  List<Object?> get props => [priority];
}

class ServiceTypeChanged extends AddWalkInEvent {
  final String serviceType;
  const ServiceTypeChanged(this.serviceType);

  @override
  List<Object?> get props => [serviceType];
}

class DurationChanged extends AddWalkInEvent {
  final int durationMinutes;
  const DurationChanged(this.durationMinutes);

  @override
  List<Object?> get props => [durationMinutes];
}

class SpecialRequestToggled extends AddWalkInEvent {
  final String request;
  const SpecialRequestToggled(this.request);

  @override
  List<Object?> get props => [request];
}

class InternalNotesChanged extends AddWalkInEvent {
  final String notes;
  const InternalNotesChanged(this.notes);

  @override
  List<Object?> get props => [notes];
}

class QueueSourceChanged extends AddWalkInEvent {
  final QueueSource source;
  const QueueSourceChanged(this.source);

  @override
  List<Object?> get props => [source];
}

class SubmitWalkIn extends AddWalkInEvent {
  const SubmitWalkIn();
}

class ResetWalkInForm extends AddWalkInEvent {
  const ResetWalkInForm();
}
