// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_info_card.dart';
import '../../../../core/shared/presentation/widgets/app_section_header.dart';
import '../../../../core/shared/presentation/widgets/app_status_chip.dart';
import '../../domain/entities/store_entity.dart';

class OperationalStatusCard extends StatelessWidget {
  final StoreEntity store;

  const OperationalStatusCard({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamic icon mapper for amenities
    IconData getAmenityIcon(String name) {
      switch (name.toLowerCase()) {
        case 'wifi':
          return Icons.wifi;
        case 'digital pay':
          return Icons.payments_outlined;
        case 'trial':
          return Icons.checkroom_outlined;
        case 'styling':
          return Icons.shopping_bag_outlined;
        default:
          return Icons.star_border_rounded;
      }
    }

    return AppInfoCard(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          const AppSectionHeader(
            title: 'Real-time Pulse',
            icon: Icon(
              Icons.sensors_rounded,
              color: AppColors.primary,
              size: 24.0,
            ),
            horizontalPadding: 0.0,
          ),
          const SizedBox(height: 20.0),

          // Crowd Level
          _buildPulseRow(
            icon: Icons.groups_outlined,
            title: 'Crowd Level',
            subtitle: 'Optimal flow currently',
            badgeText: store.crowdLevel,
            badgeBgColor: Colors.amber[50]!,
            badgeTextColor: Colors.amber[800]!,
          ),
          const SizedBox(height: 12.0),

          // Current Queue
          _buildPulseRow(
            icon: Icons.hourglass_empty_rounded,
            title: 'Current Queue',
            subtitle: 'Trial rooms & checkout',
            badgeText: store.currentQueueTime,
            badgeBgColor: AppColors.primary.withOpacity(0.08),
            badgeTextColor: AppColors.primary,
          ),
          const SizedBox(height: 12.0),

          // Service Elevators
          _buildPulseRow(
            icon: Icons.check_circle_outline_rounded,
            title: 'Service Elevators',
            subtitle: 'Last checked: 10 mins ago',
            badgeText: store.serviceElevatorsStatus,
            badgeBgColor: const Color(0xFFECFDF5),
            badgeTextColor: const Color(0xFF047857),
          ),
          const SizedBox(height: 24.0),

          // Amenities
          const Text(
            'Available Amenities',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.0,
              color: AppColors.textGray,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: store.amenities.map((amenity) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F1FF), // surface-container-low
                  borderRadius: BorderRadius.circular(99.0),
                  border: Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      getAmenityIcon(amenity),
                      size: 14.0,
                      color: AppColors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      amenity,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPulseRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required String badgeText,
    required Color badgeBgColor,
    required Color badgeTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC), // secondary bg
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: badgeTextColor,
                size: 24.0,
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textNavy,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.0,
                      color: AppColors.textGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppStatusChip(
            label: badgeText,
            textColor: badgeTextColor,
            backgroundColor: badgeBgColor,
          ),
        ],
      ),
    );
  }
}
