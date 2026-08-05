class QueueStatusDistributionEntity {
  final String status;
  final int count;
  final double percentage;
  final String colorHex;

  const QueueStatusDistributionEntity({
    required this.status,
    required this.count,
    required this.percentage,
    required this.colorHex,
  });
}
