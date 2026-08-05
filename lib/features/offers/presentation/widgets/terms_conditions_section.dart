import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';

class TermsConditionsSection extends StatelessWidget {
  final CreateOfferFormEntity form;

  const TermsConditionsSection({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final String currentTermsText = form.termsAndConditions.join('\n');

    void importTemplate() {
      final templateTerms = [
        'Offer valid only at selected branch.',
        'Cannot be combined with other ongoing promotions.',
        'Must present coupon code at checkout.',
        'Excludes sales tax and delivery charges.',
        'Limited to one redemption per customer.'
      ];
      context.read<CreateOfferBloc>().add(TermsChanged(templateTerms));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Standard template terms imported!'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

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
                    'Terms & Conditions',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'List mandatory requirements and usage limits.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.0,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: importTemplate,
              child: const Text(
                'Import Template',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          key: ValueKey('terms_field_${form.termsAndConditions.length}'),
          initialValue: currentTermsText,
          maxLines: 4,
          onChanged: (val) {
            final list = val.split('\n').where((s) => s.trim().isNotEmpty).toList();
            context.read<CreateOfferBloc>().add(TermsChanged(list));
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
            hintText: 'List mandatory requirements, exclusion dates, and usage limits (one per line)...',
            hintStyle: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.grey,
              fontSize: 13.0,
            ),
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
