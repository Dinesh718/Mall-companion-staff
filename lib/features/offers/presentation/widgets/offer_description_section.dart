import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';

class OfferDescriptionSection extends StatelessWidget {
  final CreateOfferFormEntity form;

  const OfferDescriptionSection({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final charCount = form.description.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Offer Description',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'Provide details to attract more customers.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.0,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$charCount/500',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          initialValue: form.description,
          maxLines: 4,
          maxLength: 500,
          onChanged: (val) {
            context.read<CreateOfferBloc>().add(DescriptionChanged(val));
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
            hintText: 'Describe your offer in detail to attract more customers...',
            hintStyle: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.grey,
              fontSize: 13.0,
            ),
            counterText: '', // Hide standard counter
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
          ),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 13.0,
          ),
        ),
      ],
    );
  }
}
