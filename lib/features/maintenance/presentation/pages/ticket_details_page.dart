import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../data/repositories/mock_maintenance_repository.dart';
import '../../domain/usecases/get_ticket_details_usecase.dart';
import '../../domain/usecases/update_ticket_status_usecase.dart';
import '../../domain/usecases/accept_ticket_usecase.dart';
import '../../domain/usecases/start_work_usecase.dart';
import '../../domain/usecases/pause_work_usecase.dart';
import '../../domain/usecases/resume_work_usecase.dart';
import '../../domain/usecases/escalate_ticket_usecase.dart';
import '../../domain/usecases/resolve_ticket_usecase.dart';
import '../../domain/usecases/close_ticket_usecase.dart';
import '../../domain/entities/ticket_details_entity.dart';
import '../bloc/ticket_details/ticket_details_bloc.dart';
import '../bloc/ticket_details/ticket_details_event.dart';
import '../bloc/ticket_details/ticket_details_state.dart';

import '../widgets/ticket_details/ticket_hero_section.dart';
import '../widgets/ticket_details/ticket_issue_details_section.dart';
import '../widgets/ticket_details/ticket_location_section.dart';
import '../widgets/ticket_details/ticket_attachments_gallery.dart';
import '../widgets/ticket_details/ticket_sla_section.dart';
import '../widgets/ticket_details/ticket_timeline_section.dart';
import '../widgets/ticket_details/ticket_action_bar.dart';

class TicketDetailsPage extends StatelessWidget {
  final String ticketId;

  const TicketDetailsPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    final repository = MockMaintenanceRepository();
    
    return BlocProvider(
      create: (context) => TicketDetailsBloc(
        getTicketDetailsUseCase: GetTicketDetailsUseCase(repository: repository),
        updateTicketStatusUseCase: UpdateTicketStatusUseCase(repository: repository),
        acceptTicketUseCase: AcceptTicketUseCase(repository: repository),
        startWorkUseCase: StartWorkUseCase(repository: repository),
        pauseWorkUseCase: PauseWorkUseCase(repository: repository),
        resumeWorkUseCase: ResumeWorkUseCase(repository: repository),
        escalateTicketUseCase: EscalateTicketUseCase(repository: repository),
        resolveTicketUseCase: ResolveTicketUseCase(repository: repository),
        closeTicketUseCase: CloseTicketUseCase(repository: repository),
      )..add(LoadTicketDetails(ticketId)),
      child: const TicketDetailsView(),
    );
  }
}

class TicketDetailsView extends StatelessWidget {
  const TicketDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketDetailsBloc, TicketDetailsState>(
      listener: (context, state) {
        if (state is TicketDetailsOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, style: const TextStyle(fontFamily: 'Inter')),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        } else if (state is TicketDetailsOperationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage, style: const TextStyle(fontFamily: 'Inter')),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(
            'Ticket Details',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold, // Matching HTML font weight for headers is usually bolder, let's use bold
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.onSurface,
          elevation: 0,
          scrolledUnderElevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: AppColors.onSurfaceVariant),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryContainer, width: 2.0),
                  image: const DecorationImage(
                    image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuB_FcQUCQLDR8zi4G51TaiiE8cW6y1nLQ9Y5Nz8SDV6BRVoWXRl2cNREJmqkNQ2_DZVKAGKxufw_XuLSGzZ8c-iXg5K6I-qeUZ5ymV3J_5eRNRSzmF6XXYhuv3zD8TOG-7NbE11Rve75zc-qKCOjGYQsVuurhHDtqXUf_Sntbw4DB09CBhXehMMOMtSU9YuNSYHgkYyH7AwVkK70Et06Ccar0H43iebDdPu1ZFQOdNlMqmOgrym-wo'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<TicketDetailsBloc, TicketDetailsState>(
          builder: (context, state) {
            if (state is TicketDetailsLoading || state is TicketDetailsInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state is TicketDetailsError) {
              return AppErrorWidget(
                message: state.errorMessage,
                onRetry: () {
                  context.read<TicketDetailsBloc>().add(const LoadTicketDetails('#MT-2045'));
                },
              );
            } 
            
            // Handled states: Loaded, OperationLoading, OperationSuccess, OperationFailure, ResolutionFormState
            TicketDetailsEntity? ticket;
            if (state is TicketDetailsLoaded) {
              ticket = state.details;
            } else if (state is TicketDetailsOperationLoading) {
              ticket = state.details;
            } else if (state is TicketDetailsOperationSuccess) {
              ticket = state.details;
            } else if (state is TicketDetailsOperationFailure) {
              ticket = state.details;
            } else if (state is TicketResolutionFormState) {
              ticket = state.details;
            }

            if (ticket == null) {
              return const Center(child: Text('State Error: No ticket details available'));
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 24.0,
                    bottom: 120.0,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TicketHeroSection(ticket: ticket),
                          const SizedBox(height: 24.0),
                          TicketSlaSection(sla: ticket.sla),
                          const SizedBox(height: 24.0),
                          TicketIssueDetailsSection(ticket: ticket),
                          const SizedBox(height: 24.0),
                          TicketLocationSection(ticket: ticket),
                          const SizedBox(height: 24.0),
                          TicketAttachmentsGallery(attachments: ticket.attachments),
                          const SizedBox(height: 24.0),
                          TicketTimelineSection(timeline: ticket.timeline),
                        ],
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: TicketActionBar(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
