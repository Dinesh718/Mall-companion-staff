class AssistanceServiceEntity {
  final String title;
  final String subtitle;
  final String iconName;
  final String badgeText;

  const AssistanceServiceEntity({
    required this.title,
    required this.subtitle,
    required this.iconName,
    this.badgeText = '',
  });
}
