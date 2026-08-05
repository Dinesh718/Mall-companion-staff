import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/security_dashboard_entity.dart';

class SecurityHeroCard extends StatelessWidget {
  final SecurityOfficerEntity officer;
  final HeroMetricsEntity metrics;

  const SecurityHeroCard({
    super.key,
    required this.officer,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.primaryGradient,
        ),
        borderRadius: BorderRadius.circular(24.0), // Rounded 3xl in tailwind is typically 24
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 15.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circle overlay
          Positioned(
            right: -48,
            bottom: -48,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 64.0,
                            height: 64.0,
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(51),
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.white.withAlpha(76)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.0),
                              child: Image.network(
                                officer.avatarUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  officer.name,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(51),
                                        borderRadius: BorderRadius.circular(100.0),
                                      ),
                                      child: Text(
                                        officer.role,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        '#${officer.employeeId}',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white.withAlpha(204),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withAlpha(51),
                            border: Border.all(color: Colors.greenAccent.withAlpha(76)),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8.0,
                                height: 8.0,
                                decoration: const BoxDecoration(
                                  color: Colors.greenAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6.0),
                              Text(
                                officer.dutyStatus.toUpperCase(),
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          officer.assignedZone,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          officer.currentShift,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withAlpha(204),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        'Active Incidents',
                        metrics.activeIncidents.toString().padLeft(2, '0'),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: _buildMetricCard(
                        'Patrol Prog.',
                        '${metrics.patrolProgressPercentage.toInt()}%',
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: _buildMetricCard(
                        'Avg Resp.',
                        '${metrics.averageResponseTimeMinutes.toStringAsFixed(1)}m',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25),
        border: Border.all(color: Colors.white.withAlpha(25)),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Colors.white.withAlpha(178),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
