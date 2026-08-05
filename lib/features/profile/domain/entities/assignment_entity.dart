class AssignmentEntity {
  final String mall;
  final String zone;
  final String shift;
  final String experience;
  final String department;
  final String reportingManager;
  final String employmentType;
  final List<String> authorizedEquipment;

  const AssignmentEntity({
    required this.mall,
    required this.zone,
    required this.shift,
    required this.experience,
    required this.department,
    required this.reportingManager,
    required this.employmentType,
    required this.authorizedEquipment,
  });
}
