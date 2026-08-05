import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class QuickActionData {
  final String label;
  final IconData icon;
  final bool isDestructive;
  final VoidCallback onTap;

  const QuickActionData({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });
}

class QuickActionGrid extends StatelessWidget {
  final String title;
  final List<QuickActionData> actions;

  const QuickActionGrid({
    super.key,
    required this.title,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 22.0, // title-lg
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12.0),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.5,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            final Color iconColor = action.isDestructive ? AppColors.error : AppColors.primary;
            
            return Material(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12.0),
              child: InkWell(
                onTap: action.onTap,
                borderRadius: BorderRadius.circular(12.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        action.icon,
                        color: iconColor,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        action.label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.0, // label-lg
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
