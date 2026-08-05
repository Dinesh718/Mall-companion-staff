import 'package:flutter/material.dart';

class TicketChips {
  static Widget buildCategoryChip(String category) {
    IconData iconData = Icons.build_rounded;
    Color bgColor = const Color(0xFFF3F4F6); // Light gray default
    Color textColor = const Color(0xFF4B5563);

    final cat = category.toLowerCase();
    if (cat == 'hvac') {
      iconData = Icons.ac_unit_rounded;
      bgColor = const Color(0xFFE2E8F0); // Slightly bluish gray
      textColor = const Color(0xFF334155);
    } else if (cat == 'electrical') {
      iconData = Icons.bolt_rounded;
      bgColor = const Color(0xFFDBEAFE); // Light blue
      textColor = const Color(0xFF1E40AF);
    }

    return TicketIconChip(
      icon: iconData,
      label: category,
      backgroundColor: bgColor,
      color: textColor,
    );
  }

  static Widget buildPriorityChip(String priority) {
    IconData iconData = Icons.info_outline_rounded;
    Color bgColor = const Color(0xFFF3F4F6);
    Color textColor = const Color(0xFF374151);

    final prio = priority.toLowerCase();
    if (prio == 'critical' || prio == 'high') {
      iconData = prio == 'critical' ? Icons.warning_rounded : Icons.warning_amber_rounded;
      bgColor = const Color(0xFFFEE2E2); // Light red/orange
      textColor = const Color(0xFFDC2626); // Red
    } else if (prio == 'medium') {
      iconData = Icons.error_outline_rounded;
      bgColor = const Color(0xFFFEF3C7); // Light amber
      textColor = const Color(0xFFD97706);
    }

    return TicketIconChip(
      icon: iconData,
      label: priority,
      backgroundColor: bgColor,
      color: textColor,
    );
  }

  static Widget buildStatusChip(String status) {
    IconData iconData = Icons.assignment_outlined;
    Color bgColor = const Color(0xFFF3F4F6);
    Color textColor = const Color(0xFF374151);

    final stat = status.toLowerCase();
    if (stat == 'in progress') {
      iconData = Icons.play_circle_outline_rounded;
      bgColor = const Color(0xFFF3E8FF); // Light purple
      textColor = const Color(0xFF7E22CE); // Purple
    } else if (stat == 'assigned') {
      iconData = Icons.assignment_rounded;
      bgColor = const Color(0xFFE0F2FE); // Light blue
      textColor = const Color(0xFF0284C7);
    } else if (stat == 'open') {
      iconData = Icons.adjust_rounded;
      bgColor = const Color(0xFFF1F5F9);
      textColor = const Color(0xFF475569);
    } else if (stat == 'resolved') {
      iconData = Icons.check_circle_outline_rounded;
      bgColor = const Color(0xFFDCFCE7); // Light green
      textColor = const Color(0xFF16A34A); // Green
    }

    return TicketIconChip(
      icon: iconData,
      label: status,
      backgroundColor: bgColor,
      color: textColor,
    );
  }
}

class TicketIconChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color color;

  const TicketIconChip({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14.0,
            color: color,
          ),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
