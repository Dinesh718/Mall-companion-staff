import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../bloc/form/reservation_form_bloc.dart';
import '../../bloc/form/reservation_form_state.dart';
import '../../bloc/form/reservation_form_event.dart';

class CreateReservationBottomBar extends StatelessWidget {
  const CreateReservationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationFormBloc, ReservationFormState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.background,
                AppColors.background.withAlpha(230),
                AppColors.background.withAlpha(0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton.icon(
                      onPressed: state.status == ReservationFormStatus.loading ? null : () {},
                      icon: const Icon(Icons.drafts_rounded, size: 20.0),
                      label: const Text('Save Draft'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.secondary,
                        side: BorderSide(color: AppColors.secondary.withAlpha(102), width: 2.0),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        textStyle: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: state.status == ReservationFormStatus.loading
                          ? null
                          : () {
                              context.read<ReservationFormBloc>().add(SubmitReservation());
                            },
                      icon: state.status == ReservationFormStatus.loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Icon(Icons.check_circle_rounded, size: 20.0),
                      label: Text(
                        state.status == ReservationFormStatus.loading ? 'Creating...' : 'Create Reservation',
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        textStyle: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                        elevation: 8.0,
                        shadowColor: AppColors.primary.withAlpha(128),
                      ).copyWith(
                        backgroundColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.disabled)) return Colors.grey;
                          return null;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }
}
