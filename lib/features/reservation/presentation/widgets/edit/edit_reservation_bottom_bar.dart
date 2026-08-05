import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../bloc/form/reservation_form_bloc.dart';
import '../../bloc/form/reservation_form_event.dart';
import '../../bloc/form/reservation_form_state.dart';

class EditReservationBottomBar extends StatelessWidget {
  const EditReservationBottomBar({super.key});

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
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 56.0,
                      child: OutlinedButton(
                        onPressed: state.status == ReservationFormStatus.loading
                            ? null
                            : () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.onSurfaceVariant,
                          side: const BorderSide(color: AppColors.outlineVariant, width: 2.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          textStyle: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text('Discard Changes'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 56.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: state.status == ReservationFormStatus.loading
                              ? null
                              : const LinearGradient(
                                  colors: AppColors.primaryGradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                          color: state.status == ReservationFormStatus.loading ? Colors.grey : null,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: state.status == ReservationFormStatus.loading
                              ? []
                              : [
                                  BoxShadow(
                                    color: AppColors.primary.withAlpha(76),
                                    blurRadius: 15.0,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: state.status == ReservationFormStatus.loading
                                ? null
                                : () {
                                    context.read<ReservationFormBloc>().add(SubmitEditReservation());
                                  },
                            borderRadius: BorderRadius.circular(16.0),
                            child: Center(
                              child: state.status == ReservationFormStatus.loading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                    )
                                  : const Text(
                                      'Save Changes',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
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
