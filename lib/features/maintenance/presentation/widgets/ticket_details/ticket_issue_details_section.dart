import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../maintenance/domain/entities/ticket_details_entity.dart';

class TicketIssueDetailsSection extends StatelessWidget {
  final TicketDetailsEntity ticket;

  const TicketIssueDetailsSection({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.primary,
                size: 24.0,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  ticket.title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurface,
                    height: 28 / 22,
                  ),
                ),
              ),
            ],
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
