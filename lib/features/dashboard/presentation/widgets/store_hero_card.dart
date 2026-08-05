// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/store_dashboard_entity.dart';

class StoreHeroCard extends StatelessWidget {
  final StoreDashboardEntity dashboard;

  const StoreHeroCard({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.08),
              AppColors.primaryGradientEnd.withOpacity(0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.4),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F2937).withOpacity(0.06),
              blurRadius: 24.0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Decorative background blurs
            Positioned(
              right: -50.0,
              top: -50.0,
              width: 180.0,
              height: 180.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.12),
                ),
              ),
            ),
            Positioned(
              left: -40.0,
              bottom: -40.0,
              width: 140.0,
              height: 140.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryGradientEnd.withOpacity(0.08),
                ),
              ),
            ),

            // Open/Closed badge
            Positioned(
              top: 20.0,
              right: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: dashboard.isOpen ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(
                    color: dashboard.isOpen ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _PulsingDot(
                      color: dashboard.isOpen ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      dashboard.isOpen ? 'OPEN' : 'CLOSED',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF047857),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Central logo and details
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  // Store logo container
                  Container(
                    width: 110.0,
                    height: 110.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1F2937).withOpacity(0.08),
                          blurRadius: 20.0,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(22.0),
                    child: Image.network(
                      dashboard.storeLogoUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.storefront_rounded,
                          color: AppColors.primary,
                          size: 40.0,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Store Info Texts
                  Text(
                    dashboard.storeName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontFamily: 'Inter',
                      fontSize: 26.0,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textNavy,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6.0),

                  // Unit and level
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '📍',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        dashboard.storeLevel,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        width: 4.0,
                        height: 4.0,
                        decoration: const BoxDecoration(
                          color: AppColors.outlineVariant,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        '🏬',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        dashboard.storeUnit,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28.0),

                  // Closing info chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EBFA), // surface-container
                      borderRadius: BorderRadius.circular(999.0),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.schedule_rounded,
                          size: 14.0,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'CLOSES TODAY: ',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          dashboard.closingTime,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;

  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.5, end: 1.0).animate(_controller),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.2).animate(_controller),
        child: Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
