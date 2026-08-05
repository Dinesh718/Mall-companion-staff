import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';

class ActivityHeader extends StatelessWidget {
  const ActivityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.stitchBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF2170E4), // Secondary container color
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDmISmaSBleiaU3PzLtoKrAzrabHO4p9K6VJ8U3els_jGQl989sGeIDN6QebXrk_2kxwJXbW8-XSBedsVDEPuWmI-O8IDQUzjJH2Am7YgHx55aGQp_pTS0YfeI8rIqWgYXGpeZQ1_Z2erDd--MS8ZYrLfpHYqpG4PJSsk9U8xQMfW75XKMdjJPgTDhNBwudVYOF7PaWufrTPVU4Agk5Q7gheqlULo5FQ4Y8w3OKODd2cfmJ9bLptRM',
                  fit: BoxFit.cover,
                  width: 40.0,
                  height: 40.0,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'Work History',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      color: AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(99.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.notifications_rounded,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
