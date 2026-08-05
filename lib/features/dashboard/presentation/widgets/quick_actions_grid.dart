// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../store_profile/presentation/pages/store_profile_page.dart';
import '../../../offers/presentation/pages/offers_dashboard_page.dart';
import '../../../reservation/presentation/pages/reservation_dashboard_page.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final actions = [
      _ActionItem(
        icon: Icons.storefront_rounded,
        title: 'Store Profile',
        color: AppColors.primary,
        bgColor: AppColors.primary.withOpacity(0.05),
      ),
      _ActionItem(
        icon: Icons.campaign_outlined,
        title: 'Manage Offers',
        color: AppColors.secondary,
        bgColor: AppColors.secondary.withOpacity(0.05),
      ),
      _ActionItem(
        icon: Icons.reorder_rounded,
        title: 'Queue Mgmt',
        color: AppColors.primary,
        bgColor: AppColors.primary.withOpacity(0.05),
      ),
      _ActionItem(
        icon: Icons.calendar_month_outlined,
        title: 'Reservations',
        color: AppColors.secondary,
        bgColor: AppColors.secondary.withOpacity(0.05),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Quick Actions',
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: 'Inter',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textNavy,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 160.0,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: actions.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16.0),
            itemBuilder: (context, index) {
              final action = actions[index];
              return Container(
                width: 140.0,
                height: 160.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1F2937).withOpacity(0.05),
                      blurRadius: 12.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (action.title == 'Store Profile') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StoreProfilePage(),
                          ),
                        );
                      } else if (action.title == 'Manage Offers') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OffersDashboardPage(showBackButton: true),
                          ),
                        );
                      } else if (action.title == 'Reservations') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReservationDashboardPage(showBackButton: true),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${action.title} clicked (mock)'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 64.0,
                          height: 64.0,
                          decoration: BoxDecoration(
                            color: action.bgColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Icon(
                            action.icon,
                            color: action.color,
                            size: 32.0,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          action.title,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textNavy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String title;
  final Color color;
  final Color bgColor;

  _ActionItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.bgColor,
  });
}
