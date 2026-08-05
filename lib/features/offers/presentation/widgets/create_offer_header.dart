import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class CreateOfferHeader extends StatelessWidget implements PreferredSizeWidget {
  const CreateOfferHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
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
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Offer',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          Text(
            'Create a promotional campaign for your customers.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.0,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.onSurfaceVariant,
          ),
          onPressed: () {},
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
              'https://lh3.googleusercontent.com/aida-public/AB6AXuA-KzLFbUYbYchegRiq9ScREKLN16BhKTzFp5BCNUN577PLFqPq_5VQvk650DTyFRWFb2LpB2X6ioqNq1leiyLOPsy8d4g2cuLbXVihtLrxB4vJOLjMbkDJeSkOM7NBnMjHq4KlhrsxjKMFdjf7hO-FNwU8B69xzuNiWB-ZxJr-BLoWDKIjObwAfItluLtifT6oBhVMrOmnR48XvFYTF8oT3YH7p_dpKQpFe_BVZ1P8Jps3Z6UEyi9hjWu0l1yTTfv8Yer8cErv_g',
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10.0);
}
