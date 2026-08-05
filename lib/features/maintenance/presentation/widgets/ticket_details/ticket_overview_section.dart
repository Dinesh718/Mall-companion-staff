import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../maintenance/domain/entities/ticket_details_entity.dart';
import '../ticket_chips.dart';

class TicketOverviewSection extends StatelessWidget {
  final TicketDetailsEntity ticket;

  const TicketOverviewSection({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticket.id,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const Icon(
                Icons.more_horiz_rounded,
                color: AppColors.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            ticket.title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              TicketChips.buildCategoryChip(ticket.category),
              TicketChips.buildPriorityChip(ticket.priority),
              TicketChips.buildStatusChip(ticket.status),
            ],
          ),
          const SizedBox(height: 24.0),
          Divider(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
            height: 1.0,
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Description',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            ticket.description,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.0,
              color: AppColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
