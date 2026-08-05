import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/assigned_ticket_filter.dart';
import '../bloc/assigned_tickets/assigned_tickets_bloc.dart';
import '../bloc/assigned_tickets/assigned_tickets_event.dart';
import 'shared/maintenance_filter_chips.dart';

class AssignedTicketsFilterChips extends StatelessWidget {
  final Set<AssignedTicketFilter> activeFilters;

  const AssignedTicketsFilterChips({
    super.key,
    required this.activeFilters,
  });

  @override
  Widget build(BuildContext context) {
    return MaintenanceFilterChips(
      activeFilters: activeFilters,
      onRemoveFilter: (filter) {
        final updatedFilters = Set<AssignedTicketFilter>.from(activeFilters)..remove(filter);
        if (updatedFilters.isEmpty || (updatedFilters.length == 1 && updatedFilters.contains(AssignedTicketFilter.all))) {
          context.read<AssignedTicketsBloc>().add(const ClearFiltersRequested());
        } else {
          context.read<AssignedTicketsBloc>().add(RemoveFilterRequested(filter));
        }
      },
      onClearFilters: () {
        context.read<AssignedTicketsBloc>().add(const ClearFiltersRequested());
      },
    );
  }
}
