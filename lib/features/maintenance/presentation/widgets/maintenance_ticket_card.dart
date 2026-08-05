// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/maintenance_ticket_entity.dart';

class MaintenanceTicketCard extends StatelessWidget {
  final MaintenanceTicketEntity ticket;

  const MaintenanceTicketCard({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    // Determine icon and color based on category
    IconData categoryIcon = Icons.home_repair_service;
    Color iconColor = const Color(0xFF6B7280);
    Color iconBgColor = const Color(0xFFF3F4F6);

    if (ticket.category.toUpperCase() == 'HVAC') {
      categoryIcon = Icons.ac_unit_rounded; // Assuming an icon that looks like HVAC
      iconColor = const Color(0xFFDC2626); // Red
      iconBgColor = const Color(0xFFFEE2E2); // Light red
    } else if (ticket.category.toUpperCase() == 'ELEC') {
      categoryIcon = Icons.electrical_services_rounded;
      iconColor = const Color(0xFF2563EB); // Blue
      iconBgColor = const Color(0xFFDBEAFE); // Light blue
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Icon
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              categoryIcon,
              color: iconColor,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 16.0),
          
          // Right Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: ID and Status Chips
                Row(
                  children: [
                    Text(
                      ticket.id,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const Spacer(),
                    _PriorityChip(priority: ticket.priority),
                    const SizedBox(width: 6.0),
                    _StatusChip(status: ticket.status),
                  ],
                ),
                const SizedBox(height: 8.0),
                
                // Title
                Text(
                  ticket.title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4.0),
                
                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16.0,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      ticket.location,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                
                // Divider
                const Divider(color: Color(0xFFF3F4F6), height: 1.0),
                const SizedBox(height: 12.0),
                
                // Footer Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Assigned: ${ticket.reportedTime}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Category: ${ticket.category}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.0,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(width: 2.0),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 16.0,
                          color: Color(0xFF8B5CF6), // Purple
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  final String priority;

  const _PriorityChip({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    if (priority.toUpperCase() == 'HIGH') {
      bgColor = const Color(0xFFB91C1C); // Dark Red
      textColor = Colors.white;
    } else if (priority.toUpperCase() == 'MEDIUM') {
      bgColor = const Color(0xFFF3F4F6); // Gray
      textColor = const Color(0xFF374151); // Dark Gray
    } else {
      bgColor = const Color(0xFFF3F4F6);
      textColor = const Color(0xFF374151);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        priority.toUpperCase(),
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

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    if (status.toUpperCase() == 'PENDING') {
      bgColor = const Color(0xFFDBEAFE); // Light Blue
      textColor = const Color(0xFF1D4ED8); // Dark Blue
    } else if (status.toUpperCase() == 'IN PROGRESS') {
      bgColor = const Color(0xFFF3E8FF); // Light Purple
      textColor = const Color(0xFF7E22CE); // Dark Purple
    } else {
      bgColor = const Color(0xFFF3F4F6);
      textColor = const Color(0xFF374151);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        status.toUpperCase(),
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
