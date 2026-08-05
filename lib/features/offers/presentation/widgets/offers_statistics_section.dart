// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_entity.dart';

class OffersStatisticsSection extends StatelessWidget {
  final List<OfferEntity> allOffers;

  const OffersStatisticsSection({
    super.key,
    required this.allOffers,
  });

  @override
  Widget build(BuildContext context) {
    final activeCount = allOffers.where((o) => o.status == 'Active').length;
    final scheduledCount = allOffers.where((o) => o.status == 'Scheduled').length;
    final expiredCount = allOffers.where((o) => o.status == 'Expired').length;

    // Redemptions sum calculation
    final totalRedemptions = allOffers.fold<int>(0, (sum, o) => sum + o.redemptions);
    final String redemptionsStr = totalRedemptions >= 1000
        ? '${(totalRedemptions / 1000).toStringAsFixed(1)}k'
        : totalRedemptions.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.15,
        children: [
          _buildStatCard(
            icon: Icons.campaign_rounded,
            value: activeCount.toString().padLeft(2, '0'),
            label: 'Active Offers',
            iconColor: AppColors.primary,
            bgColor: AppColors.primary.withOpacity(0.08),
            trendText: '↑ +2',
            trendLabel: 'TW',
            trendColor: const Color(0xFF22C55E),
          ),
          _buildStatCard(
            icon: Icons.schedule_rounded,
            value: scheduledCount.toString().padLeft(2, '0'),
            label: 'Scheduled',
            iconColor: AppColors.secondary,
            bgColor: AppColors.secondary.withOpacity(0.08),
            trendText: '0',
            trendLabel: 'CHG',
            trendColor: AppColors.onSurfaceVariant.withOpacity(0.6),
          ),
          _buildStatCard(
            icon: Icons.event_busy_rounded,
            value: expiredCount.toString().padLeft(2, '0'),
            label: 'Expired',
            iconColor: AppColors.error,
            bgColor: AppColors.error.withOpacity(0.08),
            trendText: '↓ -1',
            trendLabel: 'YES',
            trendColor: const Color(0xFFEF4444),
          ),
          _buildStatCard(
            icon: Icons.confirmation_number_outlined,
            value: redemptionsStr,
            label: 'Redemptions',
            iconColor: AppColors.primary, // surface-tint matches primary
            bgColor: AppColors.primary.withOpacity(0.08),
            trendText: '↑ 12%',
            trendLabel: 'MOM',
            trendColor: const Color(0xFF22C55E),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
    required Color bgColor,
    required String trendText,
    required String trendLabel,
    required Color trendColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.03),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20.0,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trendText,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: trendColor,
                    ),
                  ),
                  const SizedBox(width: 2.0),
                  Text(
                    trendLabel,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 8.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurfaceVariant.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4.0),
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
            ],
          ),
        ],
      ),
    );
  }
}
