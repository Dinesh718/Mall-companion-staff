import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/overview_hero_card.dart';
import '../../../../core/widgets/filter_chip_row.dart';
import '../../../../core/widgets/timeline_widget.dart';
import '../../../../core/widgets/quick_action_grid.dart';
import '../../../../core/widgets/summary_sticky_card.dart';
import '../../domain/entities/emergency_filter_entity.dart';
import '../bloc/emergency_response_bloc.dart';
import '../bloc/emergency_response_event.dart';
import '../bloc/emergency_response_state.dart';
import '../widgets/emergency_card.dart';

class EmergencyResponsePage extends StatefulWidget {
  const EmergencyResponsePage({super.key});

  @override
  State<EmergencyResponsePage> createState() => _EmergencyResponsePageState();
}

class _EmergencyResponsePageState extends State<EmergencyResponsePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<EmergencyResponseBloc>().add(const LoadEmergenciesRequested());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen width for responsive layout
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<EmergencyResponseBloc, EmergencyResponseState>(
        builder: (context, state) {
          if (state is EmergencyResponseInitial || state is EmergencyResponseLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (state is EmergencyResponseError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 60.0),
                  const SizedBox(height: 16.0),
                  const Text('Failed to load emergencies', style: TextStyle(fontFamily: 'Inter', fontSize: 18.0, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                  const SizedBox(height: 8.0),
                  Text(state.message, style: const TextStyle(fontFamily: 'Inter', color: Colors.grey)),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () => context.read<EmergencyResponseBloc>().add(const LoadEmergenciesRequested()),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is EmergencyResponseLoaded) {
            return Stack(
              children: [
                RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () async {
                    context.read<EmergencyResponseBloc>().add(const RefreshRequested());
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    slivers: [
                      // AppBar
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        backgroundColor: AppColors.surface.withAlpha(230), // surface-container-low equivalent
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        titleSpacing: 16.0,
                        title: Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: const BoxDecoration(
                                color: AppColors.surfaceVariant,
                                shape: BoxShape.circle,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuAyv97uquK4HN78Wv4OYRxh_x2pt6DveA1ofp7hOufU0O60sc8I3inswCKczx4qk0bYgMZRYXoV8uTRwTRu4sUQw6u-mLfoh4ZpPfinWWnaeRCxSEzWPZ2l71girPkj4p8DK3L2yq35y6wwaV-TNknU1BDa8NCorhGgYVlkzGSo9zc9dP7qp0ZxnZ2asS82S_LDv1kjXQKq8sklYjy8XM0bjn8UkYmIM7u0aah5eYp6gUj6KFhz82c',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: AppColors.onSurfaceVariant),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Security Operations',
                                    style: TextStyle(fontFamily: 'Inter', fontSize: 22.0, fontWeight: FontWeight.bold, color: AppColors.primary, height: 1.2),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Emergency Response • Security Staff',
                                    style: TextStyle(fontFamily: 'Inter', fontSize: 12.0, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          IconButton(icon: const Icon(Icons.search, color: AppColors.onSurfaceVariant), onPressed: () {}),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              IconButton(icon: const Icon(Icons.notifications_outlined, color: AppColors.onSurfaceVariant), onPressed: () {}),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: AppColors.error,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.surface, width: 2.0),
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
                        padding: EdgeInsets.only(
                          left: isDesktop ? 24.0 : 16.0,
                          right: isDesktop ? 24.0 : 16.0,
                          top: 16.0,
                          bottom: 120.0, // space for sticky card and bottom nav
                        ),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            // 1. Hero Card
                            OverviewHeroCard(
                              title: 'Emergency Overview',
                              metrics: [
                                KPIMetricData(label: 'Active Emergencies', value: state.overview.activeEmergencies.toString().padLeft(2, '0')),
                                KPIMetricData(label: 'Critical', value: state.overview.criticalEmergencies.toString().padLeft(2, '0'), isCritical: true),
                                KPIMetricData(label: 'Available Officers', value: state.overview.availableOfficers.toString().padLeft(2, '0')),
                                KPIMetricData(label: 'Avg Response', value: '${state.overview.averageResponseTimeMinutes}m'),
                              ],
                            ),
                            
                            // 2. Filter Bar
                            Transform.translate(
                              offset: const Offset(-16.0, 0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: FilterChipRow<EmergencyFilterEntity>(
                                  selectedValue: state.currentFilter,
                                  onSelected: (filter) {
                                    context.read<EmergencyResponseBloc>().add(FilterChanged(filter: filter));
                                  },
                                  filters: const [
                                    FilterChipData(label: 'All', value: EmergencyFilterEntity.all),
                                    FilterChipData(label: 'Critical', value: EmergencyFilterEntity.critical, isCritical: true),
                                    FilterChipData(label: 'Fire', value: EmergencyFilterEntity.fire),
                                    FilterChipData(label: 'Medical', value: EmergencyFilterEntity.medical),
                                    FilterChipData(label: 'SOS', value: EmergencyFilterEntity.sos),
                                    FilterChipData(label: 'Lost Child', value: EmergencyFilterEntity.lostChild),
                                    FilterChipData(label: 'Accepted', value: EmergencyFilterEntity.accepted),
                                  ],
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 24.0),
                            
                            // 3. Grid Layout (Left Queue, Right Context/Actions)
                            if (isDesktop)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: _buildLiveQueue(state),
                                  ),
                                  const SizedBox(width: 24.0),
                                  Expanded(
                                    flex: 5,
                                    child: _buildRightColumn(state),
                                  ),
                                ],
                              )
                            else
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLiveQueue(state),
                                  const SizedBox(height: 24.0),
                                  _buildRightColumn(state),
                                ],
                              ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Summary Sticky Card (Desktop Only based on Stitch design classes 'hidden md:flex')
                // But typically we can show it everywhere or follow design. HTML says 'hidden md:flex'.
                // If it's a mobile layout mostly, maybe we should respect MediaQuery. Let's assume it should show.
                if (isDesktop)
                  SummaryStickyCard(
                    items: [
                      SummaryStickyData(label: 'Total', value: state.summary.totalEmergencies.toString()),
                      SummaryStickyData(label: 'Accepted', value: state.summary.accepted.toString(), isPrimary: true),
                      SummaryStickyData(label: 'Waiting', value: state.summary.waiting.toString(), isError: true),
                      SummaryStickyData(label: 'Resolved Today', value: state.summary.resolvedToday.toString(), isOutline: true),
                    ],
                  ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLiveQueue(EmergencyResponseLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Live Emergency Queue',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 22.0, // title-lg
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 16.0),
        if (state.emergencies.isEmpty)
          const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Text(
                'No emergencies match the selected filter.',
                style: TextStyle(fontFamily: 'Inter', color: AppColors.onSurfaceVariant),
              ),
            ),
          )
        else
          ...state.emergencies.map((emergency) => EmergencyCard(
            emergency: emergency,
            onAccept: () {
              // Placeholder logic per requirements
              context.read<EmergencyResponseBloc>().add(AcceptResponseRequested(emergencyId: emergency.id));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Accept Response logic triggered (Placeholder)')),
              );
            },
            onViewDetails: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigate to Emergency Details (Placeholder)')),
              );
            },
          )),
      ],
    );
  }

  Widget _buildRightColumn(EmergencyResponseLoaded state) {
    // Find the first emergency that has a timeline to display, or show an empty/fallback one
    final activeEmergency = state.emergencies.firstWhere(
      (e) => e.timeline.isNotEmpty,
      orElse: () => state.emergencies.isNotEmpty ? state.emergencies.first : state.emergencies.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.emergencies.isNotEmpty && activeEmergency.timeline.isNotEmpty) ...[
          TimelineWidget(
            header: 'Active Timeline (#${activeEmergency.id})',
            nodes: activeEmergency.timeline.map((node) => TimelineNodeData(
              title: node.title,
              subtitle: _formatTime(node.timestamp),
              isCompleted: node.isCompleted,
              isCurrent: node.isCurrent,
            )).toList(),
          ),
          const SizedBox(height: 24.0),
        ],
        
        QuickActionGrid(
          title: 'Quick Actions',
          actions: [
            QuickActionData(
              label: 'Navigate',
              icon: Icons.navigation,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigate to Incident (Placeholder)')),
                );
              },
            ),
            QuickActionData(
              label: 'Notify Team',
              icon: Icons.campaign,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notify Team (Placeholder)')),
                );
              },
            ),
            QuickActionData(
              label: 'Control Room',
              icon: Icons.headset_mic,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact Control Room (Placeholder)')),
                );
              },
            ),
            QuickActionData(
              label: 'Req Backup',
              icon: Icons.local_police,
              isDestructive: true,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request Backup (Placeholder)')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  String _formatTime(DateTime time) {
    String period = time.hour >= 12 ? 'PM' : 'AM';
    int hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    String min = time.minute.toString().padLeft(2, '0');
    return '$hour:$min $period';
  }
}
