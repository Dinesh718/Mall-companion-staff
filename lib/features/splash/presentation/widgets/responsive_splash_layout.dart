// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/themes/app_colors.dart';

class ResponsiveSplashLayout extends StatelessWidget {
  const ResponsiveSplashLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutCubic,
          builder: (context, opacity, child) {
            return Opacity(
              opacity: opacity,
              child: child,
            );
          },
          child: SizedBox.expand(
            child: Image.asset(
              AssetConstants.splashLogo,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback UI if asset fails to load
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.apartment_rounded,
                      color: Colors.white,
                      size: 80.0,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'MALL COMPANION',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'STAFF PORTAL',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 4.0,
                          ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
