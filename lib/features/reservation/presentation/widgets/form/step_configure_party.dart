import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../bloc/form/reservation_form_bloc.dart';
import '../../bloc/form/reservation_form_event.dart';
import '../../bloc/form/reservation_form_state.dart';

class StepConfigureParty extends StatelessWidget {
  const StepConfigureParty({super.key});

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
                      '3',
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
                  'CONFIGURE PARTY',
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Guests',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface,
                              ),
                            ),
                            Text(
                              'Party size including children',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14.0,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(24.0),
                          border: Border.all(color: AppColors.outlineVariant.withAlpha(76)),
                        ),
                        child: Row(
                          children: [
                            _buildCircleButton(
                              icon: Icons.remove_rounded,
                              isPrimary: false,
                              onTap: () {
                                if (state.totalGuests > 1) {
                                  // Determine which to subtract: children if >0, else adults
                                  if (state.children > 0) {
                                    context.read<ReservationFormBloc>().add(
                                      UpdateParty(adults: state.adults, children: state.children - 1),
                                    );
                                  } else {
                                    context.read<ReservationFormBloc>().add(
                                      UpdateParty(adults: state.adults - 1, children: state.children),
                                    );
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              width: 32.0,
                              child: Text(
                                state.totalGuests.toString().padLeft(2, '0'),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            _buildCircleButton(
                              icon: Icons.add_rounded,
                              isPrimary: true,
                              onTap: () {
                                context.read<ReservationFormBloc>().add(
                                  UpdateParty(adults: state.adults + 1, children: state.children),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSubCounter(
                          context: context,
                          label: 'Adults',
                          value: state.adults,
                          onAdd: () {
                            context.read<ReservationFormBloc>().add(
                              UpdateParty(adults: state.adults + 1, children: state.children),
                            );
                          },
                          onSubtract: () {
                            if (state.adults > 1) {
                              context.read<ReservationFormBloc>().add(
                                UpdateParty(adults: state.adults - 1, children: state.children),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: _buildSubCounter(
                          context: context,
                          label: 'Children',
                          value: state.children,
                          onAdd: () {
                            context.read<ReservationFormBloc>().add(
                              UpdateParty(adults: state.adults, children: state.children + 1),
                            );
                          },
                          onSubtract: () {
                            if (state.children > 0) {
                              context.read<ReservationFormBloc>().add(
                                UpdateParty(adults: state.adults, children: state.children - 1),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCircleButton({required IconData icon, required bool isPrimary, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          gradient: isPrimary
              ? const LinearGradient(
                  colors: AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isPrimary ? null : Colors.transparent,
          shape: BoxShape.circle,
          border: isPrimary ? null : Border.all(color: AppColors.primary),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(12),
                    blurRadius: 4.0,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          color: isPrimary ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildSubCounter({
    required BuildContext context,
    required String label,
    required int value,
    required VoidCallback onAdd,
    required VoidCallback onSubtract,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.outlineVariant,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                value.toString().padLeft(2, '0'),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: onAdd,
                child: const Icon(Icons.keyboard_arrow_up_rounded, color: AppColors.outline),
              ),
              const SizedBox(height: 4.0),
              GestureDetector(
                onTap: onSubtract,
                child: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
