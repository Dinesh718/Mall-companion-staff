import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/incident_entity.dart';

class IncidentReporterBadge extends StatelessWidget {
  final IncidentReporterSource source;
  final bool hasAttachments;

  const IncidentReporterBadge({
    super.key,
    required this.source,
    this.hasAttachments = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _getSourceIcon(source),
          size: 14.0,
          color: AppColors.onSurfaceVariant.withAlpha(102), // 40% opacity
        ),
        if (hasAttachments) ...[
          const SizedBox(width: 4.0),
          Icon(
            Icons.attach_file_rounded,
            size: 14.0,
            color: AppColors.onSurfaceVariant.withAlpha(102),
          ),
        ],
      ],
    );
  }

  IconData _getSourceIcon(IncidentReporterSource source) {
    switch (source) {
      case IncidentReporterSource.cctv:
      case IncidentReporterSource.aiCamera:
        return Icons.videocam_outlined;
      case IncidentReporterSource.visitor:
        return Icons.person_outline;
      case IncidentReporterSource.mallStaff:
        return Icons.badge_outlined;
      case IncidentReporterSource.doorSensor:
        return Icons.sensor_door_outlined;
    }
  }
}
