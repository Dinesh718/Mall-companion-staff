// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_info_card.dart';
import '../../../../core/shared/presentation/widgets/app_section_header.dart';
import '../../domain/entities/store_entity.dart';

class LocationCard extends StatelessWidget {
  final StoreEntity store;

  const LocationCard({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return AppInfoCard(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          const AppSectionHeader(
            title: 'Mall Navigation',
            icon: Icon(
              Icons.map_outlined,
              color: AppColors.primary,
              size: 24.0,
            ),
            horizontalPadding: 0.0,
          ),
          const SizedBox(height: 20.0),

          // Mall Detail row
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F1FF), // surface-container-low
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_city_outlined,
                      color: AppColors.primary,
                      size: 20.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      store.mallName,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textNavy,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${store.floor}, ${store.unitNumber.replaceAll('Unit ', '')}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // Access Points grid
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F1FF),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nearest Gate',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.0,
                          color: AppColors.textGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.meeting_room_outlined,
                            size: 16.0,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              store.nearestGate,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textNavy,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F1FF),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Access Point',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.0,
                          color: AppColors.textGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.elevator_outlined,
                            size: 16.0,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              store.accessPoint,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textNavy,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Walking Time
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F1FF),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Walking Time',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.0,
                    color: AppColors.textGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Icon(
                      Icons.directions_walk_rounded,
                      size: 16.0,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      store.walkingTime,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textNavy,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          // Static map with interactive overlay
          Container(
            height: 208.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: AppColors.outlineVariant.withOpacity(0.3),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    store.mapImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primary.withOpacity(0.05),
                      child: const Icon(
                        Icons.map_rounded,
                        color: AppColors.primary,
                        size: 48.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12.0,
                  left: 12.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(99.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.open_in_new_rounded,
                          size: 14.0,
                          color: AppColors.textNavy,
                        ),
                        SizedBox(width: 6.0),
                        Text(
                          'Interactive Map',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textNavy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
