class StaffPerformanceEntity {
  final int activeStaffCount;
  final int avgCustomersServedPerStaff;
  final int fastestServiceMinutes;
  final double teamEfficiency;

  const StaffPerformanceEntity({
    required this.activeStaffCount,
    required this.avgCustomersServedPerStaff,
    required this.fastestServiceMinutes,
    required this.teamEfficiency,
  });
}
