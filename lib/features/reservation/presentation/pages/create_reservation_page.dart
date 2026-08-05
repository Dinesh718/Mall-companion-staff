import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../data/repositories/mock_reservation_repository.dart';
import '../../domain/usecases/create_reservation_usecase.dart';
import '../../domain/usecases/edit_reservation_usecase.dart';
import '../bloc/form/reservation_form_bloc.dart';
import '../bloc/form/reservation_form_state.dart';
import '../widgets/form/create_reservation_bottom_bar.dart';
import '../widgets/form/step_add_preferences.dart';
import '../widgets/form/step_choose_schedule.dart';
import '../widgets/form/step_configure_party.dart';
import '../widgets/form/step_customer_details.dart';

class CreateReservationPage extends StatelessWidget {
  const CreateReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockReservationRepository();
    return BlocProvider(
      create: (_) => ReservationFormBloc(
        createReservationUseCase: CreateReservationUseCase(mockRepo),
        editReservationUseCase: EditReservationUseCase(mockRepo),
      ),
      child: const CreateReservationView(),
    );
  }
}

class CreateReservationView extends StatelessWidget {
  const CreateReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationFormBloc, ReservationFormState>(
      listener: (context, state) {
        if (state.status == ReservationFormStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reservation created successfully!'),
              backgroundColor: AppColors.primary,
            ),
          );
          Navigator.pop(context, true); // Return true to indicate success
        } else if (state.status == ReservationFormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Failed to create reservation'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background.withAlpha(204),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Create Reservation',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          children: [
            // Scrollable Content
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: 240.0, // Space for the bottom bar
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StepCustomerDetails(),
                  SizedBox(height: 32.0),
                  StepChooseSchedule(),
                  SizedBox(height: 32.0),
                  StepConfigureParty(),
                  SizedBox(height: 32.0),
                  StepAddPreferences(),
                ],
              ),
            ),
            
            // Sticky Bottom Bar
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CreateReservationBottomBar(),
            ),
          ],
        ),
      ),
    );
  }
}
