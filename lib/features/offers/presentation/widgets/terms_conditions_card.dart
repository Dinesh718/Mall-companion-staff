// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_entity.dart';

class TermsConditionsCard extends StatefulWidget {
  final OfferEntity offer;

  const TermsConditionsCard({
    super.key,
    required this.offer,
  });

  @override
  State<TermsConditionsCard> createState() => _TermsConditionsCardState();
}

class _TermsConditionsCardState extends State<TermsConditionsCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final terms = widget.offer.termsAndConditions ?? [
      'Offer valid only at Nike Flagship Store, Wing B.',
      'Cannot be combined with other ongoing mall-wide promotions.',
      '30% discount applies to MSRP on selected items only.',
      'Coupon NIKE30 must be presented at the point of sale.'
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header Trigger Button
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: AppColors.outlineVariant.withOpacity(0.2),
                      ),
                    ),
                    child: const Icon(
                      Icons.policy_rounded,
                      color: AppColors.onSurfaceVariant,
                      size: 24.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          _isExpanded ? 'Tap to collapse policies' : 'Tap to view campaign legal policies',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.expand_circle_down_outlined,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable Body Content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: AppColors.outlineVariant.withOpacity(0.2),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(99.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified_user_rounded,
                          color: AppColors.primary,
                          size: 14.0,
                        ),
                        const SizedBox(width: 6.0),
                        const Text(
                          'Verified Policies',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: terms.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12.0),
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.primary,
                            size: 16.0,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              terms[index],
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13.0,
                                height: 1.5,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
