import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_error_state.dart';
import '../../data/repositories/mock_reservation_repository.dart';
import '../../domain/usecases/get_reservation_details_usecase.dart';
import '../bloc/details/reservation_details_bloc.dart';
import '../bloc/details/reservation_details_event.dart';
import '../bloc/details/reservation_details_state.dart';

import '../../domain/usecases/confirm_reservation_usecase.dart';
import '../../domain/usecases/check_in_reservation_usecase.dart';
import '../../domain/usecases/seat_reservation_usecase.dart';
import '../../domain/usecases/complete_reservation_usecase.dart';
import '../../domain/usecases/cancel_reservation_usecase.dart';
import '../../domain/usecases/mark_no_show_reservation_usecase.dart';

import '../widgets/details/reservation_hero_card.dart';
import '../widgets/details/customer_profile_card.dart';
import '../widgets/details/customer_insights_banner.dart';
import '../widgets/details/reservation_info_grid.dart';
import '../widgets/details/special_requests_section.dart';

import '../widgets/details/activity_timeline.dart';
import '../widgets/details/reservation_bottom_action_bar.dart';

class ReservationDetailsPage extends StatelessWidget {
  final String reservationId;

  const ReservationDetailsPage({
    super.key,
    required this.reservationId,
  });

  @override
  Widget build(BuildContext context) {
    final repository = MockReservationRepository();
    return BlocProvider(
      create: (context) => ReservationDetailsBloc(
        getReservationDetailsUseCase: GetReservationDetailsUseCase(repository),
        confirmReservationUseCase: ConfirmReservationUseCase(repository),
        checkInReservationUseCase: CheckInReservationUseCase(repository),
        seatReservationUseCase: SeatReservationUseCase(repository),
        completeReservationUseCase: CompleteReservationUseCase(repository),
        cancelReservationUseCase: CancelReservationUseCase(repository),
        markNoShowReservationUseCase: MarkNoShowReservationUseCase(repository),
      )..add(LoadReservationDetails(reservationId)),
      child: const ReservationDetailsView(),
    );
  }
}

class ReservationDetailsView extends StatelessWidget {
  const ReservationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationDetailsBloc, ReservationDetailsState>(
      listener: (context, state) {
        if (state is ReservationDetailsOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(fontFamily: 'Inter', color: Colors.white),
              ),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          );
        } else if (state is ReservationDetailsOperationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(fontFamily: 'Inter', color: Colors.white),
              ),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(
            'Reservation Details',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
            ),
          ),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: AppColors.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<ReservationDetailsBloc, ReservationDetailsState>(
        builder: (context, state) {
          if (state is ReservationDetailsLoading || state is ReservationDetailsInitial) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (state is ReservationDetailsError) {
            return AppErrorState(
              title: 'Failed to load details',
              message: state.message,
              onRetry: () {
                // Not ideal to fetch ID like this in real app, but works for mock
                context.read<ReservationDetailsBloc>().add(const LoadReservationDetails('RES-8842'));
              },
            );
          } else if (state is ReservationDetailsLoaded || 
                     state is ReservationDetailsOperationSuccess || 
                     state is ReservationDetailsOperationFailure || 
                     state is ReservationDetailsOperationLoading) {
            final details = (state is ReservationDetailsLoaded) ? state.details :
                            (state is ReservationDetailsOperationSuccess) ? state.details :
                            (state is ReservationDetailsOperationFailure) ? state.details :
                            (state as ReservationDetailsOperationLoading).details;
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 24.0,
                    bottom: 120.0, // space for bottom action bar
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ReservationHeroCard(details: details),
                          const SizedBox(height: 24.0),
                          CustomerProfileCard(details: details),
                          const SizedBox(height: 24.0),
                          CustomerInsightsBanner(details: details),
                          const SizedBox(height: 24.0),
                          ReservationInfoGrid(details: details),
                          const SizedBox(height: 24.0),
                          if (details.specialRequestTags.isNotEmpty) ...[
                            SpecialRequestsSection(details: details),
                            const SizedBox(height: 24.0),
                          ],
                          ActivityTimeline(timeline: details.timeline),
                        ],
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ReservationBottomActionBar(),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    ),
    );
  }
}
