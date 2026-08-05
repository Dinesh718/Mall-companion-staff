class PerformanceMetricsEntity {
  final double completionRate;
  final String completionRateLabel;
  final double cancellationRate;
  final String cancellationRateLabel;
  final bool isStable;
  final String stabilityMessage;

  const PerformanceMetricsEntity({
    required this.completionRate,
    required this.completionRateLabel,
    required this.cancellationRate,
    required this.cancellationRateLabel,
    required this.isStable,
    required this.stabilityMessage,
  });
}
