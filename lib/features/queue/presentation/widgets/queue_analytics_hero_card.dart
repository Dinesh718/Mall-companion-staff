// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class QueueAnalyticsHeroCard extends StatelessWidget {
  final int totalCustomers;
  final int completedCount;
  final double completedChange;
  final int waitingCount;
  final int avgWaitMinutes;
  final String avgWaitStatus;
  final DateTime lastUpdated;

  const QueueAnalyticsHeroCard({
    super.key,
    required this.totalCustomers,
    required this.completedCount,
    required this.completedChange,
    required this.waitingCount,
    required this.avgWaitMinutes,
    required this.avgWaitStatus,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final minutesAgo = DateTime.now().difference(lastUpdated).inMinutes.clamp(0, 59);
    final updatedText = minutesAgo <= 1 ? 'Just updated' : '$minutesAgo min ago';

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGradientStart.withOpacity(0.3),
            blurRadius: 16.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Icon overlay
          Positioned(
            right: -40.0,
            top: -40.0,
            child: Opacity(
              opacity: 0.08,
              child: Icon(
                Icons.analytics_rounded,
                size: 280.0,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "TODAY'S CUSTOMERS",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '$totalCustomers',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 48.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            const Text(
                              'Users',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                 Text(
                  'Last Updated: $updatedText',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0x80FFFFFF),
                  ),
                ),
                const SizedBox(height: 24.0),
                Container(
                  height: 1.0,
                  color: Colors.white10,
                ),
                const SizedBox(height: 20.0),
                // Horizontal KPI row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSubStat(
                      title: 'COMPLETED',
                      value: '$completedCount',
                      badgeText: '↑ ${(completedChange * 100).toInt()}%',
                      badgeColor: Colors.greenAccent,
                      badgeTextColor: Colors.green.shade900,
                    ),
                    _buildSubStat(
                      title: 'WAITING',
                      value: '$waitingCount',
                      badgeText: 'LIVE',
                      badgeColor: Colors.white24,
                      badgeTextColor: Colors.white,
                    ),
                    _buildSubStat(
                      title: 'AVG WAIT',
                      value: '${avgWaitMinutes}m',
                      badgeText: avgWaitStatus,
                      badgeColor: Colors.transparent,
                      badgeTextColor: Colors.white70,
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

  Widget _buildSubStat({
    required String title,
    required String value,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: Colors.white70,
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
        const SizedBox(height: 4.0),
        if (badgeColor == Colors.transparent)
          Text(
            badgeText,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10.0,
              color: badgeTextColor,
            ),
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              badgeText,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 8.0,
                fontWeight: FontWeight.bold,
                color: badgeTextColor,
              ),
            ),
          ),
      ],
    );
  }
}
