import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../pages/create_reservation_page.dart';

class ReservationQuickActionsRow extends StatelessWidget {
  const ReservationQuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 600;
          return GridView.count(
            crossAxisCount: isSmall ? 2 : 4,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: isSmall ? 1.5 : 1.2,
            children: [
              _buildActionCard(
                icon: Icons.add_rounded,
                label: 'Add Reservation',
                isPrimary: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CreateReservationPage(),
                    ),
                  );
                },
              ),
              _buildActionCard(
                icon: Icons.list_alt_rounded,
                label: 'View All',
                isPrimary: true,
                onTap: () {},
              ),
              _buildActionCard(
                icon: Icons.search_rounded,
                label: 'Search',
                isPrimary: false,
                onTap: () {},
              ),
              _buildSoonCard(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withAlpha(12),
            blurRadius: 15.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  gradient: isPrimary
                      ? const LinearGradient(
                          colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
                        )
                      : null,
                  color: isPrimary ? null : AppColors.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isPrimary ? Colors.white : AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSoonCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(153),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.outlineVariant.withAlpha(51)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                  color: AppColors.outline,
                ),
              ),
              const SizedBox(height: 12.0),
              const Text(
                'Analytics',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                'SOON',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 8.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
