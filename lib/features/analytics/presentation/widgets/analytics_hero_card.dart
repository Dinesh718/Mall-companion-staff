import 'package:flutter/material.dart';
import '../../domain/entities/performance_metrics_entity.dart';


class AnalyticsHeroCard extends StatelessWidget {
  final PerformanceMetricsEntity metrics;

  const AnalyticsHeroCard({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C3AED), Color(0xFF316BF3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.3),
            blurRadius: 20.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background blur decoration
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              width: 160.0,
              height: 160.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
              child: BackdropFilter(
                filter: _BlurFilter(30.0),
                child: Container(),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Progress Circle
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.3),
                          blurRadius: 30.0,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120.0,
                          height: 120.0,
                          child: CircularProgressIndicator(
                            value: metrics.performanceScore / 100,
                            strokeWidth: 10.0,
                            backgroundColor: Colors.white.withValues(alpha: 0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              metrics.performanceScore.toInt().toString(),
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 32.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.0,
                                letterSpacing: -0.02,
                              ),
                            ),
                            const Text(
                              '%',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  // Title & Trend
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Excellent Performance',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.02,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.arrow_drop_up_rounded,
                              color: Color(0xFF34D399), // emerald-400
                              size: 20.0,
                            ),
                            Text(
                              '+${metrics.scoreTrend.toInt()}% vs Last Month',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF34D399),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'You\'re in the ${metrics.topPercentile} of maintenance staff this month.',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14.0,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Container(
                height: 1.0,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCol('COMPLETED', metrics.completedTickets.toString()),
                  ),
                  Container(
                    width: 1.0,
                    height: 40.0,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  Expanded(
                    child: _buildMetricCol('AVG TIME', '${metrics.avgResolutionTimeMinutes}m'),
                  ),
                  Container(
                    width: 1.0,
                    height: 40.0,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  Expanded(
                    child: _buildMetricCol('RATE', '${metrics.efficiencyScore.toInt()}%'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCol(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Work Sans',
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.05,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _BlurFilter extends ColorFilter {
  _BlurFilter(double sigma) : super.matrix([
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);
}
