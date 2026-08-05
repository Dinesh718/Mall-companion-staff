// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/shared/presentation/widgets/app_info_card.dart';
import '../../../../core/shared/presentation/widgets/app_status_chip.dart';
import '../../domain/entities/offer_entity.dart';

class OffersOverviewCard extends StatelessWidget {
  final List<OfferEntity> allOffers;

  const OffersOverviewCard({
    super.key,
    required this.allOffers,
  });

  @override
  Widget build(BuildContext context) {
    final activeCount = allOffers.where((o) => o.status == 'Active').length;
    final scheduledCount = allOffers.where((o) => o.status == 'Scheduled').length;
    final draftCount = allOffers.where((o) => o.status == 'Draft').length;

    return AppInfoCard(
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      gradient: const LinearGradient(
        colors: [
          Color(0xFF7B2FF7), // primary gradient start
          Color(0xFF3B82F6), // primary gradient end
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Campaign Overview Texts (fully visible on the left side)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CAMPAIGN OVERVIEW',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      '${allOffers.length} Total Campaigns',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),

              // Shop Logo and Name Badge (positioned in the top right, in normal flow to prevent clipping)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(99.0),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2.0),
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAfjw1trdoiYkG2FhmysKApG4k3T7_qIWd263QW5l7NlXYJMEYw_YYZN6Kl-4MIAv4jZHuIdirzwRKBJ8_SBaiknr-S8m2-BblZaR88Unsi1v97pJIClJ3GUKGUmGLMcp-hy4VFWq8HNT-YLkM576DJpt8IWja8yVLSif2dmfYk3Ffj6okrn3q8R8INInvXKJzO-NCb3GuJv_Fvj91TDjSdlSu2ifva2reuEZ-HlqzCJdduAfL0aj5V2RljB2wedwySYeF0EcuGLg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    const Text(
                      'Nike Flagship',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const Icon(
                      Icons.verified_rounded,
                      color: Colors.blueAccent,
                      size: 12.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          // Horizontal list of quick status pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                AppStatusChip(
                  label: 'Active: $activeCount',
                  textColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.15),
                  borderColor: Colors.white.withOpacity(0.1),
                  pulsingDotColor: const Color(0xFF4ADE80), // Green dot
                ),
                const SizedBox(width: 8.0),
                AppStatusChip(
                  label: 'Scheduled: $scheduledCount',
                  textColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.15),
                  borderColor: Colors.white.withOpacity(0.1),
                ),
                const SizedBox(width: 8.0),
                AppStatusChip(
                  label: 'Draft: $draftCount',
                  textColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.15),
                  borderColor: Colors.white.withOpacity(0.1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
