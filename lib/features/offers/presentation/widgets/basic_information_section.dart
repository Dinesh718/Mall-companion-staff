// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';

class BasicInformationSection extends StatelessWidget {
  final CreateOfferFormEntity form;

  const BasicInformationSection({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final titleError = form.validationErrors['title'];

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
                  color: AppColors.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                'Basic Information',
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

          // Title Input Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Campaign Title',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6.0),
              TextFormField(
                initialValue: form.title,
                onChanged: (val) {
                  context.read<CreateOfferBloc>().add(TitleChanged(val));
                },
                decoration: _getDecoration(
                  placeholder: 'e.g. Summer Fashion Blast',
                  errorText: titleError,
                ),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Store Branch Selection Option
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Store Branch',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6.0),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: form.storeBranch,
                items: const [
                  DropdownMenuItem(
                    value: 'Nike Flagship Store - Floor 2',
                    child: Text('Nike Flagship Store - Floor 2', overflow: TextOverflow.ellipsis, maxLines: 1),
                  ),
                  DropdownMenuItem(
                    value: 'Nike Concept - Floor 1',
                    child: Text('Nike Concept - Floor 1', overflow: TextOverflow.ellipsis, maxLines: 1),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) {
                    context.read<CreateOfferBloc>().add(StoreBranchChanged(val));
                  }
                },
                decoration: _getDecoration(placeholder: ''),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  color: AppColors.onSurface,
                ),
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Grid for Category and Campaign Type
          Row(
            children: [
              // Category
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: form.category,
                      items: const [
                        DropdownMenuItem(
                          value: 'Fashion & Apparel',
                          child: Text('Fashion & Apparel', overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                        DropdownMenuItem(
                          value: 'Footwear',
                          child: Text('Footwear', overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                        DropdownMenuItem(
                          value: 'Sports',
                          child: Text('Sports', overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          context.read<CreateOfferBloc>().add(CategoryChanged(val));
                        }
                      },
                      decoration: _getDecoration(placeholder: ''),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        color: AppColors.onSurface,
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),

              // Campaign Type
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Campaign Type',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: form.offerType,
                      items: const [
                        DropdownMenuItem(
                          value: 'Seasonal Sale',
                          child: Text('Seasonal Sale', overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                        DropdownMenuItem(
                          value: 'Flash Sale',
                          child: Text('Flash Sale', overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                        DropdownMenuItem(
                          value: 'New Collection',
                          child: Text('New Collection', overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          context.read<CreateOfferBloc>().add(OfferTypeChanged(val));
                        }
                      },
                      decoration: _getDecoration(placeholder: ''),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        color: AppColors.onSurface,
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
