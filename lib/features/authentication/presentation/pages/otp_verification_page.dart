// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/navigation/role_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/otp_input_row.dart';

import 'complete_profile_page.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String role;

  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
    required this.role,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _timerExpired = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 30;
      _timerExpired = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _timerExpired = true;
        });
        _timer?.cancel();
      }
    });
  }

  void _verifyOtp() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the 6-digit OTP code.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    BlocProvider.of<AuthenticationBloc>(context).add(
      VerifyOtpRequested(
        phoneNumber: widget.phoneNumber,
        otp: otp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timerString = '00:${_secondsRemaining.toString().padLeft(2, '0')}';

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome, ${state.user.name ?? "Staff"}!'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
          if (state.user.isProfileComplete) {
            RoleRouter.routeToDashboard(context, state.user);
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (modalContext) => BlocProvider.value(
                  value: BlocProvider.of<AuthenticationBloc>(context),
                  child: CompleteProfilePage(user: state.user),
                ),
              ),
            );
          }
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
        final isVerifying = state is VerifyingOtp;

        return Scaffold(
          backgroundColor: AppColors.stitchBackground,
          appBar: AppBar(
            automaticallyImplyLeading: !isVerifying,
            iconTheme: const IconThemeData(color: AppColors.primary),
            title: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.admin_panel_settings_rounded,
                  color: AppColors.primary,
                  size: 24.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Mall Companion Staff',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16.0),
                        // Hero Illustration
                        Center(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.scale(
                                  scale: 0.8 + (value * 0.2),
                                  child: child,
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 200.0,
                              height: 200.0,
                              child: Image.network(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuAU7Z6n-ph0EvWMKeqI_kUL8Oweabc5Vf0VFziQDwWcqchfciTG5Atrp9lSqUIAKOT5LTZ-DPXoLTWMMKjGJc5xVHF2Dxu-Rapt1HCpUKyTX5TXG7n-EHWQ0V7552XK026_0-t_gnPq9e8_Xxq_-F_VOt83PMOJHyOBbtylxyhrpcqGChh0gfO900cTU9AKrq2y-tugPk6JKevG5EOz6x0FmK8qNSfLMfhN9jJ3zJ5nOownX43sMK53ajpM2H0sb3VrpBw_usPRdw',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.lock_person_rounded,
                                    color: AppColors.primary,
                                    size: 80.0,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24.0),

                        // Verification Header Texts
                        const Text(
                          'Verify Your Number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Enter the 6-digit verification code sent to your registered mobile number.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14.0,
                              color: AppColors.onSurfaceVariant,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),

                        // OTP inputs
                        OtpInputRow(
                          controllers: _otpControllers,
                          onOtpChanged: (otp) {
                            if (otp.length == 6) {
                              _verifyOtp();
                            }
                          },
                        ),
                        const SizedBox(height: 24.0),

                        // Timer / Resend OTP Action
                        Center(
                          child: _timerExpired
                              ? TextButton(
                                  onPressed: isVerifying ? null : _startTimer,
                                  child: const Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Resend in $timerString',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 32.0),

                        // Verify button
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
                                blurRadius: 12.0,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: isVerifying ? null : _verifyOtp,
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
                                  isVerifying ? 'Verifying...' : 'Verify OTP',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                if (isVerifying) ...[
                                  const SizedBox(width: 8.0),
                                  const SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 48.0),

                        // Footer
                        const Spacer(),
                        const Text(
                          'Mall Companion Staff',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4.0),
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
        );
      },
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
