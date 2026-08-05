import 'package:equatable/equatable.dart';

class QueueSummaryEntity extends Equatable {
  final int waitingCount;
  final int servingCount;
  final int completedCount;
  final int cancelledCount;
  final int avgWaitTimeMinutes;
  final String healthStatus;
  final String currentDate;

  const QueueSummaryEntity({
    required this.waitingCount,
    required this.servingCount,
    required this.completedCount,
    required this.cancelledCount,
    required this.avgWaitTimeMinutes,
    required this.healthStatus,
    required this.currentDate,
  });

  @override
  List<Object?> get props => [
        waitingCount,
        servingCount,
        completedCount,
        cancelledCount,
        avgWaitTimeMinutes,
        healthStatus,
        currentDate,
      ];
}
