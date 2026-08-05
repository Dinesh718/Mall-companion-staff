// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class QueueBottomNavigation extends StatelessWidget {
  final VoidCallback onStoreTap;
  final VoidCallback onOffersTap;

  const QueueBottomNavigation({
    super.key,
    required this.onStoreTap,
    required this.onOffersTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    const navBarHeight = 64.0;

    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        // Glass Background
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: navBarHeight + bottomPadding,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                  width: 1.0,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 40.0,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),

        // Tabs Row
        Container(
          height: navBarHeight + bottomPadding + 10.0,
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: bottomPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Store Tab
              Expanded(
                child: GestureDetector(
                  onTap: onStoreTap,
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.storefront_rounded,
                        color: AppColors.onSurfaceVariant,
                        size: 24.0,
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Store',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onSurfaceVariant.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Offers Tab
              Expanded(
                child: GestureDetector(
                  onTap: onOffersTap,
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.local_offer_outlined,
                        color: AppColors.onSurfaceVariant,
                        size: 24.0,
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Offers',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onSurfaceVariant.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Queue Tab (Active)
              Expanded(
                child: Container(
                  height: 44.0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(99.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGradientStart.withOpacity(0.3),
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {}, // Already active
                      borderRadius: BorderRadius.circular(99.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.queue_play_next_rounded,
                            color: Colors.white,
                            size: 18.0,
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            'Queue',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
