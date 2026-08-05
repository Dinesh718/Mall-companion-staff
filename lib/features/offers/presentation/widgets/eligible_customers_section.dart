// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';

class EligibleCustomersSection extends StatelessWidget {
  final CreateOfferFormEntity form;

  const EligibleCustomersSection({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final audiences = ['All Visitors', 'Mall Members', 'First-Time', 'Premium'];

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
            'Eligible Customers',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 16.0),

          // Selector grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 2.5,
            ),
            itemCount: audiences.length,
            itemBuilder: (context, index) {
              final audience = audiences[index];
              final isSelected = form.audience == audience;

              return GestureDetector(
                onTap: () {
                  context.read<CreateOfferBloc>().add(AudienceChanged(audience));
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withOpacity(0.05) : const Color(0xFFF8F9FC),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getIconForAudience(audience),
                        color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                        size: 18.0,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          audience,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getIconForAudience(String audience) {
    switch (audience.toLowerCase()) {
      case 'all visitors':
        return Icons.group_rounded;
      case 'mall members':
        return Icons.card_membership_rounded;
      case 'first-time':
        return Icons.person_add_rounded;
      case 'premium':
        return Icons.workspace_premium_rounded;
      default:
        return Icons.people_outline_rounded;
    }
  }
}
