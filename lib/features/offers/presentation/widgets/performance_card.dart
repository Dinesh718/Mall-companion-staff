// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_entity.dart';

class PerformanceCard extends StatelessWidget {
  final OfferEntity offer;

  const PerformanceCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    // Read dynamic metric properties
    final totalViewsStr = offer.views >= 1000 ? '${(offer.views / 1000).toStringAsFixed(0)}k' : '${offer.views}';
    final claimsStr = offer.redemptions >= 1000 ? '${(offer.redemptions / 1000).toStringAsFixed(1)}k' : '${offer.redemptions}';
    final conversionRateStr = offer.conversionRate != null ? '${offer.conversionRate!.toInt()}%' : '35%';
    final bestDay = offer.bestPerformingDay ?? 'Saturday';
    final peakHour = offer.peakHour ?? '18:00 - 20:00';
    final todayRedemptionsVal = offer.todayRedemptions ?? 248;
    final todayViewsVal = offer.todayViews ?? 1824;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.insights_rounded,
                      color: AppColors.primary,
                      size: 22.0,
                    ),
                    const SizedBox(width: 8.0),
                    const Expanded(
                      child: Text(
                        'Live Performance Metrics',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(99.0),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6.0,
                      height: 6.0,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryGradientEnd,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    const Text(
                      'Live: Every 5m',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 9.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          // Layout splits for Responsive rendering (Column on mobile, Row on larger screens)
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 500;
              final indicatorRow = Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCircularIndicator(0.83, totalViewsStr, 'Total Views', AppColors.primaryGradientStart),
                  _buildCircularIndicator(0.55, claimsStr, 'Claims', AppColors.primaryGradientEnd),
                  _buildCircularIndicator(0.35, conversionRateStr, 'Conv. Rate', Colors.green),
                ],
              );

              final metricsGrid = GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2.2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: [
                  _buildMetricField('Best Day', bestDay, isPrimary: true),
                  _buildMetricField('Peak Hour', peakHour, isPrimary: true),
                  _buildMetricField("Today's Claims", '$todayRedemptionsVal Units'),
                  _buildMetricField("Today's Views", todayViewsVal.toString()),
                ],
              );

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: indicatorRow),
                    Container(
                      width: 1.0,
                      height: 100.0,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      color: AppColors.outlineVariant.withOpacity(0.2),
                    ),
                    Expanded(flex: 5, child: metricsGrid),
                  ],
                );
              } else {
                return Column(
                  children: [
                    indicatorRow,
                    const SizedBox(height: 24.0),
                    Divider(
                      color: AppColors.outlineVariant.withOpacity(0.2),
                      height: 1.0,
                    ),
                    const SizedBox(height: 24.0),
                    metricsGrid,
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator(double progress, String centerText, String label, Color progressColor) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 56.0,
              height: 56.0,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 5.0,
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
            ),
            Text(
              centerText,
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 12.0,
                fontWeight: FontWeight.w900,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 8.0,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricField(String label, String value, {bool isPrimary = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: isPrimary ? AppColors.primary : AppColors.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
