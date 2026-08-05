import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/reservation_entity.dart';

class UpcomingReservationsList extends StatelessWidget {
  final List<ReservationEntity> reservations;

  const UpcomingReservationsList({
    super.key,
    required this.reservations,
  });

  @override
  Widget build(BuildContext context) {
    if (reservations.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withAlpha(12),
            blurRadius: 15.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: reservations.map((reservation) {
          final bool isLast = reservation == reservations.last;
          final String initial = reservation.customerName.isNotEmpty ? reservation.customerName[0].toUpperCase() : '?';
          
          return Container(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
            margin: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
            decoration: BoxDecoration(
              border: isLast ? null : Border(bottom: BorderSide(color: AppColors.outlineVariant.withAlpha(76))),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      initial,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurfaceVariant,
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
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Arriving soon',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.0,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${reservation.time.hour > 12 ? reservation.time.hour - 12 : reservation.time.hour}:${reservation.time.minute.toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      reservation.time.hour >= 12 ? 'PM' : 'AM',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
