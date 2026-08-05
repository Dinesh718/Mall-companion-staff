import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/assigned_tickets/assigned_tickets_bloc.dart';
import '../bloc/assigned_tickets/assigned_tickets_event.dart';
import '../bloc/assigned_tickets/assigned_tickets_state.dart';
import 'assigned_tickets_filter_sheet.dart';
import 'assigned_tickets_sort_sheet.dart';
import 'shared/maintenance_search_bar.dart';

class AssignedTicketsSearchBar extends StatelessWidget {
  final String searchQuery;

  const AssignedTicketsSearchBar({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignedTicketsBloc, AssignedTicketsState>(
      builder: (context, state) {
        return MaintenanceSearchBar(
          searchQuery: searchQuery,
          onSearchChanged: (query) {
            context.read<AssignedTicketsBloc>().add(SearchTicketsRequested(query));
          },
          onClearSearch: () {
            context.read<AssignedTicketsBloc>().add(const SearchTicketsRequested(''));
          },
          onFilterTap: state is AssignedTicketsLoaded 
            ? () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (bottomSheetContext) => BlocProvider.value(
                    value: context.read<AssignedTicketsBloc>(),
                    child: AssignedTicketsFilterSheet(
                      initialFilters: state.activeFilters,
                    ),
                  ),
                );
              }
            : null,
          onSortTap: state is AssignedTicketsLoaded
            ? () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (bottomSheetContext) => BlocProvider.value(
                    value: context.read<AssignedTicketsBloc>(),
                    child: AssignedTicketsSortSheet(
                      currentSort: state.activeSort,
                    ),
                  ),
                );
              }
            : null,
        );
      },
    );
  }
}
