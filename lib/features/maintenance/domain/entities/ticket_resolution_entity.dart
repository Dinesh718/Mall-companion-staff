import 'package:equatable/equatable.dart';

class TicketResolutionEntity extends Equatable {
  final String workPerformed;
  final String resolutionType;
  final List<String> partsUsed;
  final List<String> photos;
  final String internalNotes;

  const TicketResolutionEntity({
    required this.workPerformed,
    required this.resolutionType,
    this.partsUsed = const [],
    this.photos = const [],
    this.internalNotes = '',
  });

  TicketResolutionEntity copyWith({
    String? workPerformed,
    String? resolutionType,
    List<String>? partsUsed,
    List<String>? photos,
    String? internalNotes,
  }) {
    return TicketResolutionEntity(
      workPerformed: workPerformed ?? this.workPerformed,
      resolutionType: resolutionType ?? this.resolutionType,
      partsUsed: partsUsed ?? this.partsUsed,
      photos: photos ?? this.photos,
      internalNotes: internalNotes ?? this.internalNotes,
    );
  }

  bool get isValid => workPerformed.trim().isNotEmpty && resolutionType.trim().isNotEmpty;

  @override
  List<Object?> get props => [workPerformed, resolutionType, partsUsed, photos, internalNotes];
}
