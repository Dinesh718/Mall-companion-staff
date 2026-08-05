// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_entity.dart';

class TimelineCard extends StatelessWidget {
  final OfferEntity offer;

  const TimelineCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    // Read dynamic list logs from repository or fall back to default design details
    final timelineEvents = offer.timeline ?? [
      {'title': 'Campaign Created', 'subtitle': 'Oct 10, 2023 • 09:12 AM', 'status': 'completed'},
      {'title': 'Activated & Verified', 'subtitle': 'Oct 12, 2023 • 10:00 AM', 'status': 'completed'},
      {'title': 'Currently Live', 'subtitle': 'Operational since 12 days', 'status': 'active'},
      {'title': 'Expires On', 'subtitle': 'Oct 24, 2023 • 11:59 PM', 'status': 'upcoming'},
    ];

    final systemLogs = offer.systemLogs ?? [
      {'title': 'Campaign Created', 'subtitle': 'By Admin at 09:12 AM', 'type': 'create'},
      {'title': 'Metadata Updated', 'subtitle': 'Banner assets replaced', 'type': 'update'},
      {'title': 'Campaign Activated', 'subtitle': 'Broadcasted to all users', 'type': 'activate'},
      {'title': 'Coupon Modified', 'subtitle': 'Usage limit increased by 500', 'type': 'edit'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Grid layout for tablet, stacked column for mobile
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 550;

            final statusTimelineWidget = _buildStatusTimelineCard(timelineEvents);
            final systemLogsWidget = _buildSystemLogsCard(systemLogs);

            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: statusTimelineWidget),
                  const SizedBox(width: 16.0),
                  Expanded(child: systemLogsWidget),
                ],
              );
            } else {
              return Column(
                children: [
                  statusTimelineWidget,
                  const SizedBox(height: 16.0),
                  systemLogsWidget,
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildStatusTimelineCard(List<Map<String, dynamic>> events) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status Timeline',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 24.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final item = events[index];
              final status = item['status'] as String;
              final isLast = index == events.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dot and Timeline Line column
                    Column(
                      children: [
                        _buildTimelineNode(status),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2.0,
                              color: AppColors.outlineVariant.withOpacity(0.3),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16.0),
                    // Content details
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    item['title'] as String,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: status == 'active' ? AppColors.primary : AppColors.onSurface,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (status == 'active') ...[
                                  const SizedBox(width: 8.0),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(
                                        color: AppColors.primary.withOpacity(0.3),
                                      ),
                                    ),
                                    child: const Text(
                                      'LIVE',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              item['subtitle'] as String,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineNode(String status) {
    if (status == 'completed') {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 14.0,
        ),
      );
    } else if (status == 'active') {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      );
    } else {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.outlineVariant.withOpacity(0.5),
            width: 2.0,
          ),
        ),
      );
    }
  }

  Widget _buildSystemLogsCard(List<Map<String, dynamic>> logs) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Logs',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 16.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: logs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) {
              final log = logs[index];
              final logType = log['type'] as String;

              return Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: Row(
                  children: [
                    // Icon details
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getLogIcon(logType),
                        color: _getLogIconColor(logType),
                        size: 20.0,
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    // Log text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            log['title'] as String,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            log['subtitle'] as String,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.0,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getLogIcon(String type) {
    switch (type) {
      case 'create':
        return Icons.add_circle_outline_rounded;
      case 'update':
        return Icons.update_rounded;
      case 'activate':
        return Icons.task_alt_rounded;
      case 'edit':
        return Icons.edit_note_rounded;
      default:
        return Icons.history_toggle_off_rounded;
    }
  }

  Color _getLogIconColor(String type) {
    switch (type) {
      case 'create':
        return AppColors.primary;
      case 'update':
        return AppColors.primaryGradientEnd;
      case 'activate':
        return AppColors.success;
      case 'edit':
        return AppColors.error;
      default:
        return AppColors.onSurfaceVariant;
    }
  }
}
