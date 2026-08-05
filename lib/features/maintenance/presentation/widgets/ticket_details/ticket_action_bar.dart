import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import '../../../../../core/themes/app_colors.dart';
import '../../../../maintenance/domain/entities/ticket_details_entity.dart';
import '../../bloc/ticket_details/ticket_details_bloc.dart';
import '../../bloc/ticket_details/ticket_details_event.dart';
import '../../bloc/ticket_details/ticket_details_state.dart';
import '../resolution/ticket_resolution_bottom_sheet.dart';

class TicketActionBar extends StatelessWidget {
  const TicketActionBar({super.key});

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onConfirm,
    {bool isDestructive = false}
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
        content: Text(
          content,
          style: const TextStyle(fontFamily: 'Inter'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(fontFamily: 'Inter', color: AppColors.onSurfaceVariant)),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onConfirm();
            },
            style: FilledButton.styleFrom(
              backgroundColor: isDestructive ? AppColors.error : AppColors.primary,
            ),
            child: const Text('Confirm', style: TextStyle(fontFamily: 'Inter')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketDetailsBloc, TicketDetailsState>(
      builder: (blocContext, state) {
        TicketDetailsEntity? details;
        if (state is TicketDetailsLoaded) {
          details = state.details;
        } else if (state is TicketDetailsOperationSuccess) {
          details = state.details;
        } else if (state is TicketDetailsOperationFailure) {
          details = state.details;
        } else if (state is TicketDetailsOperationLoading) {
          details = state.details;
        } else if (state is TicketResolutionFormState) {
          details = state.details;
        }

        if (details == null) return const SizedBox.shrink();

        final status = details.status;
        final isLoading = state is TicketDetailsOperationLoading || state is TicketDetailsLoading;

        if (status == 'Closed' || status == 'Escalated') {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.92,
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 24.0,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      if (status == 'In Progress' || status == 'Paused') ...[
                        Expanded(
                          flex: 1,
                          child: _buildSecondaryButton(
                            context,
                            details.id,
                            isLoading,
                            status == 'In Progress' ? 'Pause' : 'Resume',
                            status == 'In Progress' ? Icons.pause_circle_outline_rounded : Icons.play_circle_outline_rounded,
                            status == 'In Progress' ? TicketOperation.pauseWork : TicketOperation.resumeWork,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                      ],
                      Expanded(
                        flex: 2,
                        child: _buildPrimaryButton(context, details.id, status, isLoading),
                      ),
                      if (status == 'In Progress' || status == 'Paused') ...[
                        const SizedBox(width: 8.0),
                        _buildMoreOptionsButton(context, details.id, isLoading),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPrimaryButton(BuildContext context, String ticketId, String status, bool isLoading) {
    String label = '';
    IconData icon = Icons.check;
    VoidCallback? onTap;

    switch (status) {
      case 'Assigned':
        label = 'Accept Ticket';
        icon = Icons.assignment_turned_in_rounded;
        onTap = () {
          _showConfirmationDialog(
            context,
            'Accept Ticket',
            'Are you sure you want to accept this ticket?',
            () => context.read<TicketDetailsBloc>().add(PerformTicketOperation(ticketId: ticketId, operation: TicketOperation.accept)),
          );
        };
        break;
      case 'Accepted':
        label = 'Start Work';
        icon = Icons.play_arrow_rounded;
        onTap = () {
          context.read<TicketDetailsBloc>().add(PerformTicketOperation(ticketId: ticketId, operation: TicketOperation.startWork));
        };
        break;
      case 'In Progress':
      case 'Paused':
        label = 'Resolve Ticket';
        icon = Icons.check_circle_outline_rounded;
        onTap = () {
          final bloc = context.read<TicketDetailsBloc>();
          // Dispatch open workflow event to reset form state
          bloc.add(const OpenResolutionWorkflow());
          
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Needed for full height flexibility
            backgroundColor: Colors.transparent,
            builder: (ctx) {
              return BlocProvider.value(
                value: bloc,
                child: TicketResolutionBottomSheet(ticketId: ticketId),
              );
            },
          );
        };
        break;
      case 'Resolved':
        label = 'Close Ticket';
        icon = Icons.done_all_rounded;
        onTap = () {
          _showConfirmationDialog(
            context,
            'Close Ticket',
            'Are you sure you want to close this ticket?',
            () => context.read<TicketDetailsBloc>().add(PerformTicketOperation(ticketId: ticketId, operation: TicketOperation.close)),
          );
        };
        break;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: isLoading
            ? null
            : const LinearGradient(
                colors: AppColors.ticketHeroGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        color: isLoading ? AppColors.outlineVariant : null,
        borderRadius: BorderRadius.circular(999),
        boxShadow: isLoading
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          disabledForegroundColor: Colors.white,
        ),
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0),
              )
            : Icon(icon),
        label: Text(
          isLoading ? 'Processing...' : label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(
      BuildContext context, String ticketId, bool isLoading, String label, IconData icon, TicketOperation operation) {
    return ElevatedButton.icon(
      onPressed: isLoading
          ? null
          : () {
              context.read<TicketDetailsBloc>().add(PerformTicketOperation(ticketId: ticketId, operation: operation));
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: const BorderSide(color: AppColors.outlineVariant),
        ),
      ),
      icon: Icon(icon),
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMoreOptionsButton(BuildContext context, String ticketId, bool isLoading) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: PopupMenuButton<TicketOperation>(
        enabled: !isLoading,
        icon: const Icon(Icons.more_vert_rounded, color: AppColors.onSurfaceVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        onSelected: (operation) {
          if (operation == TicketOperation.escalate) {
            _showConfirmationDialog(
              context,
              'Escalate Ticket',
              'Are you sure you want to escalate this ticket to a supervisor?',
              () => context.read<TicketDetailsBloc>().add(
                    PerformTicketOperation(ticketId: ticketId, operation: operation, optionalNotes: 'Escalated by Staff'),
                  ),
              isDestructive: true,
            );
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: TicketOperation.escalate,
            child: Row(
              children: [
                Icon(Icons.report_problem_rounded, color: AppColors.error, size: 20),
                SizedBox(width: 8),
                Text('Escalate', style: TextStyle(color: AppColors.error, fontFamily: 'Inter')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
