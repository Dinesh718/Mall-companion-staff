// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';

class CampaignBannerSection extends StatelessWidget {
  final CreateOfferFormEntity form;

  const CampaignBannerSection({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final mockBanners = [
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=600&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1511556532299-8f662fc26c06?q=80&w=600&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=600&auto=format&fit=crop',
    ];

    void simulateBannerUpload() {
      // Pick one randomly or cycle
      final currentIdx = mockBanners.indexOf(form.bannerUrl);
      final nextIdx = (currentIdx + 1) % mockBanners.length;
      final selectedBanner = mockBanners[nextIdx];

      context.read<CreateOfferBloc>().add(BannerSelected(selectedBanner));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Campaign banner simulated upload success!'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Campaign Banner',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 16.0),

          // Upload Container
          GestureDetector(
            onTap: simulateBannerUpload,
            child: form.bannerUrl.isNotEmpty
                ? Stack(
                    children: [
                      Container(
                        height: 180.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          image: DecorationImage(
                            image: NetworkImage(form.bannerUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10.0,
                        right: 10.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit_rounded, color: Colors.white, size: 14.0),
                              SizedBox(width: 4.0),
                              Text(
                                'Change',
                                style: TextStyle(color: Colors.white, fontSize: 11.0, fontFamily: 'Inter'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(24.0),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        style: BorderStyle.none, // custom dash via border painting
                      ),
                    ),
                    child: Column(
                      children: [
                        // Upload icon container with gradient
                        Container(
                          width: 56.0,
                          height: 56.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryGradientStart,
                                AppColors.primaryGradientEnd,
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.cloud_upload_rounded,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Click to upload banner image',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'Formats: PNG, JPEG, WEBP (Max 5MB). Recommended: 1200x600px',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
