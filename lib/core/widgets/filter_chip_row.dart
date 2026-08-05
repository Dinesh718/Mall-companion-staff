import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class FilterChipData<T> {
  final String label;
  final T value;
  final IconData? icon;
  final bool isCritical;

  const FilterChipData({
    required this.label,
    required this.value,
    this.icon,
    this.isCritical = false,
  });
}

class FilterChipRow<T> extends StatelessWidget {
  final List<FilterChipData<T>> filters;
  final T selectedValue;
  final Function(T) onSelected;

  const FilterChipRow({
    super.key,
    required this.filters,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedValue == filter.value;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => onSelected(filter.value),
              child: Container(
                height: 40.0, // h-10
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF6B38D4),
                            AppColors.secondaryContainer,
                          ],
                        )
                      : null,
                  color: isSelected ? null : AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(100.0),
                  border: isSelected ? null : Border.all(color: AppColors.outlineVariant.withAlpha(76)),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withAlpha(12),
                            blurRadius: 4.0,
                            offset: const Offset(0, 1),
                          )
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (filter.isCritical && !isSelected) ...[
                      Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                    ],
                    if (filter.icon != null) ...[
                      Icon(
                        filter.icon,
                        size: 16.0,
                        color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8.0),
                    ],
                    Text(
                      filter.label,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
