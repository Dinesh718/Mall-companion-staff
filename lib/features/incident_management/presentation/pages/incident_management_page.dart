import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../bloc/incident_management_bloc.dart';
import '../bloc/incident_management_event.dart';
import '../bloc/incident_management_state.dart';
import '../widgets/incident_overview_hero_card.dart';
import '../widgets/incident_filter_bar.dart';
import '../widgets/incident_card.dart';
import '../widgets/incident_summary_sticky_card.dart';

class IncidentManagementPage extends StatefulWidget {
  const IncidentManagementPage({super.key});

  @override
  State<IncidentManagementPage> createState() => _IncidentManagementPageState();
}

class _IncidentManagementPageState extends State<IncidentManagementPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showStickyCard = false;

  @override
  void initState() {
    super.initState();
    context.read<IncidentManagementBloc>().add(const LoadIncidentsRequested());
    
    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && !_showStickyCard) {
        setState(() => _showStickyCard = true);
      } else if (_scrollController.offset <= 100 && _showStickyCard) {
        setState(() => _showStickyCard = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<IncidentManagementBloc, IncidentManagementState>(
        builder: (context, state) {
          if (state is IncidentManagementInitial || state is IncidentManagementLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (state is IncidentManagementError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 60.0),
                  const SizedBox(height: 16.0),
                  Text(
                    'Failed to load incidents',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(state.message, style: const TextStyle(fontFamily: 'Inter', color: Colors.grey)),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      context.read<IncidentManagementBloc>().add(const LoadIncidentsRequested());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is IncidentManagementLoaded) {
            return Stack(
              children: [
                RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () async {
                    context.read<IncidentManagementBloc>().add(const RefreshIncidentsRequested());
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    slivers: [
                      // AppBar
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        backgroundColor: Colors.white.withAlpha(178), // glass-overlay
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        titleSpacing: 16.0,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(1.0),
                          child: Container(
                            color: AppColors.outlineVariant.withAlpha(76),
                            height: 1.0,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Incident Management',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                height: 1.2,
                              ),
                            ),
                            Text(
                              'Security Staff',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.search, color: AppColors.primary),
                            onPressed: () {},
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.filter_list, color: AppColors.primary),
                                onPressed: () {},
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                    color: AppColors.error,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.surface, width: 1.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8.0),
                        ],
                      ),
                      
                      // Body
                      SliverPadding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 100.0), // padding for bottom nav
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            IncidentOverviewHeroCard(overview: state.overview),
                            
                            // Transform filter bar to bleed to edges
                            Transform.translate(
                              offset: const Offset(-16.0, 0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: IncidentFilterBar(
                                  currentFilter: state.currentFilter,
                                  onFilterSelected: (filter) {
                                    context.read<IncidentManagementBloc>().add(FilterChanged(filter: filter));
                                  },
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 32.0),
                            
                            if (state.incidents.isEmpty)
                              _buildEmptyState()
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.incidents.length,
                                itemBuilder: (context, index) {
                                  return IncidentCard(
                                    incident: state.incidents[index],
                                    onManageTap: () {
                                      // Placeholder for Phase 12.3
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Navigate to Incident Details (Phase 12.3)')),
                                      );
                                    },
                                  );
                                },
                              ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Sticky Summary Card
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  bottom: _showStickyCard ? 0.0 : -100.0,
                  left: 0,
                  right: 0,
                  child: IncidentSummaryStickyCard(
                    summary: state.summary,
                    onRefresh: () {
                      context.read<IncidentManagementBloc>().add(const RefreshIncidentsRequested());
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 128.0,
              height: 128.0,
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.upcoming_outlined,
                size: 60.0,
                color: AppColors.primary.withAlpha(102),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'No active incidents',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Everything looks clear. You'll see new incident reports here as they arrive.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.0,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
