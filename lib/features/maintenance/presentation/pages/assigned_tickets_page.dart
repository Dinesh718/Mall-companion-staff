import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../data/repositories/mock_maintenance_repository.dart';
import '../../domain/usecases/get_assigned_tickets_usecase.dart';
import 'ticket_details_page.dart';
import '../bloc/assigned_tickets/assigned_tickets_bloc.dart';
import '../bloc/assigned_tickets/assigned_tickets_event.dart';
import '../bloc/assigned_tickets/assigned_tickets_state.dart';
import '../widgets/assigned_ticket_card.dart';
import '../widgets/assigned_tickets_filter_chips.dart';
import '../widgets/assigned_tickets_header.dart';
import '../widgets/assigned_tickets_search_bar.dart';
import '../widgets/assigned_tickets_stats_grid.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';

class AssignedTicketsPage extends StatelessWidget {
  const AssignedTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignedTicketsBloc(
        repository: MockMaintenanceRepository(),
        getAssignedTicketsUseCase: GetAssignedTicketsUseCase(
          repository: MockMaintenanceRepository(),
        ),
      )..add(const LoadAssignedTickets()),
      child: const _AssignedTicketsView(),
    );
  }
}

class _AssignedTicketsView extends StatelessWidget {
  const _AssignedTicketsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignedTicketsBloc, AssignedTicketsState>(
      builder: (context, state) {
        if (state is AssignedTicketsLoading || state is AssignedTicketsInitial) {
          return const Scaffold(
            backgroundColor: AppColors.stitchBackground,
            body: Center(
              child: LoadingWidget(
                message: 'Loading assigned tickets...',
              ),
            ),
          );
        } else if (state is AssignedTicketsError) {
          return Scaffold(
            backgroundColor: AppColors.stitchBackground,
            body: Center(
              child: AppErrorWidget(
                message: state.errorMessage,
                onRetry: () {
                  context.read<AssignedTicketsBloc>().add(const LoadAssignedTickets());
                },
              ),
            ),
          );
        } else if (state is AssignedTicketsLoaded) {
          return Scaffold(
            backgroundColor: AppColors.stitchBackground,
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<AssignedTicketsBloc>().add(const LoadAssignedTickets());
              },
              color: AppColors.primary,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 48.0), // Status bar padding
                        AssignedTicketsHeader(
                          assignedCount: 12,
                          criticalCount: 3,
                          inProgressCount: 2,
                        ),
                        const SizedBox(height: 16.0),
                        AssignedTicketsSearchBar(
                          searchQuery: state.searchQuery,
                        ),
                        AssignedTicketsFilterChips(
                          activeFilters: state.activeFilters,
                        ),
                        AssignedTicketsStatsGrid(
                          assignedCount: 12,
                          criticalCount: 3,
                          inProgressCount: 2,
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                  
                  if (state.tickets.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: EmptyStateWidget(
                          title: 'No Tickets Found',
                          description: 'Try adjusting your search or filters.',
                          icon: Icons.confirmation_number_outlined,
                          action: ElevatedButton(
                            onPressed: () {
                              context.read<AssignedTicketsBloc>().add(const ClearFiltersRequested());
                            },
                            child: const Text('Clear Filters'),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final ticket = state.tickets[index];
                            return AssignedTicketCard(
                              ticket: ticket,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => TicketDetailsPage(ticketId: ticket.id),
                                  ),
                                );
                              },
                            );
                          },
                          childCount: state.tickets.length,
                        ),
                      ),
                    ),
                    
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 40.0), // Bottom padding before nav
                  ),
                ],
              ),
            ),
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }
}
