// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/staff_role.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/role_selector.dart';
import '../widgets/mobile_input_field.dart';
import 'otp_verification_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _phoneController = TextEditingController();
  String _selectedRole = 'Admin';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  StaffRole _parseSelectedRole(String roleStr) {
    switch (roleStr) {
      case 'Admin':
        return StaffRole.admin;
      case 'Security':
        return StaffRole.security;
      case 'Maint.':
        return StaffRole.maintenance;
      case 'Store':
        return StaffRole.storeManager;
      default:
        return StaffRole.security;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mockRepo = AuthRepositoryImpl();

    return BlocProvider(
      create: (_) => AuthenticationBloc(
        sendOtpUseCase: SendOtpUseCase(mockRepo),
        verifyOtpUseCase: VerifyOtpUseCase(mockRepo),
        logoutUseCase: LogoutUseCase(mockRepo),
      ),
      child: Scaffold(
        backgroundColor: AppColors.stitchBackground,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is OtpSent) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (modalContext) => BlocProvider.value(
                    value: BlocProvider.of<AuthenticationBloc>(context),
                    child: OtpVerificationPage(
                      phoneNumber: state.phoneNumber,
                      role: state.role.name,
                    ),
                  ),
                ),
              );
            }

            if (state is AuthenticationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            final isSending = state is SendingOtp;

            return Stack(
              children: [
                // 1. Premium Blurred Background Blobs
                Positioned.fill(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -80,
                          right: -80,
                          width: 320,
                          height: 320,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryGradientStart.withOpacity(0.15),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -100,
                          left: -100,
                          width: 350,
                          height: 350,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryGradientEnd.withOpacity(0.12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. Scrollable Body
                SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 20.0),
                              // "Welcome Staff" Header
                              const Text(
                                'Welcome Staff',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 16.0),

                              // Hero Illustration
                              Center(
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: 15.0),
                                  duration: const Duration(seconds: 3),
                                  curve: Curves.easeInOut,
                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(0.0, value - 7.5),
                                      child: child,
                                    );
                                  },
                                  child: SizedBox(
                                    width: 260.0,
                                    height: 260.0,
                                    child: Image.network(
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuD6S76NSKb2REsMFV2bJfailyZY-AN_vU0C7O5Gjx1wg2Th2A1Uqa7uA5QlaGP1SZf8X6TmXIbjVcIYijzTI9i5FE5BZ2HEaoarV35raxfCKA_R0Vb0SYG5XABCskjF3HuJcAy9l1X2KjkCDkeaY6xQLzZT9A3XLx2pTe6OYJp0xDPzdqC_dt-KE2ME58T1XYN5WmZjLF3WEGUJpz60nnpP4g7cnPFcvlr78L66JUDUueO1LJxXe4iJya2YAqTv-Bar7kXBT61Dpg',
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.admin_panel_settings_rounded,
                                          color: AppColors.primary,
                                          size: 100.0,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),

                              // White Login Card
                              Container(
                                padding: const EdgeInsets.all(24.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF1F2937).withOpacity(0.05),
                                      blurRadius: 12.0,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    RoleSelector(
                                      selectedRole: _selectedRole,
                                      onRoleChanged: isSending
                                          ? (_) {}
                                          : (role) {
                                              setState(() {
                                                _selectedRole = role;
                                              });
                                            },
                                    ),
                                    const SizedBox(height: 24.0),
                                    MobileInputField(
                                      controller: _phoneController,
                                    ),
                                    const SizedBox(height: 32.0),

                                    // Continue button with gradient
                                    Container(
                                      height: 56.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9999.0),
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFF7B2FF7), Color(0xFF3B82F6)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF7B2FF7).withOpacity(0.2),
                                            blurRadius: 20.0,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: isSending
                                            ? null
                                            : () {
                                                final phone = _phoneController.text.trim();
                                                if (phone.length < 10) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Please enter a 10-digit mobile number.'),
                                                      backgroundColor: AppColors.error,
                                                      behavior: SnackBarBehavior.floating,
                                                    ),
                                                  );
                                                  return;
                                                }
                                                BlocProvider.of<AuthenticationBloc>(context).add(
                                                  SendOtpRequested(
                                                    phoneNumber: phone,
                                                    role: _parseSelectedRole(_selectedRole),
                                                  ),
                                                );
                                              },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          disabledBackgroundColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(9999.0),
                                          ),
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              isSending ? 'Sending...' : 'Continue',
                                              style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            if (isSending) ...[
                                              const SizedBox(width: 8.0),
                                              const SizedBox(
                                                width: 18.0,
                                                height: 18.0,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2.0,
                                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                ),
                                              ),
                                            ] else ...[
                                              const SizedBox(width: 8.0),
                                              const Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.white,
                                                size: 18.0,
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 48.0),

                              // Footer
                              const Spacer(),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.verified_user_rounded,
                                    color: AppColors.primary,
                                    size: 18.0,
                                  ),
                                  SizedBox(width: 6.0),
                                  Text(
                                    'Protected Enterprise Access',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Text(
                                'Secure Enterprise Access • © 2024 Mall Companion Staff',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 11.0,
                                  color: AppColors.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildFooterLink(context, 'Privacy Policy'),
                                  _buildFooterDivider(),
                                  _buildFooterLink(context, 'Terms of Service'),
                                  _buildFooterDivider(),
                                  _buildFooterLink(context, 'Contact Support'),
                                ],
                              ),
                              const SizedBox(height: 24.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFooterLink(BuildContext context, String text) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$text requested (placeholder)'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 11.0,
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildFooterDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(
        '•',
        style: TextStyle(
          fontSize: 11.0,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}
