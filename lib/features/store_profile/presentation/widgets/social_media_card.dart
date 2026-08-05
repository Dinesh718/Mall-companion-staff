// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_info_card.dart';
import '../../../../core/shared/presentation/widgets/app_section_header.dart';
import '../../domain/entities/store_entity.dart';

class SocialMediaCard extends StatelessWidget {
  final StoreEntity store;

  const SocialMediaCard({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 700;

    final contactInfo = [
      _ContactItem(
        icon: Icons.call_outlined,
        label: 'Phone',
        value: store.phoneNumber,
      ),
      _ContactItem(
        icon: Icons.mail_outline_rounded,
        label: 'Enterprise Email',
        value: store.email,
      ),
      _ContactItem(
        icon: Icons.language_rounded,
        label: 'Website',
        value: store.website,
      ),
    ];

    Widget buildContactSection() {
      return Column(
        children: contactInfo.map((item) {
          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening ${item.label} (${item.value})'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.icon,
                      color: AppColors.primary,
                      size: 20.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            color: AppColors.textGray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          item.value,
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
                ],
              ),
            ),
          );
        }).toList(),
      );
    }

    Widget buildSocialSection() {
      return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F1FF), // surface-container-low
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Social Presence',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.0,
                color: AppColors.textGray,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _buildSocialIcon(
                    icon: Icons.photo_camera_rounded,
                    label: 'Instagram',
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFCAF45),
                        Color(0xFFE1306C),
                        Color(0xFF833AB4),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening Instagram (${store.instagramUrl})'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: _buildSocialIcon(
                    icon: Icons.qr_code_2_rounded,
                    label: 'Facebook',
                    color: const Color(0xFF1877F2),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening Facebook (${store.facebookUrl})'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: _buildSocialIcon(
                    icon: Icons.close_rounded,
                    label: 'X / Twitter',
                    color: Colors.black,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening X (${store.twitterUrl})'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return AppInfoCard(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          const AppSectionHeader(
            title: 'Connect & Social',
            icon: Icon(
              Icons.public_rounded,
              color: AppColors.primary,
              size: 24.0,
            ),
            horizontalPadding: 0.0,
          ),
          const SizedBox(height: 24.0),

          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: buildContactSection()),
                const SizedBox(width: 24.0),
                Expanded(child: buildSocialSection()),
              ],
            )
          else
            Column(
              children: [
                buildContactSection(),
                const SizedBox(height: 20.0),
                buildSocialSection(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String label,
    Color? color,
    Gradient? gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: color,
              gradient: gradient,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textNavy,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ContactItem {
  final IconData icon;
  final String label;
  final String value;

  _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}
