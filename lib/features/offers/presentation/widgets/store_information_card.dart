// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_entity.dart';

class StoreInformationCard extends StatelessWidget {
  final OfferEntity offer;

  const StoreInformationCard({
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
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Storefront Icon Container
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.15),
              ),
            ),
            child: const Icon(
              Icons.storefront_rounded,
              color: AppColors.primary,
              size: 30.0,
            ),
          ),
          const SizedBox(width: 16.0),

          // Store Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${offer.storeName} Store',
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 6.0),

                // Location Details Row
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.onSurfaceVariant,
                      size: 14.0,
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        offer.storeLocation ?? 'Ground Floor, Wing B (Elite Zone)',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.0,
                          color: AppColors.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),

                // Manager Details Row
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.onSurfaceVariant,
                      size: 14.0,
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        'Manager: ${offer.storeManagerName ?? 'John David'}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.0,
                          color: AppColors.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
