// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_entity.dart';

class CampaignDescriptionCard extends StatelessWidget {
  final OfferEntity offer;

  const CampaignDescriptionCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
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
                Icons.description_rounded,
                color: AppColors.primary,
                size: 22.0,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Strategic Context',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Strategic Context Text Wrapper
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FC),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: AppColors.outlineVariant.withOpacity(0.15),
              ),
            ),
            child: Text(
              offer.description,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.0,
                height: 1.6,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
