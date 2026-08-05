import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class EmergencyHeroCard extends StatelessWidget {
  final String securityTeamStatus;
  final String avgResponseTime;
  final String mallStatusText;

  const EmergencyHeroCard({
    super.key,
    required this.securityTeamStatus,
    required this.avgResponseTime,
    required this.mallStatusText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6B38D4),
            AppColors.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 15.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            // Shield watermark
            Positioned(
              right: -16.0,
              top: -16.0,
              child: Opacity(
                opacity: 0.1,
                child: Icon(
                  Icons.shield_rounded,
                  size: 120.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Need Immediate Help?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 28.0, // headline-lg-mobile
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Quickly access emergency services, assistance, and evacuation guidance throughout the mall.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0, // body-lg
                      color: Colors.white70, // equivalent to on-primary/90
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: [
                      _buildChip(Icons.verified_user_outlined, 'Security Team: $securityTeamStatus'),
                      _buildChip(Icons.timer_outlined, 'Avg. Response: $avgResponseTime'),
                      _buildChip(Icons.check_circle_outline, 'Mall Status: $mallStatusText'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51), // on-primary/20
        borderRadius: BorderRadius.circular(100.0), // rounded-full
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.0, color: Colors.white),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0, // label-md
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
