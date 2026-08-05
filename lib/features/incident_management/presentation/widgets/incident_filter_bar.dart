import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/incident_filter_entity.dart';

class IncidentFilterBar extends StatelessWidget {
  final IncidentFilterEntity currentFilter;
  final Function(IncidentFilterEntity) onFilterSelected;

  const IncidentFilterBar({
    super.key,
    required this.currentFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: IncidentFilterEntity.values.map((filter) {
          final isSelected = currentFilter == filter;
          final isCritical = filter == IncidentFilterEntity.critical;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => onFilterSelected(filter),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
                  color: isSelected ? null : AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withAlpha(12), // shadow-sm approx
                            blurRadius: 4.0,
                            offset: const Offset(0, 1),
                          )
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isCritical && !isSelected) ...[
                      const Icon(
                        Icons.report_rounded,
                        size: 14.0,
                        color: AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4.0),
                    ],
                    if (isCritical && isSelected) ...[
                      const Icon(
                        Icons.report_rounded,
                        size: 14.0,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4.0),
                    ],
                    Text(
                      _getFilterLabel(filter),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0, // label-lg
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

  String _getFilterLabel(IncidentFilterEntity filter) {
    switch (filter) {
      case IncidentFilterEntity.all:
        return 'All';
      case IncidentFilterEntity.assigned:
        return 'Assigned';
      case IncidentFilterEntity.critical:
        return 'Critical';
      case IncidentFilterEntity.responding:
        return 'Responding';
      case IncidentFilterEntity.pending:
        return 'Pending';
      case IncidentFilterEntity.resolved:
        return 'Resolved';
      case IncidentFilterEntity.today:
        return 'Today';
    }
  }
}
