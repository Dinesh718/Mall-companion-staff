import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class KPIMetricData {
  final String label;
  final String value;
  final bool isCritical;

  const KPIMetricData({
    required this.label,
    required this.value,
    this.isCritical = false,
  });
}

class OverviewHeroCard extends StatelessWidget {
  final String title;
  final List<KPIMetricData> metrics;

  const OverviewHeroCard({
    super.key,
    required this.title,
    required this.metrics,
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
            Color(0xFF6B38D4),
            AppColors.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 15.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 22.0, // title-lg
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24.0),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width >= 768 ? 4 : 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.2,
            ),
            itemCount: metrics.length,
            itemBuilder: (context, index) {
              final metric = metrics[index];
              final isCritical = metric.isCritical;
              final Color textColor = isCritical ? AppColors.errorContainer : Colors.white;

              // Break value into number and unit if it contains a space or a character like 'm' (e.g. 2.4m)
              String numberPart = metric.value;
              String unitPart = '';
              
              final match = RegExp(r'^([\d.]+)([a-zA-Z]*)$').firstMatch(metric.value);
              if (match != null) {
                numberPart = match.group(1) ?? metric.value;
                unitPart = match.group(2) ?? '';
              } else if (metric.value.contains(' ')) {
                final parts = metric.value.split(' ');
                numberPart = parts[0];
                unitPart = parts.skip(1).join(' ');
              }

              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: isCritical ? AppColors.error.withAlpha(51) : Colors.white.withAlpha(25), // error/20 or white/10
                  borderRadius: BorderRadius.circular(8.0),
                  border: isCritical ? Border.all(color: AppColors.error.withAlpha(76)) : null, // error/30
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      metric.label.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: textColor.withAlpha(204),
                      ),
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              numberPart,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 32.0, // headline-lg
                                fontWeight: FontWeight.w600,
                                color: textColor,
                                height: 1.25,
                              ),
                            ),
                            if (unitPart.isNotEmpty) ...[
                              const SizedBox(width: 4.0),
                              Text(
                                unitPart,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
