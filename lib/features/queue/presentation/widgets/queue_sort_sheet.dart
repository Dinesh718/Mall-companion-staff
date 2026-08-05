import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_sort_option.dart';

class QueueSortSheet extends StatelessWidget {
  final QueueSortOption activeSort;

  const QueueSortSheet({
    super.key,
    required this.activeSort,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 48.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Sort Queue By',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textNavy,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Options
            ...QueueSortOption.values.map((option) {
              final isSelected = activeSort == option;
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
                title: Text(
                  option.toDisplayString(),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15.0,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.primary : AppColors.textNavy,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.primary,
                      )
                    : null,
                onTap: () {
                  Navigator.pop(context, option);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
