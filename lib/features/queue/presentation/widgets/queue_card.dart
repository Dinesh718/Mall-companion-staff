// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_entity.dart';
import '../../domain/entities/queue_status.dart';

class QueueCard extends StatelessWidget {
  final QueueEntity queue;
  final VoidCallback onViewDetails;
  final VoidCallback onCallCustomer;

  const QueueCard({
    super.key,
    required this.queue,
    required this.onViewDetails,
    required this.onCallCustomer,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(queue.status);
    final statusBgColor = statusColor.withOpacity(0.1);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Row: Token & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGradientStart.withOpacity(0.2),
                      blurRadius: 8.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  queue.token,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(99.0),
                  border: Border.all(
                    color: statusColor.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      queue.status.toDisplayString(),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Customer Profile & Wait Time Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color(0xFFEFF4FF),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  queue.avatarUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFDEE8FF),
                      child: const Icon(
                        Icons.person_rounded,
                        color: AppColors.primary,
                        size: 28.0,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12.0),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      queue.customerName,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Wrap(
                      spacing: 12.0,
                      runSpacing: 4.0,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.groups_outlined,
                              size: 16.0,
                              color: AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              '${queue.partySize} ${queue.partySize == 1 ? 'person' : 'people'}',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.phone_outlined,
                              size: 16.0,
                              color: AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              queue.phoneNumber,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),

              // Wait Time Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${queue.estimatedWaitMinutes} min',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const Text(
                    'WAIT TIME',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Check-in Time Badge
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF), // surface-container-low
                borderRadius: BorderRadius.circular(99.0),
                border: Border.all(
                  color: AppColors.outlineVariant.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.schedule_rounded,
                    size: 14.0,
                    color: AppColors.darkBlue,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    'Checked in ${queue.estimatedWaitMinutes} mins ago',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // Actions Row
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 46.0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGradientStart.withOpacity(0.2),
                        blurRadius: 8.0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onViewDetails,
                      borderRadius: BorderRadius.circular(16.0),
                      child: const Center(
                        child: Text(
                          'View Details',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                  height: 46.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: AppColors.outlineVariant,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onCallCustomer,
                      borderRadius: BorderRadius.circular(16.0),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.phone_rounded,
                                size: 16.0,
                                color: AppColors.onSurfaceVariant,
                              ),
                              const SizedBox(width: 6.0),
                              Text(
                                'Call Customer',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.onSurfaceVariant.withOpacity(0.9),
                                ),
                              ),
                            ],
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
      ),
    );
  }

  Color _getStatusColor(QueueStatus status) {
    switch (status) {
      case QueueStatus.waiting:
        return AppColors.darkBlue;
      case QueueStatus.called:
        return const Color(0xFFF59E0B);
      case QueueStatus.arrived:
        return const Color(0xFF8B5CF6);
      case QueueStatus.serving:
        return const Color(0xFF10B981);
      case QueueStatus.completed:
        return AppColors.primary;
      case QueueStatus.cancelled:
        return AppColors.error;
    }
  }
}
