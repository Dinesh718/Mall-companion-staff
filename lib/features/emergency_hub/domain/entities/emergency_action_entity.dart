class EmergencyActionEntity {
  final String title;
  final String subtitle;
  final String iconName;
  final bool isDestructive; // for SOS
  final String routeName;

  const EmergencyActionEntity({
    required this.title,
    required this.subtitle,
    required this.iconName,
    this.isDestructive = false,
    required this.routeName,
  });
}
