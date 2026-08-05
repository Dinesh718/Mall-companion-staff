// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';

class ApplicableCategoriesSection extends StatelessWidget {
  final CreateOfferFormEntity form;

  const ApplicableCategoriesSection({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final allCategories = ['Fashion', 'Footwear', 'Accessories', 'Lifestyle', 'Sports', 'Beauty', 'Electronics', 'Dining'];

    final isAllSelected = form.applicableCategories.length == allCategories.length;

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
            'Applicable Categories',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 16.0),

          // Wrap of chips
          Wrap(
            spacing: 8.0,
            runSpacing: 10.0,
            children: [
              // Select All chip
              GestureDetector(
                onTap: () {
                  if (isAllSelected) {
                    context.read<CreateOfferBloc>().add(const CategoriesChanged([]));
                  } else {
                    context.read<CreateOfferBloc>().add(CategoriesChanged(List.from(allCategories)));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(99.0),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    isAllSelected ? 'Deselect All' : 'Select All',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              // Normal category chips
              ...allCategories.map((category) {
                final isSelected = form.applicableCategories.contains(category);

                return GestureDetector(
                  onTap: () {
                    final currentList = List<String>.from(form.applicableCategories);
                    if (isSelected) {
                      currentList.remove(category);
                    } else {
                      currentList.add(category);
                    }
                    context.read<CreateOfferBloc>().add(CategoriesChanged(currentList));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [
                                AppColors.primaryGradientStart,
                                AppColors.primaryGradientEnd,
                              ],
                            )
                          : null,
                      color: isSelected ? null : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(99.0),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.2),
                                blurRadius: 4.0,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : null,
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
