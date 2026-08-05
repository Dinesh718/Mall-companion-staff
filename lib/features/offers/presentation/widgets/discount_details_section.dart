// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';

class DiscountDetailsSection extends StatelessWidget {
  final CreateOfferFormEntity form;

  const DiscountDetailsSection({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final discountError = form.validationErrors['discountValue'];
    final couponError = form.validationErrors['couponCode'];

    final discountTypes = ['Percentage', 'Flat Off', 'BOGO', 'Combo'];

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
          // Section Title Header
          Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.payments_outlined,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                'Discount Details',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          // Discount Type Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.95,
            ),
            itemCount: discountTypes.length,
            itemBuilder: (context, index) {
              final type = discountTypes[index];
              final isSelected = form.discountType.toLowerCase() == type.toLowerCase();

              return GestureDetector(
                onTap: () {
                  context.read<CreateOfferBloc>().add(DiscountTypeChanged(type));
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [
                              AppColors.primaryGradientStart,
                              AppColors.primaryGradientEnd,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected ? null : const Color(0xFFF8F9FC),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : const Color(0xFFE5E7EB),
                      width: 1.0,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 8.0,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getIconForType(type),
                        color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                        size: 24.0,
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        type,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20.0),

          // Discount Value and Minimum Purchase input row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Discount Value
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      form.discountType.toLowerCase() == 'percentage'
                          ? 'Discount Value (%)'
                          : 'Discount Value (\$)',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      initialValue: form.discountValue > 0 ? form.discountValue.toStringAsFixed(0) : '',
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        final valD = double.tryParse(val) ?? 0.0;
                        context.read<CreateOfferBloc>().add(DiscountValueChanged(valD));
                      },
                      decoration: _getDecoration(
                        placeholder: form.discountType.toLowerCase() == 'percentage' ? '30' : '15',
                        errorText: discountError,
                      ),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),

              // Min Purchase Amount
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Min. Purchase Amount (\$)',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      initialValue: form.minimumPurchaseAmount > 0 ? form.minimumPurchaseAmount.toStringAsFixed(0) : '',
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        final valD = double.tryParse(val) ?? 0.0;
                        context.read<CreateOfferBloc>().add(MinPurchaseAmountChanged(valD));
                      },
                      decoration: _getDecoration(
                        placeholder: '100',
                      ),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Coupon Code field with inline Auto-gen Toggle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Coupon Code',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6.0),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    key: ValueKey('coupon_field_${form.isAutoGeneratedCoupon}'),
                    initialValue: form.isAutoGeneratedCoupon ? 'AUTO-GENERATED' : form.couponCode,
                    enabled: !form.isAutoGeneratedCoupon,
                    onChanged: (val) {
                      context.read<CreateOfferBloc>().add(CouponCodeChanged(val));
                    },
                    decoration: _getDecoration(
                      placeholder: 'e.g. SUMMER30',
                      errorText: couponError,
                    ).copyWith(
                      contentPadding: const EdgeInsets.only(
                        left: 16.0,
                        right: 120.0,
                        top: 12.0,
                        bottom: 12.0,
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: form.isAutoGeneratedCoupon ? 0.0 : 1.5,
                      color: form.isAutoGeneratedCoupon ? Colors.grey : AppColors.onSurface,
                    ),
                  ),
                  // Auto-gen Toggle container overlay
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Auto-gen',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Switch(
                          value: form.isAutoGeneratedCoupon,
                          onChanged: (val) {
                            context.read<CreateOfferBloc>().add(IsAutoGeneratedCouponChanged(val));
                          },
                          activeColor: Colors.white,
                          activeTrackColor: AppColors.primary,
                          inactiveThumbColor: Colors.grey[400],
                          inactiveTrackColor: Colors.grey[200],
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'percentage':
        return Icons.percent_rounded;
      case 'flat off':
        return Icons.monetization_on_outlined;
      case 'bogo':
        return Icons.shopping_basket_rounded;
      case 'combo':
        return Icons.layers_rounded;
      default:
        return Icons.local_offer_rounded;
    }
  }

  InputDecoration _getDecoration({required String placeholder, String? errorText}) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF3F4F6),
      hintText: placeholder,
      hintStyle: const TextStyle(
        fontFamily: 'Inter',
        color: Colors.grey,
        fontSize: 14.0,
      ),
      errorText: errorText,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2.0,
        ),
      ),
      errorStyle: const TextStyle(
        fontFamily: 'Inter',
        color: AppColors.error,
        fontSize: 11.0,
      ),
    );
  }
}
