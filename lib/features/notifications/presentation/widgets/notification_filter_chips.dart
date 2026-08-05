import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../domain/entities/notification_filter.dart';

class NotificationFilterChips extends StatelessWidget {
  final NotificationFilter activeFilter;
  final ValueChanged<NotificationFilter> onFilterSelected;

  const NotificationFilterChips({
    super.key,
    required this.activeFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        children: NotificationFilter.values.map((filter) {
          final isActive = filter == activeFilter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () => onFilterSelected(filter),
              borderRadius: BorderRadius.circular(99.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                decoration: BoxDecoration(
                  gradient: isActive
                      ? const LinearGradient(
                          colors: [AppColors.primary, Color(0xFF3B82F6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isActive ? null : AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(99.0),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  filter.toDisplayString(),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: isActive ? Colors.white : AppColors.onSurface,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
