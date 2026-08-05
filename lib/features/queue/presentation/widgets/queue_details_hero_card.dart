// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_entity.dart';

class QueueDetailsHeroCard extends StatelessWidget {
  final QueueEntity queueItem;

  const QueueDetailsHeroCard({
    super.key,
    required this.queueItem,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 960;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGradientStart.withOpacity(0.2),
            blurRadius: 20.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Decorative Circle
          Positioned(
            right: -40.0,
            top: -40.0,
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isMobile) ...[
                  // Mobile Layout: Stack elements vertically
                  Row(
                    children: [
                      _buildTokenBox(),
                      const SizedBox(width: 16.0),
                      Expanded(child: _buildNameAndStatus()),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  _buildMetricsGrid(),
                ] else ...[
                  // Tablet/Desktop Layout: Horizontal Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildTokenBox(),
                            const SizedBox(width: 24.0),
                            Expanded(child: _buildNameAndStatus()),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24.0),
                      _buildMetricsGrid(),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.white.withOpacity(0.25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            queueItem.token,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'TOKEN ID',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 9.0,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.7),
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameAndStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                queueItem.customerName,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10.0),
            _buildStatusChip(),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          '${queueItem.membershipLevel ?? "Premium Mall Member"} • Regular Visitor',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            color: Colors.white.withOpacity(0.9),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.2), // Success green tint
        borderRadius: BorderRadius.circular(99.0),
        border: Border.all(
          color: const Color(0xFF10B981).withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulsing Dot
          Container(
            width: 8.0,
            height: 8.0,
            decoration: const BoxDecoration(
              color: Color(0xFF34D399),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            queueItem.status.toDisplayString(),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD1FAE5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricColumn('EST. WAIT', '${queueItem.estimatedWaitMinutes} min'),
          _buildDivider(),
          _buildMetricColumn('GUESTS', '${queueItem.partySize}'),
          _buildDivider(),
          _buildMetricColumn('CHECK-IN', _formatTime(queueItem.checkInTime)),
        ],
      ),
    );
  }

  Widget _buildMetricColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 9.0,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.6),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 28.0,
      width: 1.0,
      color: Colors.white.withOpacity(0.15),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour == 0 ? 12 : (dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour);
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}
