class ContactEntity {
  final String phone;
  final String email;
  final String emergencyContactName;
  final String bloodGroup;
  final bool isFirstAidCertified;

  const ContactEntity({
    required this.phone,
    required this.email,
    required this.emergencyContactName,
    required this.bloodGroup,
    required this.isFirstAidCertified,
  });
}
