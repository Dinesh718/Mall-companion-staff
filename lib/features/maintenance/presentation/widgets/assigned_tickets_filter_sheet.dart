import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/assigned_ticket_filter.dart';
import '../bloc/assigned_tickets/assigned_tickets_bloc.dart';
import '../bloc/assigned_tickets/assigned_tickets_event.dart';
import 'shared/maintenance_filter_sheet.dart';

class AssignedTicketsFilterSheet extends StatelessWidget {
  final Set<AssignedTicketFilter> initialFilters;

  const AssignedTicketsFilterSheet({
    super.key,
    required this.initialFilters,
  });

  @override
  Widget build(BuildContext context) {
    return MaintenanceFilterSheet(
      initialFilters: initialFilters,
      onApplyFilters: (filters) {
        if (filters.isEmpty) {
          context.read<AssignedTicketsBloc>().add(const ClearFiltersRequested());
        } else {
          context.read<AssignedTicketsBloc>().add(ApplyFiltersRequested(filters));
        }
      },
    );
  }
}
