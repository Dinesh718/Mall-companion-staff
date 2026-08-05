import 'package:flutter/material.dart';
import '../../domain/entities/maintenance_ticket_entity.dart';
import 'maintenance_ticket_card.dart';

class AssignedTicketsList extends StatelessWidget {
  final List<MaintenanceTicketEntity> tickets;

  const AssignedTicketsList({
    super.key,
    required this.tickets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Assigned Tickets',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF8B5CF6), // Purple
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              return MaintenanceTicketCard(ticket: tickets[index]);
            },
          ),
        ],
      ),
    );
  }
}
