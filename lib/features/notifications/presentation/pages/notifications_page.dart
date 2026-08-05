import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../maintenance/presentation/widgets/shared/maintenance_search_bar.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_type.dart';
import '../bloc/notifications_bloc.dart';
import '../bloc/notifications_event.dart';
import '../bloc/notifications_state.dart';
import '../widgets/notification_summary_cards.dart';
import '../widgets/notification_filter_chips.dart';
import '../widgets/notification_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsBloc>().add(LoadNotificationsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.stitchBackground,
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading || state is NotificationsInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is NotificationsError) {
            return _buildErrorState(context, state.message);
          } else if (state is NotificationsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<NotificationsBloc>().add(RefreshNotificationsRequested());
              },
              color: AppColors.primary,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                slivers: [
                  _buildAppBar(context),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                      child: NotificationSummaryCards(
                        unreadCount: _calculateUnread(state.notifications),
                        todayCount: _calculateToday(state.notifications),
                        criticalCount: _calculateCritical(state.notifications),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MaintenanceSearchBar(
                      searchQuery: state.searchQuery,
                      placeholder: 'Search notifications...',
                      onSearchChanged: (query) {
                        context.read<NotificationsBloc>().add(SearchNotificationsRequested(query));
                      },
                      onClearSearch: () {
                        context.read<NotificationsBloc>().add(const SearchNotificationsRequested(''));
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: NotificationFilterChips(
                      activeFilter: state.activeFilter,
                      onFilterSelected: (filter) {
                        context.read<NotificationsBloc>().add(FilterNotificationsRequested(filter));
                      },
                    ),
                  ),
                  if (state.notifications.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'No notifications found',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.outlineVariant,
                          ),
                        ),
                      ),
                    )
                  else
                    ..._buildGroupedNotifications(context, state.notifications),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 80.0), // Padding for bottom nav
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
      scrolledUnderElevation: 4.0,
      toolbarHeight: 64.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Notifications',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            'Stay updated with maintenance events',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.done_all_rounded, color: AppColors.primary),
          onPressed: () {
            context.read<NotificationsBloc>().add(MarkAllNotificationsReadRequested());
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: AppColors.primary),
          onPressed: () {},
        ),
        const SizedBox(width: 8.0),
        Container(
          margin: const EdgeInsets.only(right: 16.0),
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceContainer,
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: Colors.white,
            size: 20.0,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildGroupedNotifications(BuildContext context, List<NotificationEntity> notifications) {
    final Map<String, List<NotificationEntity>> grouped = {};
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    String formatDate(DateTime d) => '${months[d.month - 1]} ${d.day}';
    String formatDateYear(DateTime d) => '${months[d.month - 1]} ${d.day}, ${d.year}';

    for (var n in notifications) {
      final date = DateTime(n.timestamp.year, n.timestamp.month, n.timestamp.day);
      String groupKey;
      if (date == today) {
        groupKey = 'Today • ${formatDate(date)}';
      } else if (date == yesterday) {
        groupKey = 'Yesterday • ${formatDate(date)}';
      } else {
        groupKey = formatDateYear(date);
      }
      
      grouped.putIfAbsent(groupKey, () => []).add(n);
    }

    final slivers = <Widget>[];
    for (final entry in grouped.entries) {
      slivers.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 16.0, 24.0, 8.0),
            child: Text(
              entry.key,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.outline,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      );
      
      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final n = entry.value[index];
              return NotificationCard(
                notification: n,
                onTap: () {
                  if (!n.isRead) {
                    context.read<NotificationsBloc>().add(MarkNotificationReadRequested(n.id));
                  }
                  // Handle navigation based on type later
                },
              );
            },
            childCount: entry.value.length,
          ),
        ),
      );
    }
    
    return slivers;
  }

  int _calculateUnread(List<NotificationEntity> list) => list.where((n) => !n.isRead).length;
  
  int _calculateToday(List<NotificationEntity> list) {
    final today = DateTime.now();
    return list.where((n) => 
      n.timestamp.year == today.year && 
      n.timestamp.month == today.month && 
      n.timestamp.day == today.day
    ).length;
  }
  
  int _calculateCritical(List<NotificationEntity> list) => list.where((n) => n.type == NotificationType.critical).length;

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 60.0),
          const SizedBox(height: 16.0),
          const Text('Failed to load notifications',
              style: TextStyle(fontFamily: 'Inter', fontSize: 18.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          Text(message, style: const TextStyle(fontFamily: 'Inter', color: AppColors.outline)),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () => context.read<NotificationsBloc>().add(LoadNotificationsRequested()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
