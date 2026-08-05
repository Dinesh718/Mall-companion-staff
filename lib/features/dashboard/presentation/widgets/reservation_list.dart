// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/store_dashboard_entity.dart';

class ReservationList extends StatelessWidget {
  final List<ReservationEntity> reservations;

  const ReservationList({
    super.key,
    required this.reservations,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Reservations",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: 'Inter',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textNavy,
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('View All Reservations (mock)'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text(
                  'VIEW ALL',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),

        // List builder
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reservations.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16.0),
          itemBuilder: (context, index) {
            final res = reservations[index];
            return Opacity(
              opacity: res.isManageable ? 1.0 : 0.60,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1F2937).withOpacity(0.04),
                      blurRadius: 12.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Avatar circle
                    Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: res.isManageable
                            ? AppColors.secondary.withOpacity(0.1)
                            : const Color(0xFFEDE5F5), // surface-container-high
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_rounded,
                        color: res.isManageable ? AppColors.secondary : AppColors.onSurfaceVariant,
                        size: 28.0,
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    // Customer details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            res.customerName,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textNavy,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule_rounded,
                                size: 14.0,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                res.time,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              const Icon(
                                Icons.group_outlined,
                                size: 14.0,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                '${res.guestsCount} ${res.guestsCount == 1 ? "Guest" : "Guests"}',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Action button if manageable
                    if (res.isManageable)
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Manage Reservation for ${res.customerName} (mock)'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        child: const Text(
                          'Manage',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
