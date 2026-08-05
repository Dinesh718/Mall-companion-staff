import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/security_dashboard_entity.dart';

class EmergencyAlertsSection extends StatelessWidget {
  final List<EmergencyAlertEntity> alerts;
  final VoidCallback onViewAll;
  final Function(EmergencyAlertEntity) onNavigate;

  const EmergencyAlertsSection({
    super.key,
    required this.alerts,
    required this.onViewAll,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Emergency Alerts',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
                color: AppColors.onSurface,
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'View All',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Column(
          children: alerts.map((alert) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: EmergencyAlertCard(
                alert: alert,
                onNavigate: () => onNavigate(alert),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class EmergencyAlertCard extends StatelessWidget {
  final EmergencyAlertEntity alert;
  final VoidCallback onNavigate;

  const EmergencyAlertCard({
    super.key,
    required this.alert,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final isCritical = alert.priority == AlertPriority.critical;

    final backgroundColor = isCritical
        ? AppColors.errorContainer.withAlpha(102) // 40% opacity
        : AppColors.tertiaryContainer.withAlpha(76); // 30% opacity
    
    final borderColor = isCritical ? AppColors.error : AppColors.tertiary;
    
    final iconColor = Colors.white;
    final iconBgColor = isCritical ? AppColors.error : AppColors.tertiary;
    
    final icon = isCritical ? Icons.local_fire_department : Icons.medical_services;
    
    final titleColor = isCritical ? AppColors.onErrorContainer : AppColors.onTertiaryFixedVariant;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border(
          left: BorderSide(color: borderColor, width: 4.0),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 8.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert.type,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.1,
                                  color: titleColor,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                alert.location,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: isCritical ? AppColors.error : AppColors.tertiary,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Text(
                                isCritical ? 'Critical' : 'High',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              _getTimeAgo(alert.time),
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.onSurfaceVariant.withAlpha(178), // 70% opacity
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: onNavigate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: isCritical ? AppColors.error : AppColors.tertiary,
                          elevation: 1.0,
                          shadowColor: Colors.black.withAlpha(25),
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                          minimumSize: Size.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            side: BorderSide(
                              color: (isCritical ? AppColors.error : AppColors.tertiary).withAlpha(51),
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.near_me, size: 18.0),
                        label: const Text(
                          'Navigate',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hr ago';
    }
    return '${diff.inDays} day ago';
  }
}
