import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/reservation_entity.dart';

class ReservationCard extends StatelessWidget {
  final ReservationEntity reservation;
  final VoidCallback? onTap;

  const ReservationCard({
    super.key,
    required this.reservation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String initial = reservation.customerName.isNotEmpty ? reservation.customerName[0].toUpperCase() : '?';

    Color avatarBgColor;
    Color avatarTextColor;

    switch (reservation.status) {
      case ReservationStatus.confirmed:
        avatarBgColor = AppColors.primaryContainer.withAlpha(51);
        avatarTextColor = AppColors.primaryContainer;
        break;
      case ReservationStatus.checkedIn:
      case ReservationStatus.seated:
      case ReservationStatus.completed:
        avatarBgColor = AppColors.secondary.withAlpha(51);
        avatarTextColor = AppColors.secondary;
        break;
      default:
        avatarBgColor = AppColors.surfaceContainer;
        avatarTextColor = AppColors.onSurfaceVariant;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withAlpha(12),
            blurRadius: 15.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: avatarBgColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Text(
                initial,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: avatarTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reservation.customerName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 2.0),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 14.0,
                      color: AppColors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      "${reservation.time.hour.toString().padLeft(2, '0')}:${reservation.time.minute.toString().padLeft(2, '0')}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'Inter',
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Text('•', style: TextStyle(color: AppColors.outlineVariant)),
                    const SizedBox(width: 8.0),
                    const Icon(
                      Icons.group_rounded,
                      size: 14.0,
                      color: AppColors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '${reservation.guestsCount}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'Inter',
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildStatusChip(reservation.status),
              if (reservation.specialRequests != null) ...[
                const SizedBox(height: 4.0),
                Text(
                  reservation.specialRequests!,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildStatusChip(ReservationStatus status) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case ReservationStatus.confirmed:
        bgColor = AppColors.success.withAlpha(25);
        textColor = AppColors.success;
        label = 'Confirmed';
        break;
      case ReservationStatus.checkedIn:
        bgColor = AppColors.primary.withAlpha(25);
        textColor = AppColors.primary;
        label = 'Arriving';
        break;
      case ReservationStatus.seated:
        bgColor = AppColors.secondary.withAlpha(25);
        textColor = AppColors.secondary;
        label = 'Seated';
        break;
      case ReservationStatus.completed:
        bgColor = AppColors.onSurfaceVariant.withAlpha(25);
        textColor = AppColors.onSurfaceVariant;
        label = 'Completed';
        break;
      case ReservationStatus.cancelled:
      case ReservationStatus.noShow:
        bgColor = AppColors.error.withAlpha(25);
        textColor = AppColors.error;
        label = status == ReservationStatus.cancelled ? 'Cancelled' : 'No Show';
        break;
      case ReservationStatus.pending:
        bgColor = AppColors.primary.withAlpha(25);
        textColor = AppColors.primary;
        label = 'Pending';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
