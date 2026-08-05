import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../bloc/ticket_details/ticket_details_bloc.dart';
import '../../bloc/ticket_details/ticket_details_event.dart';
import '../../bloc/ticket_details/ticket_details_state.dart';

class TicketResolutionBottomSheet extends StatefulWidget {
  final String ticketId;

  const TicketResolutionBottomSheet({super.key, required this.ticketId});

  @override
  State<TicketResolutionBottomSheet> createState() => _TicketResolutionBottomSheetState();
}

class _TicketResolutionBottomSheetState extends State<TicketResolutionBottomSheet> {
  final TextEditingController _workPerformedController = TextEditingController();
  final TextEditingController _internalNotesController = TextEditingController();
  String _selectedResolutionType = '';

  final List<String> _resolutionTypes = [
    'Permanent Fix',
    'Temporary Workaround',
    'No Issue Found',
    'Part Replacement',
  ];

  @override
  void dispose() {
    _workPerformedController.dispose();
    _internalNotesController.dispose();
    super.dispose();
  }

  void _dispatchUpdate() {
    context.read<TicketDetailsBloc>().add(
      UpdateResolutionForm(
        workPerformed: _workPerformedController.text,
        resolutionType: _selectedResolutionType,
        partsUsed: const [], // Mocking parts
        photos: const [], // Mocking photos
        internalNotes: _internalNotesController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketDetailsBloc, TicketDetailsState>(
      listener: (context, state) {
        if (state is TicketDetailsOperationSuccess) {
          Navigator.of(context).pop();
        } else if (state is TicketResolutionFormState && state.submissionError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.submissionError!, style: const TextStyle(fontFamily: 'Inter')),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        }
      },
      builder: (context, state) {
        bool isSubmitting = false;
        bool isValid = false;

        if (state is TicketResolutionFormState) {
          isSubmitting = state.isSubmitting;
          isValid = state.isValid;
        }

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.9, // Make it tall enough to comfortably show fields
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                      width: 40.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: AppColors.outlineVariant,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Resolve Ticket',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: AppColors.onSurfaceVariant),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.outlineVariant),
                  
                  // Form Content
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(24.0),
                      children: [
                        const Text(
                          'Resolution Type *',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: _resolutionTypes.map((type) {
                            final isSelected = _selectedResolutionType == type;
                            return ChoiceChip(
                              label: Text(
                                type,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              selected: isSelected,
                              selectedColor: AppColors.primary,
                              backgroundColor: AppColors.surfaceContainer,
                              side: BorderSide.none,
                              showCheckmark: false,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedResolutionType = selected ? type : '';
                                });
                                _dispatchUpdate();
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24.0),
                        const Text(
                          'Work Performed *',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextField(
                          controller: _workPerformedController,
                          maxLines: 4,
                          onChanged: (_) => _dispatchUpdate(),
                          decoration: InputDecoration(
                            hintText: 'Describe the work performed to resolve the issue...',
                            hintStyle: const TextStyle(fontFamily: 'Inter', color: AppColors.onSurfaceVariant),
                            filled: true,
                            fillColor: AppColors.surfaceContainer,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        const Text(
                          'Internal Notes (Optional)',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextField(
                          controller: _internalNotesController,
                          maxLines: 2,
                          onChanged: (_) => _dispatchUpdate(),
                          decoration: InputDecoration(
                            hintText: 'Any internal notes for other staff...',
                            hintStyle: const TextStyle(fontFamily: 'Inter', color: AppColors.onSurfaceVariant),
                            filled: true,
                            fillColor: AppColors.surfaceContainer,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Footer / Submit
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: AppColors.outlineVariant)),
                    ),
                    child: SafeArea(
                      child: FilledButton(
                        onPressed: (!isValid || isSubmitting)
                            ? null
                            : () {
                                context.read<TicketDetailsBloc>().add(SubmitResolution(widget.ticketId));
                              },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          disabledBackgroundColor: AppColors.outlineVariant,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: isSubmitting
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                              )
                            : const Text(
                                'Submit Resolution',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
