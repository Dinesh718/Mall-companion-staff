// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_avatar.dart';

class StoreProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  final String storeBannerUrl;
  final bool showBackButton;

  const StoreProfileHeader({
    super.key,
    required this.storeBannerUrl,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 0.5,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.primary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      title: Text(
        'Store Profile',
        style: theme.textTheme.titleLarge?.copyWith(
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.edit_square,
            color: AppColors.primary,
            size: 24.0,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Edit Profile screen navigation (future milestone)'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const SizedBox(width: 4.0),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: AppAvatar(
            imageUrl: storeBannerUrl,
            size: 32.0,
            borderWidth: 1.0,
            borderColor: AppColors.outlineVariant.withOpacity(0.3),
            fallbackIcon: Icons.storefront,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
