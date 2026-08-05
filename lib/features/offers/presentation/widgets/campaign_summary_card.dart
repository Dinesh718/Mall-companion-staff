// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_entity.dart';

class CampaignSummaryCard extends StatelessWidget {
  final OfferEntity offer;

  const CampaignSummaryCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    // Format Updated At
    final String lastUpdatedStr = 'Today, 10:45 AM'; // Can format from offer.updatedAt if desired

    // Status Styling
    final isDraft = offer.status.toLowerCase() == 'draft';
    final statusBgColor = isDraft ? const Color(0xFFFEF3C7) : const Color(0xFFDCFCE7);
    final statusTextColor = isDraft ? const Color(0xFFD97706) : const Color(0xFF15803D);

    return Container(
      height: 130.0,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryGradientStart,
            AppColors.primaryGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 16.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background decorative bubbles
          Positioned(
            top: -24.0,
            right: -24.0,
            child: Container(
              width: 96.0,
              height: 96.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: 8.0,
            left: 40.0,
            child: Container(
              width: 64.0,
              height: 64.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // Content Layer
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer.title,
                            style: const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              Text(
                                offer.id.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 11.0,
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 4.0,
                                height: 4.0,
                                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                              const Icon(
                                Icons.store_rounded,
                                size: 12.0,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: Text(
                                  offer.storeName,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11.0,
                                    color: Colors.white.withOpacity(0.9),
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
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(99.0),
                      ),
                      child: Text(
                        offer.status.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 9.0,
                          fontWeight: FontWeight.bold,
                          color: statusTextColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 14.0,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          'Last Updated: $lastUpdatedStr',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.confirmation_number_outlined,
                      size: 24.0,
                      color: Colors.white.withOpacity(0.4),
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
