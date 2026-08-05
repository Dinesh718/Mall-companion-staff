// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_stat_card.dart';
import '../../domain/entities/store_entity.dart';

class StatisticsSection extends StatelessWidget {
  final StoreEntity store;

  const StatisticsSection({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 600 ? 4 : 2;

    final stats = [
      _StatItem(
        icon: Icons.group_rounded,
        value: store.visitorsCount,
        label: "Today's Visitors",
        color: AppColors.primary,
        bgColor: AppColors.primary.withOpacity(0.05),
      ),
      _StatItem(
        icon: Icons.reviews_outlined,
        value: store.rating.toString(),
        label: 'Avg Rating',
        color: Colors.amber[700]!,
        bgColor: Colors.amber[50]!,
      ),
      _StatItem(
        icon: Icons.local_offer_outlined,
        value: store.activeOffersCount.toString().padLeft(2, '0'),
        label: 'Active Offers',
        color: Colors.blue[600]!,
        bgColor: Colors.blue[50]!,
      ),
      _StatItem(
        icon: Icons.book_online_outlined,
        value: store.reservationsCount.toString().padLeft(2, '0'),
        label: 'Reservations',
        color: Colors.purple[600]!,
        bgColor: Colors.purple[50]!,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.1,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) {
          final stat = stats[index];
          return AppStatCard(
            icon: stat.icon,
            value: stat.value,
            label: stat.label,
            color: stat.color,
            bgColor: stat.bgColor,
          );
        },
      ),
    );
  }
}

class _StatItem {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final Color bgColor;

  _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.bgColor,
  });
}
