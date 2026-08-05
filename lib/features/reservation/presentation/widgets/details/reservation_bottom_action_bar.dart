import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../reservation/domain/entities/reservation_entity.dart';
import '../../../../reservation/domain/entities/reservation_details_entity.dart';
import '../../bloc/details/reservation_details_bloc.dart';
import '../../bloc/details/reservation_details_event.dart';
import '../../bloc/details/reservation_details_state.dart';
import '../../pages/edit_reservation_page.dart';

class ReservationBottomActionBar extends StatelessWidget {
  const ReservationBottomActionBar({super.key});

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onConfirm,
    {bool isDestructive = false}
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
        content: Text(
          content,
          style: const TextStyle(fontFamily: 'Inter'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(fontFamily: 'Inter', color: AppColors.onSurfaceVariant)),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onConfirm();
            },
            style: FilledButton.styleFrom(
              backgroundColor: isDestructive ? AppColors.error : AppColors.primary,
            ),
            child: const Text('Confirm', style: TextStyle(fontFamily: 'Inter')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationDetailsBloc, ReservationDetailsState>(
      builder: (context, state) {
        ReservationDetailsEntity? details;
        if (state is ReservationDetailsLoaded) {
          details = state.details;
        } else if (state is ReservationDetailsOperationSuccess) {
          details = state.details;
        } else if (state is ReservationDetailsOperationFailure) {
          details = state.details;
        } else if (state is ReservationDetailsOperationLoading) {
          details = state.details;
        }

        if (details == null) return const SizedBox.shrink();

        final status = details.baseInfo.status;
        final isTerminal = status == ReservationStatus.completed || 
                           status == ReservationStatus.cancelled || 
                           status == ReservationStatus.noShow;

        if (isTerminal) return const SizedBox.shrink();

        final isLoading = state is ReservationDetailsOperationLoading;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(204),
            border: Border(
              top: BorderSide(color: AppColors.outlineVariant.withAlpha(76)),
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                if (status == ReservationStatus.pending || status == ReservationStatus.confirmed)
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: isLoading ? null : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EditReservationPage(details: details!),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        side: const BorderSide(color: AppColors.outlineVariant),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ),
                  ),
                if (status == ReservationStatus.pending || status == ReservationStatus.confirmed)
                  const SizedBox(width: 8.0),
                Expanded(
                  flex: 2,
                  child: _buildPrimaryActionButton(context, details, isLoading),
                ),
                if (status == ReservationStatus.pending || status == ReservationStatus.confirmed) ...[
                  const SizedBox(width: 8.0),
                  _buildMoreOptionsButton(context, details, isLoading),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPrimaryActionButton(BuildContext context, ReservationDetailsEntity details, bool isLoading) {
    String label = '';
    IconData icon = Icons.check;
    VoidCallback? onTap;

    switch (details.baseInfo.status) {
      case ReservationStatus.pending:
        label = 'Confirm';
        icon = Icons.check_circle_outline;
        onTap = () {
          _showConfirmationDialog(
            context,
            'Confirm Reservation',
            'Are you sure you want to confirm this reservation?',
            () => context.read<ReservationDetailsBloc>().add(PerformReservationOperation(details.baseInfo.id, ReservationOperation.confirm)),
          );
        };
        break;
      case ReservationStatus.confirmed:
        label = 'Check In';
        icon = Icons.check_circle_rounded;
        onTap = () {
          context.read<ReservationDetailsBloc>().add(PerformReservationOperation(details.baseInfo.id, ReservationOperation.checkIn));
        };
        break;
      case ReservationStatus.checkedIn:
        label = 'Seat Customer';
        icon = Icons.event_seat_rounded;
        onTap = () {
          context.read<ReservationDetailsBloc>().add(PerformReservationOperation(details.baseInfo.id, ReservationOperation.seat));
        };
        break;
      case ReservationStatus.seated:
        label = 'Complete';
        icon = Icons.done_all_rounded;
        onTap = () {
          _showConfirmationDialog(
            context,
            'Complete Reservation',
            'Mark this reservation as successfully completed?',
            () => context.read<ReservationDetailsBloc>().add(PerformReservationOperation(details.baseInfo.id, ReservationOperation.complete)),
          );
        };
        break;
      default:
        break;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: isLoading
            ? null
            : const LinearGradient(
                colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
              ),
        color: isLoading ? AppColors.outlineVariant : null,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: isLoading
            ? null
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
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: Colors.white),
                      const SizedBox(width: 8.0),
                      Text(
                        label,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreOptionsButton(BuildContext context, ReservationDetailsEntity details, bool isLoading) {
    return PopupMenuButton<ReservationOperation>(
      enabled: !isLoading,
      icon: const Icon(Icons.more_vert_rounded, color: AppColors.onSurfaceVariant),
      onSelected: (operation) {
        if (operation == ReservationOperation.cancel) {
          _showConfirmationDialog(
            context,
            'Cancel Reservation',
            'Are you sure you want to cancel this reservation? This cannot be undone.',
            () => context.read<ReservationDetailsBloc>().add(PerformReservationOperation(details.baseInfo.id, operation)),
            isDestructive: true,
          );
        } else if (operation == ReservationOperation.noShow) {
          _showConfirmationDialog(
            context,
            'Mark No Show',
            'Are you sure you want to mark this customer as a no show?',
            () => context.read<ReservationDetailsBloc>().add(PerformReservationOperation(details.baseInfo.id, operation)),
            isDestructive: true,
          );
        }
      },
      itemBuilder: (context) => [
        if (details.baseInfo.status == ReservationStatus.pending || details.baseInfo.status == ReservationStatus.confirmed)
          const PopupMenuItem(
            value: ReservationOperation.cancel,
            child: Text('Cancel Reservation', style: TextStyle(color: AppColors.error, fontFamily: 'Inter')),
          ),
        if (details.baseInfo.status == ReservationStatus.confirmed)
          const PopupMenuItem(
            value: ReservationOperation.noShow,
            child: Text('Mark No Show', style: TextStyle(color: AppColors.error, fontFamily: 'Inter')),
          ),
      ],
    );
  }
}
