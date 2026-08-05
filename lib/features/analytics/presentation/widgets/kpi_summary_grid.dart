import 'package:flutter/material.dart';
import '../../domain/entities/performance_metrics_entity.dart';
import '../../../../core/themes/app_colors.dart';

class KpiSummaryGrid extends StatelessWidget {
  final PerformanceMetricsEntity metrics;

  const KpiSummaryGrid({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.85,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildKpiCard(
            icon: Icons.assignment_turned_in_rounded,
            iconColor: const Color(0xFF0051D5), // secondary
            iconBg: const Color(0xFFEFF6FF), // blue-50
            title: 'Completed',
            value: metrics.completedTickets.toString(),
            subtitle: 'Target achieved',
            subtitleColor: const Color(0xFF059669), // emerald-600
          ),
          _buildKpiCard(
            icon: Icons.timer_rounded,
            iconColor: const Color(0xFF630ED4), // primary
            iconBg: const Color(0xFFFAF5FF), // purple-50
            title: 'Avg Res.',
            value: '${metrics.avgResolutionTimeMinutes}',
            valueSuffix: 'min',
            subtitle: '${metrics.avgResolutionTimeTrend > 0 ? '+' : ''}${metrics.avgResolutionTimeTrend.toInt()}% vs avg',
            subtitleColor: const Color(0xFF059669),
          ),
          _buildKpiCard(
            icon: Icons.pending_actions_rounded,
            iconColor: const Color(0xFFEA580C), // orange-600
            iconBg: const Color(0xFFFFF7ED), // orange-50
            title: 'Pending',
            value: metrics.pendingTickets.toString(),
            subtitle: '+${metrics.pendingTicketsTrend} from yesterday',
            subtitleColor: const Color(0xFFEA580C),
          ),
          _buildKpiCard(
            icon: Icons.star_rounded,
            iconColor: const Color(0xFFCA8A04), // yellow-600
            iconBg: const Color(0xFFFEFCE8), // yellow-50
            title: 'Rating',
            value: metrics.customerRating.toStringAsFixed(1),
            subtitle: 'Top 10%',
            subtitleColor: const Color(0xFF059669),
          ),
          _buildKpiCard(
            icon: Icons.speed_rounded,
            iconColor: const Color(0xFF630ED4), // primary
            iconBg: const Color(0xFF7C3AED).withValues(alpha: 0.1),
            title: 'Efficiency',
            value: '${metrics.efficiencyScore.toInt()}',
            valueSuffix: '%',
            subtitle: '+${metrics.efficiencyTrend.toInt()}% vs last week',
            subtitleColor: const Color(0xFF059669),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String value,
    String valueSuffix = '',
    required String subtitle,
    required Color subtitleColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.08),
            blurRadius: 20.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20.0),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14.0,
              color: Color(0xFF4A4455), // on-surface-variant
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF630ED4), // primary
                  height: 1.1,
                ),
              ),
              if (valueSuffix.isNotEmpty) ...[
                const SizedBox(width: 2.0),
                Text(
                  valueSuffix,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF630ED4),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
