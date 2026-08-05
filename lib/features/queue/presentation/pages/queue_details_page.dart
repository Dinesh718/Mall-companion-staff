// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_loading_indicator.dart';
import '../../../../core/shared/presentation/widgets/app_error_state.dart';
import '../../data/repositories/mock_queue_repository.dart';
import '../../domain/entities/queue_entity.dart';
import '../../domain/entities/queue_status.dart';
import '../../domain/usecases/get_queue_details_usecase.dart';
import '../../domain/usecases/load_queue_dashboard_usecase.dart';
import '../../domain/usecases/call_customer_usecase.dart';
import '../../domain/usecases/mark_arrived_usecase.dart';
import '../../domain/usecases/start_service_usecase.dart';
import '../../domain/usecases/complete_service_usecase.dart';
import '../../domain/usecases/skip_customer_usecase.dart';
import '../../domain/usecases/cancel_queue_usecase.dart';
import '../bloc/queue_bloc.dart';
import '../bloc/queue_event.dart';
import '../bloc/queue_state.dart';
import '../widgets/queue_details_hero_card.dart';
import '../widgets/special_notes_card.dart';
import '../widgets/customer_info_card.dart';
import '../widgets/queue_info_card.dart';
import '../widgets/manage_session_section.dart';
import '../widgets/queue_timeline_widget.dart';

import '../../domain/repositories/queue_repository.dart';

class QueueDetailsPage extends StatelessWidget {
  final String queueId;
  final QueueRepository? repository;

  const QueueDetailsPage({
    super.key,
    required this.queueId,
    this.repository,
  });

