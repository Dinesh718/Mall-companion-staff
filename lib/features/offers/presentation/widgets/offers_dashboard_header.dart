// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_avatar.dart';
import '../../../../core/shared/presentation/widgets/app_badge.dart';

class OffersDashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const OffersDashboardHeader({
    super.key,
    required this.showBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.8),
      elevation: 0.5,
      centerTitle: false,
      leadingWidth: showBackButton ? 56.0 : 0.0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.primary,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : const SizedBox.shrink(),
      titleSpacing: showBackButton ? 0.0 : 16.0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppAvatar(
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB5lWgp0BrS5kbANMkU43j4Q0TBLokSnAy39agqFUPBrc2C_-g7vvF23Cl8rjq6wcR7socTxczXGHuJuDu0vJQOkUdiUII0nPhogUjOwKgKBoq8Wj4aD5-MO78S9H5jKwKu_sipPlaQbPtPs-xzU0sLFluqezAxMzubF59ZBfLs9p_tSLDOvpEug-IJRQW2fujo8rKYp6M0LcBypwpyYYZNuYgm8FJxlXcXqhSS0dUrDUY3pWgr9dq-LYaJYv0Qb-N9x7O17wE_EQ',
            size: 40.0,
            borderWidth: 2.0,
            borderColor: Color(0xFFECFDF5),
          ),
          const SizedBox(width: 12.0),
          const Text(
            'MallElite',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
            color: AppColors.primary,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Search activated (mock)'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            icon: AppBadge(
              label: ' ', // red badge dot
              backgroundColor: AppColors.error,
              child: const Icon(
                Icons.notifications_outlined,
                color: AppColors.primary,
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications clicked (mock)'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
