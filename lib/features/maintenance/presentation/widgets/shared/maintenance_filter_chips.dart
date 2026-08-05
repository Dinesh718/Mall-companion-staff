import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../domain/entities/assigned_ticket_filter.dart';

class MaintenanceFilterChips extends StatelessWidget {
  final Set<AssignedTicketFilter> activeFilters;
  final ValueChanged<AssignedTicketFilter> onRemoveFilter;
  final VoidCallback onClearFilters;

  const MaintenanceFilterChips({
    super.key,
    required this.activeFilters,
    required this.onRemoveFilter,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    if (activeFilters.isEmpty || (activeFilters.length == 1 && activeFilters.contains(AssignedTicketFilter.all))) {
      return const SizedBox.shrink();
    }

    // Filter out 'all' from display
    final displayFilters = activeFilters.where((f) => f != AssignedTicketFilter.all).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 24.0, bottom: 16.0),
      child: SizedBox(
        height: 32.0,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: displayFilters.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          itemBuilder: (context, index) {
            final filter = displayFilters[index];
            return InkWell(
              onTap: () => onRemoveFilter(filter),
              borderRadius: BorderRadius.circular(99.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFF3B82F6)], // Violet to Blue
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(99.0),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      filter.toDisplayString(),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
