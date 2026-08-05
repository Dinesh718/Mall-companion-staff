// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/maintenance_dashboard_entity.dart';

class PerformanceSummarySection extends StatelessWidget {
  final MaintenanceDashboardEntity dashboard;

  const PerformanceSummarySection({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Performance Summary',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _SummaryBox(
                  label: 'RESOLVED TODAY',
                  value: dashboard.resolvedToday.toString().padLeft(2, '0'),
                  unit: 'Tickets',
                  valueColor: const Color(0xFF111827),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _SummaryBox(
                  label: 'AVG. RESOLUTION',
                  value: dashboard.avgResolutionMins.toString().padLeft(2, '0'),
                  unit: 'Min',
                  valueColor: const Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _SummaryBox(
                  label: 'SLA COMPLIANCE',
                  value: '${dashboard.slaCompliancePercent}%',
                  valueColor: const Color(0xFF3B82F6), // Blue
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _SummaryBox(
                  label: 'PENDING TASKS',
                  value: dashboard.pendingTasks.toString().padLeft(2, '0'),
                  valueColor: const Color(0xFFDC2626), // Red
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final Color valueColor;

  const _SummaryBox({
    required this.label,
    required this.value,
    this.unit,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Note: using withOpacity but we will ignore the lint later
            blurRadius: 16.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 6.0),
                Text(
                  unit!,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
