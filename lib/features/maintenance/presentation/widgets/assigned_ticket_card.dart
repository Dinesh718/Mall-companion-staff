import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/maintenance_ticket_entity.dart';
import 'ticket_chips.dart';

class AssignedTicketCard extends StatelessWidget {
  final MaintenanceTicketEntity ticket;
  final VoidCallback onTap;

  const AssignedTicketCard({
    super.key,
    required this.ticket,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: ID and Chevron
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ticket.id,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.onSurfaceVariant,
                      size: 20.0,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                
                // Title
                Text(
                  ticket.title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 12.0),
                
                // Chips Row
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    TicketChips.buildCategoryChip(ticket.category),
                    TicketChips.buildPriorityChip(ticket.priority),
                    TicketChips.buildStatusChip(ticket.status),
                  ],
                ),
                const SizedBox(height: 20.0),
                
                // Divider
                Divider(
                  color: AppColors.outlineVariant.withValues(alpha: 0.3),
                  height: 1.0,
                  thickness: 1.0,
                ),
                const SizedBox(height: 16.0),
                
                // Bottom Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 20.0,
                            color: AppColors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Location',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11.0,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  ticket.location,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14.0,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.access_time_outlined,
                            size: 20.0,
                            color: AppColors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Due In',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11.0,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  _calculateDueIn(ticket.reportedTime),
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14.0,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _calculateDueIn(String reportedTime) {
    // In a real app, this would parse the reportedTime and compare to now.
    // For mock purposes based on the design, return dummy values.
    if (ticket.id.contains('2045')) return '1h 15m';
    if (ticket.id.contains('2049')) return '3h 45m';
    return '2h 30m';
  }
}

