import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../domain/entities/assigned_ticket_filter.dart';

class MaintenanceFilterSheet extends StatefulWidget {
  final Set<AssignedTicketFilter> initialFilters;
  final ValueChanged<Set<AssignedTicketFilter>> onApplyFilters;

  const MaintenanceFilterSheet({
    super.key,
    required this.initialFilters,
    required this.onApplyFilters,
  });

  @override
  State<MaintenanceFilterSheet> createState() => _MaintenanceFilterSheetState();
}

class _MaintenanceFilterSheetState extends State<MaintenanceFilterSheet> {
  late Set<AssignedTicketFilter> _selectedFilters;

  @override
  void initState() {
    super.initState();
    _selectedFilters = Set.from(widget.initialFilters);
    _selectedFilters.remove(AssignedTicketFilter.all);
  }

  void _toggleFilter(AssignedTicketFilter filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
  }

  void _clearAll() {
    setState(() {
      _selectedFilters.clear();
    });
  }

  void _applyFilters() {
    widget.onApplyFilters(_selectedFilters);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle & Title
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
              child: Center(
                child: Container(
                  width: 40.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: _clearAll,
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.outlineVariant, height: 1),
            
            // Filter Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterSection(
                      title: 'Status',
                      filters: [
                        AssignedTicketFilter.statusAssigned,
                        AssignedTicketFilter.statusAccepted,
                        AssignedTicketFilter.statusInProgress,
                        AssignedTicketFilter.statusPaused,
                        AssignedTicketFilter.statusEscalated,
                        AssignedTicketFilter.statusResolved,
                        AssignedTicketFilter.statusClosed,
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    _buildFilterSection(
                      title: 'Priority',
                      filters: [
                        AssignedTicketFilter.priorityCritical,
                        AssignedTicketFilter.priorityHigh,
                        AssignedTicketFilter.priorityMedium,
                        AssignedTicketFilter.priorityLow,
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    _buildFilterSection(
                      title: 'Category',
                      filters: [
                        AssignedTicketFilter.categoryElectrical,
                        AssignedTicketFilter.categoryPlumbing,
                        AssignedTicketFilter.categoryHVAC,
                        AssignedTicketFilter.categoryCleaning,
                        AssignedTicketFilter.categoryLighting,
                        AssignedTicketFilter.categoryEscalator,
                        AssignedTicketFilter.categoryFireSafety,
                        AssignedTicketFilter.categoryGeneral,
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    _buildFilterSection(
                      title: 'Floor',
                      filters: [
                        AssignedTicketFilter.floorBasement,
                        AssignedTicketFilter.floorGround,
                        AssignedTicketFilter.floorFirst,
                        AssignedTicketFilter.floorSecond,
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    _buildFilterSection(
                      title: 'Time',
                      filters: [
                        AssignedTicketFilter.timeToday,
                        AssignedTicketFilter.timeYesterday,
                        AssignedTicketFilter.timeLast7Days,
                        AssignedTicketFilter.timeLast30Days,
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Apply Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: FilledButton(
                onPressed: _applyFilters,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  _selectedFilters.isEmpty 
                    ? 'Apply Filters' 
                    : 'Apply ${_selectedFilters.length} Filter${_selectedFilters.length > 1 ? 's' : ''}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection({required String title, required List<AssignedTicketFilter> filters}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: filters.map((filter) {
            final isSelected = _selectedFilters.contains(filter);
            return FilterChip(
              label: Text(filter.toDisplayString()),
              selected: isSelected,
              onSelected: (_) => _toggleFilter(filter),
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFFF3E8FF), // Light purple
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                fontFamily: 'Inter',
                color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99.0),
                side: BorderSide(
                  color: isSelected ? const Color(0xFFE9D5FF) : AppColors.outlineVariant,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
