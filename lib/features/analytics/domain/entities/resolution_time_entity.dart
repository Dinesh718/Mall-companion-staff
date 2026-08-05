class ResolutionTimeEntity {
  final String categoryName;
  final int averageTimeMinutes;
  final double percentage; // 0.0 to 1.0 (for width representation)
  final String colorHex;

  const ResolutionTimeEntity({
    required this.categoryName,
    required this.averageTimeMinutes,
    required this.percentage,
    required this.colorHex,
  });
}
