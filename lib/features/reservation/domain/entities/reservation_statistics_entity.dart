import 'package:equatable/equatable.dart';

class HourlyOccupancyEntity extends Equatable {
  final String timeLabel;
  final int count;
  final double capacityPercentage;

  const HourlyOccupancyEntity({
    required this.timeLabel,
    required this.count,
    required this.capacityPercentage,
  });

  @override
  List<Object?> get props => [timeLabel, count, capacityPercentage];
}

class ReservationStatisticsEntity extends Equatable {
  final List<HourlyOccupancyEntity> hourlyOccupancy;
  final double averagePartySize;
  final double cancellationRate;
  final String peakHour;

  const ReservationStatisticsEntity({
    required this.hourlyOccupancy,
    required this.averagePartySize,
    required this.cancellationRate,
    required this.peakHour,
  });

  @override
  List<Object?> get props => [
        hourlyOccupancy,
        averagePartySize,
        cancellationRate,
        peakHour,
      ];
}
