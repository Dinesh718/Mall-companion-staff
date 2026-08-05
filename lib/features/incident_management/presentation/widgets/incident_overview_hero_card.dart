import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/incident_overview_entity.dart';

class IncidentOverviewHeroCard extends StatelessWidget {
  final IncidentOverviewEntity overview;

  const IncidentOverviewHeroCard({
    super.key,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6B38D4), // primary variant from Stitch
            AppColors.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25), // shadow-lg approx
            blurRadius: 15.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.5,
        children: [
          _buildStatCard(
            'Active',
            overview.activeIncidents.toString(),
            Icons.assignment_outlined,
            false,
          ),
          _buildStatCard(
            'Critical',
            overview.criticalIncidents.toString(),
            Icons.warning_amber_rounded,
            true,
          ),
          _buildStatCard(
            'Assigned',
            overview.assignedIncidents.toString(),
            Icons.person_outline,
            false,
          ),
          _buildStatCard(
            'Avg Response',
            '${overview.averageResponseTime} min',
            Icons.timer_outlined,
            false,
            isTime: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, bool isError, {bool isTime = false}) {
    final Color textColor = isError ? AppColors.errorContainer : Colors.white;
    final Color iconColor = isError ? AppColors.errorContainer : Colors.white.withAlpha(153); // ~60% opacity

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25), // bg-white/10
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0, // label-md
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withAlpha(204), // ~80% opacity
                ),
              ),
              Icon(
                icon,
                size: 16.0,
                color: iconColor,
              ),
            ],
          ),
          if (isTime)
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value.split(' ')[0],
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 32.0, // headline-lg
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    height: 1.25,
                  ),
                ),
                const SizedBox(width: 4.0),
                Text(
                  value.split(' ')[1],
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            )
          else
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 32.0, // headline-lg
                fontWeight: FontWeight.w600,
                color: textColor,
                height: 1.25,
              ),
            ),
        ],
      ),
    );
  }
}
