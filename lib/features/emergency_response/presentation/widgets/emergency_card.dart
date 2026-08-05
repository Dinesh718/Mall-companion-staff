import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/emergency_entity.dart';
import 'emergency_response_stepper.dart';

class EmergencyCard extends StatelessWidget {
  final EmergencyEntity emergency;
  final VoidCallback onAccept;
  final VoidCallback onViewDetails;

  const EmergencyCard({
    super.key,
    required this.emergency,
    required this.onAccept,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: _getCardBackgroundColor(emergency.priority),
        borderRadius: BorderRadius.circular(12.0), // rounded-xl
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 4.0,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: _getPriorityColor(emergency.priority),
            width: 4.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0), // p-5
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: ID, Priority Badge, Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          '#${emergency.id}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.0, // label-md
                            fontWeight: FontWeight.w500,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Flexible(child: _buildPriorityBadge(emergency.priority)),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                _buildStatusLabel(emergency.status),
              ],
            ),
            const SizedBox(height: 12.0),
            
            // Title
            Text(
              emergency.title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 22.0, // title-lg
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 16.0),
            
            // Info Grid
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Location & Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16.0,
                            color: AppColors.outline,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              emergency.location,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0, // body-lg
                                color: AppColors.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.schedule_outlined,
                            size: 16.0,
                            color: AppColors.outline,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              'Reported ${_formatTimeAgo(emergency.reportedTime)} via ${_formatReporterSource(emergency.reporterSource)}',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                
                // Right Column: Stats Block
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.surface, // surface-container-lowest equivalent inside colored card
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.outlineVariant.withAlpha(76)),
                    ),
                    child: Column(
                      children: [
                        _buildStatRow('Distance', '${emergency.distanceFromOfficerMeters.toInt()}m away', false),
                        const SizedBox(height: 4.0),
                        _buildStatRow('ETA', '${emergency.estimatedArrivalTimeMinutes}m', true, isCritical: emergency.priority == EmergencyPriority.critical),
                        const SizedBox(height: 4.0),
                        _buildStatRow('Crowd Est.', emergency.crowdEstimate, false),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Actions (if waiting/reported)
            if (emergency.status == EmergencyStatus.reported || emergency.status == EmergencyStatus.assigned) ...[
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48.0, // h-touch-target-min
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF6B38D4),
                            AppColors.secondaryContainer,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(12),
                            blurRadius: 4.0,
                            offset: const Offset(0, 1),
                          )
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onAccept,
                          borderRadius: BorderRadius.circular(8.0),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Accept Response',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14.0, // label-lg
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Container(
                      height: 48.0,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer.withAlpha(51), // secondary-container/20
                        border: Border.all(color: AppColors.secondary.withAlpha(51)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onViewDetails,
                          borderRadius: BorderRadius.circular(8.0),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'View Details',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.onSurface, // or onSecondaryContainer if it's very dark
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            
            // Stepper (if accepted)
            if (emergency.status.index >= EmergencyStatus.accepted.index) ...[
              const SizedBox(height: 16.0),
              const Divider(color: AppColors.outlineVariant, height: 1.0),
              const SizedBox(height: 16.0),
              const Text(
                'Response Progress',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.outline,
                ),
              ),
              const SizedBox(height: 12.0),
              EmergencyResponseStepper(currentStatus: emergency.status),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(EmergencyPriority priority) {
    Color bgColor;
    Color textColor;
    IconData icon;
    String label;

    switch (priority) {
      case EmergencyPriority.critical:
        bgColor = AppColors.error.withAlpha(25);
        textColor = AppColors.error;
        icon = Icons.warning_rounded;
        label = 'Critical';
        break;
      case EmergencyPriority.high:
        bgColor = AppColors.tertiaryContainer.withAlpha(25);
        textColor = AppColors.tertiaryContainer;
        icon = Icons.medical_services_rounded;
        label = 'High';
        break;
      case EmergencyPriority.medium:
        bgColor = AppColors.warning.withAlpha(25);
        textColor = AppColors.warning;
        icon = Icons.priority_high_rounded;
        label = 'Medium';
        break;
      case EmergencyPriority.low:
        bgColor = AppColors.success.withAlpha(25);
        textColor = AppColors.success;
        icon = Icons.info_outline_rounded;
        label = 'Low';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.0, color: textColor),
          const SizedBox(width: 4.0),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusLabel(EmergencyStatus status) {
    if (status == EmergencyStatus.reported || status == EmergencyStatus.assigned) {
      return const Text(
        'Waiting',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: AppColors.outline,
        ),
      );
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, size: 16.0, color: AppColors.primary),
        const SizedBox(width: 4.0),
        Text(
          _formatStatus(status),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String value, bool isValueBold, {bool isCritical = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.outline,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 4.0),
        Flexible(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: isValueBold ? FontWeight.bold : FontWeight.w500,
              color: isCritical ? AppColors.error : AppColors.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(EmergencyPriority priority) {
    switch (priority) {
      case EmergencyPriority.critical:
        return AppColors.error;
      case EmergencyPriority.high:
        return AppColors.tertiaryContainer;
      case EmergencyPriority.medium:
        return AppColors.warning;
      case EmergencyPriority.low:
        return AppColors.success;
    }
  }

  Color _getCardBackgroundColor(EmergencyPriority priority) {
    if (priority == EmergencyPriority.critical) {
      return const Color(0xFFFEFBFA); // #fefbfa as per Stitch
    }
    return AppColors.surface;
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

  String _formatReporterSource(EmergencyReporterSource source) {
    switch (source) {
      case EmergencyReporterSource.visitor: return 'Visitor';
      case EmergencyReporterSource.storeManager: return 'Store Manager';
      case EmergencyReporterSource.maintenanceStaff: return 'Maintenance Staff';
      case EmergencyReporterSource.cctv: return 'CCTV';
      case EmergencyReporterSource.aiCamera: return 'AI Camera';
      case EmergencyReporterSource.fireSensor: return 'Fire Sensor';
      case EmergencyReporterSource.smokeDetector: return 'Smoke Detector';
    }
  }

  String _formatStatus(EmergencyStatus status) {
    switch (status) {
      case EmergencyStatus.reported: return 'Reported';
      case EmergencyStatus.assigned: return 'Assigned';
      case EmergencyStatus.accepted: return 'Accepted';
      case EmergencyStatus.navigationStarted: return 'En Route';
      case EmergencyStatus.onSite: return 'On Site';
      case EmergencyStatus.assistanceInProgress: return 'Assisting';
      case EmergencyStatus.resolved: return 'Resolved';
    }
  }
}
