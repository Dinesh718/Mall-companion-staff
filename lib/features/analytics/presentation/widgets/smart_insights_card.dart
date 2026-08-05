import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class SmartInsightsCard extends StatelessWidget {
  final List<String> insights;

  const SmartInsightsCard({
    super.key,
    required this.insights,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
        border: Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF7C3AED),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Smart Insights',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                  Text(
                    'Based on your activity this month',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12.0,
                      color: const Color(0xFF4A4455), // on-surface-variant
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ...insights.asMap().entries.map((entry) {
            final isFirst = entry.key == 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.6),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Icon(
                      isFirst ? Icons.check_circle_rounded : Icons.bolt_rounded,
                      color: isFirst ? const Color(0xFF059669) : const Color(0xFF7C3AED),
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
