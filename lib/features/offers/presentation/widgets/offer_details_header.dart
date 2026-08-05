import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_badge.dart';

class OfferDetailsHeader extends StatelessWidget implements PreferredSizeWidget {
  const OfferDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF8F9FF),
      elevation: 0,
      scrolledUnderElevation: 1.0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: AppColors.primary,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'Offer Details',
        style: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
      ),
      actions: [
        IconButton(
          icon: AppBadge(
            label: ' ', // red dot
            backgroundColor: AppColors.error,
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.onSurfaceVariant,
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
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: Container(
            width: 36.0,
            height: 36.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDulLbBGQJLZG942BEab0dbR-Q7-sGdW74RQ3ZVwpM_X_s73Pm-xJl8BffIabqVNlFwnpWQUVc3PWzTxU35IVt6xEowWDyo7mlAMG1h3GHv5ZAOCaK0ZY1vfT2w48nazLDVYx5u0E9xAp1jQjLtgX2xNiqrcusiSX_igEfIE-IKNCKsGx53BEo-YM4MARE3DC1XnnnS49A5ERkDwiyNfoVmLRwodLZkDZsjRlZKGgmY3tWc0Fgj2kEJG0pYzIxE2SIDyNUwUlwOHA',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.person_rounded,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
