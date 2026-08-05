import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/incident_entity.dart';
import 'incident_reporter_badge.dart';
import 'assigned_officer_tile.dart';

class IncidentCard extends StatelessWidget {
  final IncidentEntity incident;
  final VoidCallback onManageTap;

  const IncidentCard({
    super.key,
    required this.incident,
    required this.onManageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 4.0,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: _getPriorityColor(incident.priority),
            width: 4.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: ID, Icons, Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '#${incident.id}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IncidentReporterBadge(
                      source: incident.reporterSource,
                      hasAttachments: incident.hasAttachments,
                    ),
                  ],
                ),
                _buildStatusChip(incident.status),
              ],
            ),
            const SizedBox(height: 12.0),
            
            // Body: Title, Category, Location
            Text(
              incident.title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 22.0, // title-lg
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              incident.category.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                color: _getCategoryColor(incident.category),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 14.0,
                  color: AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 6.0),
                Text(
                  incident.location,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            
            // Time
            Row(
              children: [
                const Icon(
                  Icons.schedule_outlined,
                  size: 14.0,
                  color: AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 4.0),
                Text(
                  'Reported ${_formatTimeAgo(incident.reportedTime)}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            
            // Divider
            Divider(
              color: AppColors.outlineVariant.withAlpha(76),
              height: 1.0,
            ),
            const SizedBox(height: 16.0),
            
            // Footer: Officer Tile and Manage Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (incident.assignedOfficer != null)
                  Expanded(
                    child: AssignedOfficerTile(officer: incident.assignedOfficer!),
                  )
                else
                  const Expanded(
                    child: Text(
                      'Unassigned',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: onManageTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 2.0, // shadow-md approx
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                    minimumSize: const Size(0, 36.0), // h-9
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0), // rounded
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Manage',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.0, // font-label-lg
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Icon(Icons.chevron_right_rounded, size: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(IncidentPriority priority) {
    switch (priority) {
      case IncidentPriority.critical:
        return AppColors.error;
      case IncidentPriority.high:
        return AppColors.tertiaryContainer;
      case IncidentPriority.medium:
        return AppColors.warning;
      case IncidentPriority.low:
        return AppColors.success;
    }
  }

  Color _getCategoryColor(String category) {
    final lower = category.toLowerCase();
    if (lower == 'security') {
      return AppColors.secondary;
    }
    return AppColors.primary;
  }

  Widget _buildStatusChip(IncidentStatus status) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case IncidentStatus.pending:
        bgColor = AppColors.surfaceContainerLow;
        textColor = AppColors.onSurfaceVariant;
        label = 'Pending';
        break;
      case IncidentStatus.responding:
        bgColor = AppColors.secondaryContainer;
        textColor = Colors.white;
        label = 'Responding';
        break;
      case IncidentStatus.assigned:
        bgColor = AppColors.surfaceContainerHighest;
        textColor = AppColors.onSurfaceVariant;
        label = 'Assigned';
        break;
      case IncidentStatus.accepted:
        bgColor = AppColors.secondaryFixed;
        textColor = AppColors.onSecondaryFixed;
        label = 'Accepted';
        break;
      case IncidentStatus.onSite:
        bgColor = AppColors.primaryContainer;
        textColor = Colors.white;
        label = 'On Site';
        break;
      case IncidentStatus.resolved:
      case IncidentStatus.closed:
        bgColor = AppColors.success.withAlpha(51);
        textColor = AppColors.success;
        label = status == IncidentStatus.resolved ? 'Resolved' : 'Closed';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12.0, // label-md
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
