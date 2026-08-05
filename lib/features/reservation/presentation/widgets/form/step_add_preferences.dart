import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../bloc/form/reservation_form_bloc.dart';
import '../../bloc/form/reservation_form_state.dart';
import '../../bloc/form/reservation_form_event.dart';

class StepAddPreferences extends StatelessWidget {
  const StepAddPreferences({super.key});

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
                      '4',
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
                  'ADD PREFERENCES',
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
            
            // Occasion
            const Padding(
              padding: EdgeInsets.only(left: 4.0, bottom: 12.0),
              child: Text(
                'OCCASION',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildChip(context, 'Standard', state.occasion, isOccasion: true),
                _buildChip(context, 'Birthday', state.occasion, icon: Icons.cake_rounded, isOccasion: true),
                _buildChip(context, 'Anniversary', state.occasion, isOccasion: true),
                _buildChip(context, 'Business', state.occasion, isOccasion: true),
              ],
            ),
            const SizedBox(height: 24.0),

            // Seating Preference
            const Padding(
              padding: EdgeInsets.only(left: 4.0, bottom: 12.0),
              child: Text(
                'SEATING PREFERENCE',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildChip(context, 'Any', state.seatingPreference, isOccasion: false),
                _buildChip(context, 'Window', state.seatingPreference, icon: Icons.window_rounded, isOccasion: false),
                _buildChip(context, 'Quiet Zone', state.seatingPreference, isOccasion: false),
                _buildChip(context, 'Outdoor', state.seatingPreference, isOccasion: false),
              ],
            ),
            const SizedBox(height: 24.0),

            // Special Requests
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: AppColors.outlineVariant.withAlpha(76)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Special Requests',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    onChanged: (val) {
                      context.read<ReservationFormBloc>().add(
                        UpdatePreferences(
                          occasion: state.occasion,
                          seatingPreference: state.seatingPreference,
                          specialRequests: val,
                          internalNotes: state.internalNotes,
                        ),
                      );
                    },
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Allergies, high chair, birthday message...',
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        color: AppColors.outlineVariant,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.mic_rounded, color: AppColors.outlineVariant),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChip(BuildContext context, String label, String selectedValue, {IconData? icon, required bool isOccasion}) {
    final isSelected = label == selectedValue;
    return GestureDetector(
      onTap: () {
        final state = context.read<ReservationFormBloc>().state;
        context.read<ReservationFormBloc>().add(
          UpdatePreferences(
            occasion: isOccasion ? label : state.occasion,
            seatingPreference: isOccasion ? state.seatingPreference : label,
            specialRequests: state.specialRequests,
            internalNotes: state.internalNotes,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          border: isSelected ? null : Border.all(color: AppColors.outlineVariant),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(51),
                    blurRadius: 14.0,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18.0, color: isSelected ? Colors.white : AppColors.onSurfaceVariant),
              const SizedBox(width: 8.0),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
