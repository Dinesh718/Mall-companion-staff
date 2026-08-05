import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/reservation_details_entity.dart';
import '../../domain/usecases/create_reservation_usecase.dart';
import '../../domain/usecases/edit_reservation_usecase.dart';
import '../../data/repositories/mock_reservation_repository.dart';
import '../bloc/form/reservation_form_bloc.dart';
import '../bloc/form/reservation_form_event.dart';
import '../bloc/form/reservation_form_state.dart';

import '../widgets/edit/edit_reservation_overview.dart';
import '../widgets/edit/edit_reservation_bottom_bar.dart';
import '../widgets/form/step_customer_details.dart';
import '../widgets/form/step_choose_schedule.dart';
import '../widgets/form/step_configure_party.dart';
import '../widgets/form/step_add_preferences.dart';

class EditReservationPage extends StatelessWidget {
  final ReservationDetailsEntity details;

  const EditReservationPage({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    // In a real app, inject this via service locator (e.g. get_it)
    final mockRepo = MockReservationRepository();

    return BlocProvider(
      create: (context) {
        final bloc = ReservationFormBloc(
          createReservationUseCase: CreateReservationUseCase(mockRepo),
          editReservationUseCase: EditReservationUseCase(mockRepo),
        );

        // Load the existing reservation data into the form bloc
        bloc.add(LoadEditData(
          reservationId: details.baseInfo.id,
          customerName: details.baseInfo.customerName,
          customerEmail: details.email,
          customerPhone: details.baseInfo.contactNumber ?? '',
          date: details.baseInfo.time,
          time: _formatTime(details.baseInfo.time),
          guestsCount: details.baseInfo.guestsCount,
          specialRequests: details.baseInfo.specialRequests,
        ));

        return bloc;
      },
      child: BlocListener<ReservationFormBloc, ReservationFormState>(
        listener: (context, state) {
          if (state.status == ReservationFormStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Reservation updated successfully!'),
                backgroundColor: AppColors.primary,
              ),
            );
            Navigator.of(context).pop();
          } else if (state.status == ReservationFormStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'An error occurred'),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: const EditReservationView(),
      ),
    );
  }

  static String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
  }
}

class EditReservationView extends StatelessWidget {
  const EditReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    final details = context.findAncestorWidgetOfExactType<EditReservationPage>()!.details;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Reservation',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            Text(
              'Update reservation details for guest',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.0,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.background.withAlpha(204),
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 160.0, // Space for the bottom action bar
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 672), // ~ max-w-2xl
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EditReservationOverview(details: details),
                    const SizedBox(height: 32.0),
                    const StepCustomerDetails(),
                    const SizedBox(height: 32.0),
                    const StepChooseSchedule(),
                    const SizedBox(height: 32.0),
                    const StepConfigureParty(),
                    const SizedBox(height: 32.0),
                    const StepAddPreferences(),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: EditReservationBottomBar(),
          ),
        ],
      ),
    );
  }
}
