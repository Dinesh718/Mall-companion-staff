import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../domain/entities/activity_history_item_entity.dart';
import '../../pages/ticket_details_page.dart';

class ActivityTimelineCard extends StatelessWidget {
  final ActivityHistoryItemEntity item;
  final bool isLast;

  const ActivityTimelineCard({
    super.key,
    required this.item,
    required this.isLast,
  });

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
      case 'RESOLVED':
        return const Color(0xFF0058BE); // Secondary
      case 'IN PROGRESS':
        return AppColors.primary;
      case 'ON HOLD':
      case 'PAUSED':
        return AppColors.error;
      case 'ASSIGNED':
        return AppColors.onSurfaceVariant;
      default:
        return AppColors.onSurfaceVariant;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
      case 'RESOLVED':
        return const Color(0xFF0058BE).withValues(alpha: 0.1);
      case 'IN PROGRESS':
        return AppColors.primary.withValues(alpha: 0.1);
      case 'ON HOLD':
      case 'PAUSED':
        return AppColors.error.withValues(alpha: 0.1);
      case 'ASSIGNED':
        return AppColors.outlineVariant.withValues(alpha: 0.2);
      default:
        return AppColors.outlineVariant.withValues(alpha: 0.2);
    }
  }

  Widget _buildIconBadge() {
    IconData iconData;
    Color iconColor;
    Color bgColor;

    switch (item.iconType) {
      case 'check_circle':
        iconData = Icons.check_circle_rounded;
        iconColor = const Color(0xFFFEFCFF); // onSecondaryContainer
        bgColor = const Color(0xFF2170E4); // SecondaryContainer
        break;
      case 'play_arrow':
        iconData = Icons.play_arrow_rounded;
        iconColor = const Color(0xFFFFFBFF); // onPrimaryContainer
        bgColor = const Color(0xFF8455EF); // PrimaryContainer
        break;
      case 'assignment_turned_in':
        iconData = Icons.assignment_turned_in_rounded;
        iconColor = AppColors.onSurface;
        bgColor = const Color(0xFFE5E7EB); // Gray 200
        break;
      case 'pause_circle':
        iconData = Icons.pause_circle_rounded;
        iconColor = const Color(0xFF4648D4); // tertiary
        bgColor = const Color(0xFF6063EE).withValues(alpha: 0.2); // tertiaryContainer with opacity
        break;
      default:
        iconData = Icons.info_rounded;
        iconColor = AppColors.onSurface;
        bgColor = const Color(0xFFE5E7EB);
    }

    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2.0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(
        iconData,
        color: iconColor,
        size: 20.0,
      ),
    );
  }

  IconData _getMetadataIcon(String icon) {
    switch (icon) {
      case 'person':
        return Icons.person_rounded;
      case 'schedule':
        return Icons.schedule_rounded;
      case 'history':
        return Icons.history_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isLast)
          Positioned(
            left: 20.0, // center of 40px icon
            top: 40.0,
            bottom: -16.0,
            child: Container(
              width: 3.0,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconBadge(),
              const SizedBox(width: 16.0),
              Expanded(
                child: Material(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TicketDetailsPage(ticketId: item.ticketId),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.outlineVariant),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                              ),
                              Text(
                                item.time,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  color: AppColors.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.ticketId,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  const Text(
                                    '•',
                                    style: TextStyle(
                                      color: AppColors.outlineVariant,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    item.priority,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12.0,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: _getStatusBgColor(item.status),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  item.status.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(item.status),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 16.0,
                                color: AppColors.onSurfaceVariant,
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  item.location,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14.0,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6.0),
                          Row(
                            children: [
                              Icon(
                                _getMetadataIcon(item.metadataIcon),
                                size: 14.0,
                                color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                item.metadataText,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
