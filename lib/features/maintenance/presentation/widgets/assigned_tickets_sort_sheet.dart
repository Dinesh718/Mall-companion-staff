import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/assigned_ticket_sort.dart';
import '../bloc/assigned_tickets/assigned_tickets_bloc.dart';
import '../bloc/assigned_tickets/assigned_tickets_event.dart';

class AssignedTicketsSortSheet extends StatefulWidget {
  final AssignedTicketSort currentSort;

  const AssignedTicketsSortSheet({
    super.key,
    required this.currentSort,
  });

  @override
  State<AssignedTicketsSortSheet> createState() => _AssignedTicketsSortSheetState();
}

class _AssignedTicketsSortSheetState extends State<AssignedTicketsSortSheet> {
  late AssignedTicketSort _selectedSort;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.currentSort;
  }

  void _applySort() {
    context.read<AssignedTicketsBloc>().add(ApplySortRequested(_selectedSort));
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Text(
                'Sort Tickets',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ),
            const Divider(color: AppColors.outlineVariant, height: 1),
            
            // Sort Options
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: AssignedTicketSort.values.map((sortOption) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedSort = sortOption;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                sortOption.toDisplayString(),
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16.0,
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                            if (_selectedSort == sortOption)
                              const Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                              )
                            else
                              const Icon(
                                Icons.circle_outlined,
                                color: AppColors.onSurfaceVariant,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            
            // Apply Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: FilledButton(
                onPressed: _applySort,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Apply Sort',
                  style: TextStyle(
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
}
