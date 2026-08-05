import '../../domain/entities/staff_profile_entity.dart';
import '../../domain/entities/staff_role.dart';

class StaffProfileModel extends StaffProfileEntity {
  const StaffProfileModel({
    required super.uid,
    required super.phoneNumber,
    super.name,
    super.email,
    required super.role,
    required super.isProfileComplete,
  });

  factory StaffProfileModel.fromJson(Map<String, dynamic> json) {
    return StaffProfileModel(
      uid: json['uid'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: _parseRole(json['role'] as String? ?? ''),
      isProfileComplete: json['isProfileComplete'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'role': _roleToString(role),
      'isProfileComplete': isProfileComplete,
    };
  }

  static StaffRole _parseRole(String roleStr) {
    switch (roleStr.toLowerCase()) {
      case 'admin':
      case 'malladmin':
        return StaffRole.admin;
      case 'security':
        return StaffRole.security;
      case 'maintenance':
      case 'maint':
        return StaffRole.maintenance;
      case 'store':
      case 'storemanager':
        return StaffRole.storeManager;
      default:
        return StaffRole.maintenance;
    }
  }

  static String _roleToString(StaffRole role) {
    switch (role) {
      case StaffRole.admin:
        return 'admin';
      case StaffRole.security:
        return 'security';
      case StaffRole.maintenance:
        return 'maintenance';
      case StaffRole.storeManager:
        return 'storeManager';
    }
  }
}
