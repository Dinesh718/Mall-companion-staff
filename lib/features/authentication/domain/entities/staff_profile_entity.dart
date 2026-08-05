import 'staff_role.dart';

class StaffProfileEntity {
  final String uid;
  final String phoneNumber;
  final String? name;
  final String? email;
  final StaffRole role;
  final bool isProfileComplete;

  const StaffProfileEntity({
    required this.uid,
    required this.phoneNumber,
    this.name,
    this.email,
    required this.role,
    required this.isProfileComplete,
  });
}
