// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/store_dashboard_entity.dart';
import '../../../queue/presentation/pages/queue_dashboard_page.dart';

class LiveQueueCard extends StatelessWidget {
  final StoreDashboardEntity dashboard;

  const LiveQueueCard({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1D1A25), // inverse-surface
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F2937).withOpacity(0.12),
              blurRadius: 24.0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Ambient glow
            Positioned(
              right: -40.0,
              bottom: -40.0,
              width: 140.0,
              height: 140.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.3),
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Live Queue',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Real-time status',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    if (dashboard.isQueueActive)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(999.0),
                          border: Border.all(
                            color: const Color(0xFF10B981).withOpacity(0.2),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _PulsingDot(color: Color(0xFF10B981)),
                            SizedBox(width: 6.0),
                            Text(
                              'ACTIVE',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF10B981),
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 28.0),

                // Metrics Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'WAITING',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.5),
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            '${dashboard.waitingQueueCount}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.0,
                      height: 36.0,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'SERVING',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.5),
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            '${dashboard.servingQueueCount}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.0,
                      height: 36.0,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'EST. TIME',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.5),
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            dashboard.estimatedQueueWaitTime,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28.0),

                // Button row
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 56.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const QueueDashboardPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryContainer,
                            foregroundColor: AppColors.onPrimaryContainer,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                          ),
                          child: const Text(
                            'Manage Queue',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: SizedBox(
                        height: 56.0,
                        child: OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pause Queue (mock)'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                          ),
                          child: const Text(
                            'Pause Queue',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
      opacity: Tween<double>(begin: 0.4, end: 1.0).animate(_controller),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.9, end: 1.15).animate(_controller),
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
