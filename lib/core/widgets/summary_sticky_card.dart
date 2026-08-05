import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class SummaryStickyData {
  final String label;
  final String value;
  final bool isPrimary;
  final bool isError;
  final bool isOutline;

  const SummaryStickyData({
    required this.label,
    required this.value,
    this.isPrimary = false,
    this.isError = false,
    this.isOutline = false,
  });
}

class SummaryStickyCard extends StatelessWidget {
  final List<SummaryStickyData> items;

  const SummaryStickyCard({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 88.0, // above bottom nav
      left: 16.0,
      right: 16.0,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800.0), // suitable for both mobile and web
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.surface.withAlpha(230), // surface/90
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.outlineVariant.withAlpha(51)), // outline-variant/20
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(12),
                  blurRadius: 15.0,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(items.length * 2 - 1, (index) {
                if (index.isOdd) {
                  return Container(
                    width: 1.0,
                    height: 32.0,
                    color: AppColors.outlineVariant.withAlpha(76),
                  );
                }
                
                final itemIndex = index ~/ 2;
                final item = items[itemIndex];
                
                Color valueColor = AppColors.onSurface;
                if (item.isPrimary) valueColor = AppColors.primary;
                if (item.isError) valueColor = AppColors.error;
                if (item.isOutline) valueColor = AppColors.outline;

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.label,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.outline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        item.value,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 22.0, // title-lg
                          fontWeight: FontWeight.bold,
                          color: valueColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