  @override
  Widget build(BuildContext context) {
    final mockRepo = repository ?? MockQueueRepository();

    return BlocProvider(
      create: (context) => QueueBloc(
        loadQueueDashboardUseCase: LoadQueueDashboardUseCase(mockRepo),
        getQueueDetailsUseCase: GetQueueDetailsUseCase(mockRepo),
        callCustomerUseCase: CallCustomerUseCase(mockRepo),
        markArrivedUseCase: MarkArrivedUseCase(mockRepo),
        startServiceUseCase: StartServiceUseCase(mockRepo),
        completeServiceUseCase: CompleteServiceUseCase(mockRepo),
        skipCustomerUseCase: SkipCustomerUseCase(mockRepo),
        cancelQueueUseCase: CancelQueueUseCase(mockRepo),
      )..add(LoadQueueDetails(queueId)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(72.0),
          child: BlocBuilder<QueueBloc, QueueState>(
            builder: (context, state) {
              return AppBar(
                leadingWidth: 56.0,
                automaticallyImplyLeading: false,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.primary,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                title: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Queue Details',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      'Real-time customer status and timeline',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                elevation: 0.5,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.onSurfaceVariant,
                    ),
                    onPressed: () {
                      context.read<QueueBloc>().add(RefreshQueueDetails(queueId));
                    },
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.onSurfaceVariant,
                        ),
                        onPressed: () {},
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.outlineVariant,
                          width: 1.5,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDyIrvZ59L3Bj0ko3yg-m5fSuHBP0aqGy0ZicdNegWbYd6b9BFFkfQy_eJeoourQaAn7lp1-EBV0D7h0Njz8GAKDKJikuVNWo6a-HmO04yNjvtRibQz5UYNAA3-WYGqhnuXaA5yBb1pkExh97EReU3_jdAmsIofIBt8JDtPwRXqP5lO_QfwWSPPfBcpXHLc2jEw4lY1y0SIB6fnEq1dSFP1fJf3ST8NQ4LT85c1PEhD-RxKk2Pm6wrZoZ9XYYHesWkfZTDrpwmp7A',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.account_circle,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        body: BlocBuilder<QueueBloc, QueueState>(
          builder: (context, state) {
            if (state is QueueDetailsLoading || state is QueueInitial) {
              return const Center(
                child: AppLoadingIndicator(),
              );
            } else if (state is QueueDetailsError) {
              return Center(
                child: AppErrorState(
                  message: state.errorMessage,
                  onRetry: () {
                    context.read<QueueBloc>().add(LoadQueueDetails(queueId));
                  },
                ),
              );
            } else if (state is QueueDetailsLoaded) {
              final queueItem = state.queueItem;

              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      context.read<QueueBloc>().add(RefreshQueueDetails(queueId));
                    },
                    color: AppColors.primary,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 24.0,
                          bottom: 120.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            QueueDetailsHeroCard(queueItem: queueItem),
                            const SizedBox(height: 24.0),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth > 720) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            SpecialNotesCard(notes: queueItem.specialNotes),
                                            if (queueItem.specialNotes != null)
                                              const SizedBox(height: 24.0),
                                            if (constraints.maxWidth > 960) ...[
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: CustomerInfoCard(queueItem: queueItem),
                                                  ),
                                                  const SizedBox(width: 24.0),
                                                  Expanded(
                                                    child: QueueInfoCard(queueItem: queueItem),
                                                  ),
                                                ],
                                              ),
                                            ] else ...[
                                              CustomerInfoCard(queueItem: queueItem),
                                              const SizedBox(height: 24.0),
                                              QueueInfoCard(queueItem: queueItem),
                                            ],
                                            const SizedBox(height: 24.0),
                                            ManageSessionSection(
                                              status: queueItem.status,
                                              activeAction: state.activeAction,
                                              onCall: () => _triggerAction(
                                                context,
                                                CallCustomerRequested(queueId),
                                                'Calling customer...',
                                              ),
                                              onArrived: () => _triggerAction(
                                                context,
                                                MarkArrivedRequested(queueId),
                                                'Customer marked as arrived',
                                              ),
                                              onStart: () => _triggerAction(
                                                context,
                                                StartServiceRequested(queueId),
                                                'Service started',
                                              ),
                                              onComplete: () => _confirmAndTriggerAction(
                                                context,
                                                CompleteServiceRequested(queueId),
                                                'Complete Service',
                                                'Are you sure you want to mark this service as completed?',
                                              ),
                                              onSkip: () => _triggerAction(
                                                context,
                                                SkipCustomerRequested(queueId),
                                                'Customer skipped',
                                              ),
                                              onCancel: () => _confirmAndTriggerAction(
                                                context,
                                                CancelQueueRequested(queueId),
                                                'Cancel Queue',
                                                'Are you sure you want to cancel this customer queue entry?',
                                                isDestructive: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 24.0),
                                      Expanded(
                                        flex: 1,
                                        child: _buildTimelineContainer(queueItem),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      SpecialNotesCard(notes: queueItem.specialNotes),
                                      if (queueItem.specialNotes != null)
                                        const SizedBox(height: 24.0),
                                      CustomerInfoCard(queueItem: queueItem),
                                      const SizedBox(height: 24.0),
                                      QueueInfoCard(queueItem: queueItem),
                                      const SizedBox(height: 24.0),
                                      ManageSessionSection(
                                        status: queueItem.status,
                                        activeAction: state.activeAction,
                                        onCall: () => _triggerAction(
                                          context,
                                          CallCustomerRequested(queueId),
                                          'Calling customer...',
                                        ),
                                        onArrived: () => _triggerAction(
                                          context,
                                          MarkArrivedRequested(queueId),
                                          'Customer marked as arrived',
                                        ),
                                        onStart: () => _triggerAction(
                                          context,
                                          StartServiceRequested(queueId),
                                          'Service started',
                                        ),
                                        onComplete: () => _confirmAndTriggerAction(
                                          context,
                                          CompleteServiceRequested(queueId),
                                          'Complete Service',
                                          'Are you sure you want to mark this service as completed?',
                                        ),
                                        onSkip: () => _triggerAction(
                                          context,
                                          SkipCustomerRequested(queueId),
                                          'Customer skipped',
                                        ),
                                        onCancel: () => _confirmAndTriggerAction(
                                          context,
                                          CancelQueueRequested(queueId),
                                          'Cancel Queue',
                                          'Are you sure you want to cancel this customer queue entry?',
                                          isDestructive: true,
                                        ),
                                      ),
                                      const SizedBox(height: 24.0),
                                      _buildTimelineContainer(queueItem),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: _buildStickyBottomBar(context, queueItem, state.activeAction),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildTimelineContainer(QueueEntity item) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Queue Timeline',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 24.0),
          QueueTimelineWidget(steps: item.timelineSteps ?? []),
        ],
      ),
    );
  }

  Widget _buildStickyBottomBar(
    BuildContext context,
    QueueEntity queueItem,
    String? activeAction,
  ) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final isCallLoading = activeAction == 'call';
    final isAnyLoading = activeAction != null;
    final canCall = queueItem.status == QueueStatus.waiting || queueItem.status == QueueStatus.called;

    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 16.0,
        bottom: 16.0 + bottomPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant.withOpacity(0.3),
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20.0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 52.0,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded, size: 18.0),
                label: const Text(
                  'Back to Queue',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.onSurfaceVariant,
                  side: BorderSide(
                    color: AppColors.outlineVariant.withOpacity(0.5),
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            flex: 1,
            child: Opacity(
              opacity: (!canCall || isAnyLoading) ? 0.6 : 1.0,
              child: Container(
                height: 52.0,
                decoration: BoxDecoration(
                  gradient: (canCall && !isAnyLoading)
                      ? const LinearGradient(
                          colors: AppColors.primaryGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: (canCall && !isAnyLoading) ? null : Colors.grey,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: (canCall && !isAnyLoading)
                      ? [
                          BoxShadow(
                            color: AppColors.primaryGradientStart.withOpacity(0.2),
                            blurRadius: 10.0,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (canCall && !isAnyLoading)
                        ? () => _triggerAction(
                              context,
                              CallCustomerRequested(queueItem.id),
                              'Calling customer...',
                            )
                        : null,
                    borderRadius: BorderRadius.circular(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isCallLoading) ...[
                          const SizedBox(
                            width: 18.0,
                            height: 18.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                        ] else ...[
                          const Icon(Icons.call_rounded, color: Colors.white, size: 18.0),
                          const SizedBox(width: 8.0),
                        ],
                        Text(
                          isCallLoading ? 'Calling...' : 'Call Customer',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _triggerAction(BuildContext context, QueueEvent event, String snackbarMsg) {
    context.read<QueueBloc>().add(event);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackbarMsg),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _confirmAndTriggerAction(
    BuildContext context,
    QueueEvent event,
    String title,
    String content, {
    bool isDestructive = false,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(
              fontFamily: 'Inter',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<QueueBloc>().add(event);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDestructive ? AppColors.error : AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                isDestructive ? 'Yes, Cancel' : 'Confirm',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
