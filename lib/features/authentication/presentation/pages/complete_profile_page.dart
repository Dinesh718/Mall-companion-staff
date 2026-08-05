import 'package:flutter/material.dart';
import '../../../../core/navigation/role_router.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/staff_profile_entity.dart';

class CompleteProfilePage extends StatelessWidget {
  final StaffProfileEntity user;

  const CompleteProfilePage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Complete Profile'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 0.5,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_outline_rounded,
                size: 80.0,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Complete Your Profile',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textNavy,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Access Role: ${user.role.name.toUpperCase()}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGray,
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // Simulate profile completion updating isProfileComplete and route to dashboard
                  final updatedUser = StaffProfileEntity(
                    uid: user.uid,
                    phoneNumber: user.phoneNumber,
                    name: 'Mock Staff Member',
                    email: 'mock.staff@mallcompanion.com',
                    role: user.role,
                    isProfileComplete: true,
                  );
                  RoleRouter.routeToDashboard(context, updatedUser);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
                child: const Text('Complete Profile & Go to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
