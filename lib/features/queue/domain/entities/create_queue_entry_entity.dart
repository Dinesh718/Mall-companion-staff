import 'package:equatable/equatable.dart';
import 'queue_priority.dart';
import 'queue_source.dart';

class CreateQueueEntryEntity extends Equatable {
  final String customerName;
  final String phoneNumber;
  final String email;
  final int partySize;
  final String contactPreference; // 'SMS', 'Email', etc.
  final String serviceType; // 'Walk-in', etc.
  final QueuePriority priority;
  final int estimatedDurationMinutes;
  final List<String> specialRequests;
  final String internalNotes;
  final QueueSource queueSource;
  final Map<String, String> validationErrors;

  const CreateQueueEntryEntity({
    this.customerName = '',
    this.phoneNumber = '',
    this.email = '',
    this.partySize = 1,
    this.contactPreference = 'SMS',
    this.serviceType = 'Walk-in',
    this.priority = QueuePriority.normal,
    this.estimatedDurationMinutes = 30,
    this.specialRequests = const [],
    this.internalNotes = '',
    this.queueSource = QueueSource.inPerson,
    this.validationErrors = const {},
  });

  CreateQueueEntryEntity copyWith({
    String? customerName,
    String? phoneNumber,
    String? email,
    int? partySize,
    String? contactPreference,
    String? serviceType,
    QueuePriority? priority,
    int? estimatedDurationMinutes,
    List<String>? specialRequests,
    String? internalNotes,
    QueueSource? queueSource,
    Map<String, String>? validationErrors,
  }) {
    return CreateQueueEntryEntity(
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      partySize: partySize ?? this.partySize,
      contactPreference: contactPreference ?? this.contactPreference,
      serviceType: serviceType ?? this.serviceType,
      priority: priority ?? this.priority,
      estimatedDurationMinutes: estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      specialRequests: specialRequests ?? this.specialRequests,
      internalNotes: internalNotes ?? this.internalNotes,
      queueSource: queueSource ?? this.queueSource,
      validationErrors: validationErrors ?? this.validationErrors,
    );
  }

  @override
  List<Object?> get props => [
        customerName,
        phoneNumber,
        email,
        partySize,
        contactPreference,
        serviceType,
        priority,
        estimatedDurationMinutes,
        specialRequests,
        internalNotes,
        queueSource,
        validationErrors,
      ];
}
