// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_loading_indicator.dart';
import '../../data/repositories/mock_queue_repository.dart';
import '../../domain/entities/queue_summary_entity.dart';
import '../../domain/entities/create_queue_entry_entity.dart';
import '../../domain/usecases/create_queue_entry_usecase.dart';
import '../../domain/usecases/validate_queue_entry_usecase.dart';
import '../bloc/add_walk_in_bloc.dart';
import '../bloc/add_walk_in_event.dart';
import '../bloc/add_walk_in_state.dart';
import '../widgets/walk_in_header.dart';
import '../widgets/customer_info_form.dart';
import '../widgets/visit_info_form.dart';
import '../widgets/queue_preview_card.dart';

class AddWalkInCustomerPage extends StatelessWidget {
  final QueueSummaryEntity summary;

  const AddWalkInCustomerPage({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockQueueRepository();

    return BlocProvider(
      create: (context) => AddWalkInBloc(
        createQueueEntryUseCase: CreateQueueEntryUseCase(mockRepo),
        validateQueueEntryUseCase: ValidateQueueEntryUseCase(),
      )..add(const InitializeAddWalkIn()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF),
        appBar: AppBar(
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
                'Add Walk-in Customer',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                "Register a new customer into today's queue",
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
            const SizedBox(width: 8.0),
          ],
        ),
        body: BlocConsumer<AddWalkInBloc, AddWalkInState>(
          listener: (context, state) {
            if (state is AddWalkInSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Customer ${state.queueItem.customerName} successfully added to queue!'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: const Color(0xFF10B981),
                ),
              );
              Navigator.pop(context, true); // Return true to refresh the dashboard list
            } else if (state is AddWalkInFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to add customer: ${state.errorMessage}'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AddWalkInInitial) {
              return const Center(child: AppLoadingIndicator());
            }

            final form = _getFormState(state);

            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 24.0,
                      bottom: 120.0, // Space for sticky bottom action bar
                    ),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 800.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 720) {
                              // Tablet/Desktop two-column layout
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        _buildCustomerInfoSection(context, form),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 24.0),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        WalkInHeader(waitingCount: summary.waitingCount),
                                        const SizedBox(height: 24.0),
                                        _buildVisitSection(context, form),
                                        const SizedBox(height: 24.0),
                                        QueuePreviewCard(summary: summary),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              // Mobile single-column layout
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  WalkInHeader(waitingCount: summary.waitingCount),
                                  const SizedBox(height: 24.0),
                                  _buildCustomerInfoSection(context, form),
                                  const SizedBox(height: 24.0),
                                  _buildVisitSection(context, form),
                                  const SizedBox(height: 24.0),
                                  QueuePreviewCard(summary: summary),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // Sticky Bottom Bar
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildStickyBottomBar(context, state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCustomerInfoSection(BuildContext context, dynamic form) {
    final bloc = context.read<AddWalkInBloc>();
    return CustomerInfoForm(
      name: form.customerName,
      phone: form.phoneNumber,
      email: form.email,
      partySize: form.partySize,
      contactPreference: form.contactPreference,
      specialRequests: form.specialRequests,
      validationErrors: form.validationErrors,
      onNameChanged: (val) => bloc.add(CustomerNameChanged(val)),
      onPhoneChanged: (val) => bloc.add(PhoneChanged(val)),
      onEmailChanged: (val) => bloc.add(EmailChanged(val)),
      onPartySizeChanged: (val) => bloc.add(PartySizeChanged(val)),
      onContactPreferenceChanged: (val) => bloc.add(PreferredContactChanged(val)),
      onSpecialRequestToggled: (val) => bloc.add(SpecialRequestToggled(val)),
    );
  }

  Widget _buildVisitSection(BuildContext context, dynamic form) {
    final bloc = context.read<AddWalkInBloc>();
    return VisitInfoForm(
      serviceType: form.serviceType,
      priority: form.priority,
      estimatedDurationMinutes: form.estimatedDurationMinutes,
      onServiceTypeChanged: (val) => bloc.add(ServiceTypeChanged(val)),
      onPriorityChanged: (val) => bloc.add(PriorityChanged(val)),
      onDurationChanged: (val) => bloc.add(DurationChanged(val)),
    );
  }


  Widget _buildStickyBottomBar(BuildContext context, AddWalkInState state) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final bloc = context.read<AddWalkInBloc>();
    final isSubmitting = state is AddWalkInSubmitting;

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
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800.0),
          child: Row(
            children: [
              // Cancel Button
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 52.0,
                  child: OutlinedButton(
                    onPressed: isSubmitting ? null : () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary, width: 2.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),

              // Add to Queue Button
              Expanded(
                flex: 2,
                child: Container(
                  height: 52.0,
                  decoration: BoxDecoration(
                    gradient: isSubmitting
                        ? null
                        : const LinearGradient(
                            colors: AppColors.primaryGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    color: isSubmitting ? Colors.grey : null,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: isSubmitting
                        ? null
                        : [
                            BoxShadow(
                              color: AppColors.primaryGradientStart.withOpacity(0.25),
                              blurRadius: 10.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: isSubmitting ? null : () => bloc.add(const SubmitWalkIn()),
                      borderRadius: BorderRadius.circular(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isSubmitting) ...[
                            const SizedBox(
                              width: 18.0,
                              height: 18.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                          ] else ...[
                            const Icon(Icons.person_add_alt_1_rounded, color: Colors.white, size: 18.0),
                            const SizedBox(width: 8.0),
                          ],
                          Text(
                            isSubmitting ? 'Adding...' : 'Add to Queue',
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
            ],
          ),
        ),
      ),
    );
  }

  dynamic _getFormState(AddWalkInState state) {
    if (state is AddWalkInEditing) return state.formState;
    if (state is AddWalkInSubmitting) return state.formState;
    if (state is AddWalkInValidationError) return state.formState;
    if (state is AddWalkInFailure && state.formState != null) return state.formState!;
    return const CreateQueueEntryEntity();
  }
}
