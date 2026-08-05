// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/maintenance_dashboard_entity.dart';

class MaintenanceHeroCard extends StatelessWidget {
  final MaintenanceDashboardEntity dashboard;

  const MaintenanceHeroCard({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF8B5CF6), // Violet
              Color(0xFF3B82F6), // Blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.3),
              blurRadius: 20.0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Work",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              "Focus on high-priority issues first.",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.0,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: _MetricBox(
                    label: 'ASSIGNED',
                    value: dashboard.assignedCount.toString().padLeft(2, '0'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _MetricBox(
                    label: 'PRIORITY',
                    value: dashboard.priorityCount.toString().padLeft(2, '0'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: _MetricBox(
                    label: 'IN PROGRESS',
                    value: dashboard.inProgressCount.toString().padLeft(2, '0'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _MetricBox(
                    label: 'COMPLETED',
                    value: dashboard.completedCount.toString().padLeft(2, '0'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricBox extends StatelessWidget {
  final String label;
  final String value;

  const _MetricBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
