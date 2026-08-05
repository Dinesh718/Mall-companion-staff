// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

class BottomNavigationItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const BottomNavigationItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationItemData> items;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    const navBarHeight = 64.0;

    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        // 1. Navigation Bar Glass Background Container
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
        // 2. Interactive Row of Tabs overlapping the boundary
        Container(
          height: navBarHeight + bottomPadding + 20.0, // extra height for pop-up animation
          padding: EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            bottom: bottomPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Expanded(
                child: _BottomNavItem(
                  icon: item.icon,
                  activeIcon: item.activeIcon,
                  label: item.label,
                  isActive: selectedIndex == index,
                  onTap: () => onTap(index),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Animated floating icon circle
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            bottom: isActive ? 34.0 : 18.0, // rises up above the bar when active
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: isActive ? 48.0 : 40.0,
              height: isActive ? 48.0 : 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isActive
                    ? const LinearGradient(
                        colors: [Color(0xFF7B2FF7), Color(0xFF3B82F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: const Color(0xFF7B2FF7).withOpacity(0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                isActive ? activeIcon : icon,
                color: isActive
                    ? Colors.white
                    : const Color(0xFF1D1A25).withOpacity(0.4),
                size: 24.0,
              ),
            ),
          ),
          // Animated label text
          Positioned(
            bottom: 4.0,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10.0,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive
                    ? const Color(0xFF6100D6)
                    : const Color(0xFF1D1A25).withOpacity(0.5),
              ),
              child: Text(label),
            ),
          ),
        ],
      ),
    );
  }
}
