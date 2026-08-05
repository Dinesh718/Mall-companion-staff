import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_type.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = _getThemeForType(notification.type);

    return Opacity(
      opacity: notification.isRead ? 0.8 : 1.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: theme.borderColor,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: theme.iconBgColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(
                      theme.icon,
                      color: theme.iconColor,
                      size: 22.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8.0,
                                children: [
                                  Text(
                                    notification.title,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16.0,
                                      fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.bold,
                                      color: AppColors.onSurface,
                                    ),
                                  ),
                                  if (notification.type == NotificationType.critical)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                        color: AppColors.error.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: const Text(
                                        'CRITICAL',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.error,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _formatTimeago(notification.timestamp),
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 10.0,
                                    color: AppColors.outline,
                                  ),
                                ),
                                if (!notification.isRead) ...[
                                  const SizedBox(width: 8.0),
                                  Container(
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          notification.description,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            height: 1.4,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  // Chevron
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.outline,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimeago(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  _NotificationTheme _getThemeForType(NotificationType type) {
    switch (type) {
      case NotificationType.critical:
        return _NotificationTheme(
          icon: Icons.warning_rounded,
          iconColor: AppColors.error,
          iconBgColor: AppColors.error.withValues(alpha: 0.1),
          borderColor: AppColors.error.withValues(alpha: 0.1),
        );
      case NotificationType.assignment:
        return _NotificationTheme(
          icon: Icons.assignment_ind_rounded,
          iconColor: const Color(0xFF8B5CF6), // primary violet
          iconBgColor: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
          borderColor: AppColors.outlineVariant,
        );
      case NotificationType.update:
        return _NotificationTheme(
          icon: Icons.update_rounded,
          iconColor: AppColors.primary,
          iconBgColor: AppColors.primary.withValues(alpha: 0.1),
          borderColor: AppColors.outlineVariant,
        );
      case NotificationType.announcement:
        return _NotificationTheme(
          icon: Icons.campaign_rounded,
          iconColor: AppColors.primary,
          iconBgColor: AppColors.primary.withValues(alpha: 0.1),
          borderColor: AppColors.outlineVariant,
        );
      case NotificationType.resolved:
        return _NotificationTheme(
          icon: Icons.check_circle_rounded,
          iconColor: Colors.green,
          iconBgColor: Colors.green.withValues(alpha: 0.1),
          borderColor: AppColors.outlineVariant,
        );
    }
  }
}

class _NotificationTheme {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final Color borderColor;

  _NotificationTheme({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.borderColor,
  });
}
