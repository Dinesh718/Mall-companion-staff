// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_info_card.dart';
import '../../../../core/shared/presentation/widgets/app_status_chip.dart';
import '../../domain/entities/store_entity.dart';

class StoreIdentityCard extends StatelessWidget {
  final StoreEntity store;

  const StoreIdentityCard({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppInfoCard(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFF3EBFA), // hero-gradient start
          Color(0xFFEADDFF), // hero-gradient end
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderColor: Colors.white.withOpacity(0.4),
      child: Column(
        children: [
          // Centered circular logo box
          Container(
            width: 96.0,
            height: 96.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1F2937).withOpacity(0.08),
                  blurRadius: 20.0,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              store.logoUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.storefront_rounded,
                color: AppColors.primary,
                size: 40.0,
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          // Store title and verified icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  store.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontFamily: 'Inter',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 6.0),
              const Icon(
                Icons.verified_rounded,
                color: AppColors.primary,
                size: 20.0,
              ),
            ],
          ),
          const SizedBox(height: 6.0),

          // Star Rating row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                5,
                (index) => const Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 18.0,
                ),
              ),
              const SizedBox(width: 4.0),
              Text(
                '(${store.rating}/5)',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Row of Category and Open badges
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.category_outlined,
                      color: AppColors.primary,
                      size: 16.0,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      store.category,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              AppStatusChip(
                label: store.isOpen ? 'Open Now' : 'Closed',
                textColor: store.isOpen ? const Color(0xFF047857) : const Color(0xFFB91C1C),
                backgroundColor: store.isOpen ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                borderColor: store.isOpen ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
                pulsingDotColor: store.isOpen ? const Color(0xFF10B981) : null,
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          // Grid layout metrics (Floor, Hours, Manager, Wing)
          LayoutBuilder(
            builder: (context, constraints) {
              return Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      _buildInfoCell(
                        icon: Icons.location_on_outlined,
                        text: '${store.floor} • ${store.unitNumber}',
                        isRightBorder: true,
                      ),
                      _buildInfoCell(
                        icon: Icons.schedule_rounded,
                        text: '${store.openingTime} – ${store.closingTime}',
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: _buildInfoCell(
                          icon: Icons.person_outline_rounded,
                          text: '${store.managerName} (Manager)',
                          isRightBorder: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: _buildInfoCell(
                          icon: Icons.near_me_outlined,
                          text: store.wing,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCell({
    required IconData icon,
    required String text,
    bool isRightBorder = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: isRightBorder
            ? Border(
                right: BorderSide(
                  color: AppColors.outlineVariant.withOpacity(0.3),
                  width: 1.0,
                ),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 18.0,
            color: AppColors.primary.withOpacity(0.7),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
