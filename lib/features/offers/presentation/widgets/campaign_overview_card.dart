// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_entity.dart';

class CampaignOverviewCard extends StatelessWidget {
  final OfferEntity offer;

  const CampaignOverviewCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    // Format Date helper
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    String formatDate(DateTime dt) {
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    }

    final formattedLaunchDate = formatDate(offer.createdAt);
    final offerType = offer.discountType == 'percentage' ? 'Flash Sale' : 'Flat Discount';
    final discountStr = offer.discountType == 'percentage'
        ? '${offer.discountValue.toInt()}%'
        : '\$${offer.discountValue.toInt()}';

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
            children: [
              const Icon(
                Icons.analytics_rounded,
                color: AppColors.primary,
                size: 22.0,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Campaign Overview',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Divider(
            color: AppColors.outlineVariant.withOpacity(0.2),
            height: 1.0,
          ),
          const SizedBox(height: 24.0),

          // Overview Fields Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.8,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 16.0,
            children: [
              _buildOverviewField(
                'Campaign ID',
                offer.id.toUpperCase().replaceAll('_', '-'),
              ),
              _buildOverviewField(
                'Offer Type',
                offerType,
              ),
              _buildCouponField(
                'Coupon Code',
                offer.couponCode,
              ),
              _buildOverviewField(
                'Total Discount',
                discountStr,
              ),
              _buildOverviewField(
                'Admin Owner',
                offer.createdBy ?? 'Mall Admin',
              ),
              _buildOverviewField(
                'Launch Date',
                formattedLaunchDate,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildCouponField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 15.0,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
