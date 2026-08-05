import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../bloc/form/reservation_form_bloc.dart';
import '../../bloc/form/reservation_form_event.dart';
import '../../bloc/form/reservation_form_state.dart';

class StepCustomerDetails extends StatelessWidget {
  const StepCustomerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationFormBloc, ReservationFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                const Text(
                  'CUSTOMER DETAILS',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(color: AppColors.outlineVariant),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(12),
                    blurRadius: 4.0,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48.0,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainer,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search_rounded, color: AppColors.outline, size: 20.0),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search existing customer...',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.0,
                                      color: AppColors.outline,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14.0,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.person_add_rounded, size: 20.0),
                        label: const Text('New'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          textStyle: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  _buildInputField(
                    label: 'Full Name',
                    value: state.customerName,
                    onChanged: (val) {
                      context.read<ReservationFormBloc>().add(
                        UpdateCustomerDetails(
                          name: val,
                          email: state.customerEmail,
                          phone: state.customerPhone,
                          notificationPreference: state.notificationPreference,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          label: 'Email Address',
                          value: state.customerEmail,
                          onChanged: (val) {
                            context.read<ReservationFormBloc>().add(
                              UpdateCustomerDetails(
                                name: state.customerName,
                                email: val,
                                phone: state.customerPhone,
                                notificationPreference: state.notificationPreference,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: _buildInputField(
                          label: 'Contact Number',
                          value: state.customerPhone,
                          onChanged: (val) {
                            context.read<ReservationFormBloc>().add(
                              UpdateCustomerDetails(
                                name: state.customerName,
                                email: state.customerEmail,
                                phone: val,
                                notificationPreference: state.notificationPreference,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'NOTIFICATION PREFERENCE',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.outlineVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: AppColors.outlineVariant.withAlpha(76)),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: _buildSegmentButton(context, 'SMS', state.notificationPreference)),
                        Expanded(child: _buildSegmentButton(context, 'Email', state.notificationPreference)),
                        Expanded(child: _buildSegmentButton(context, 'WhatsApp', state.notificationPreference)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputField({
    required String label,
    required String value,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16.0,
        color: AppColors.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        filled: true,
        fillColor: AppColors.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildSegmentButton(BuildContext context, String label, String selectedValue) {
    final isSelected = label == selectedValue;
    return GestureDetector(
      onTap: () {
        final state = context.read<ReservationFormBloc>().state;
        context.read<ReservationFormBloc>().add(
          UpdateCustomerDetails(
            name: state.customerName,
            email: state.customerEmail,
            phone: state.customerPhone,
            notificationPreference: label,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(12),
                    blurRadius: 4.0,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
