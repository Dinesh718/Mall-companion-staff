// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';

class CampaignScheduleSection extends StatelessWidget {
  final CreateOfferFormEntity form;

  const CampaignScheduleSection({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final startError = form.validationErrors['startDate'];
    final endError = form.validationErrors['endDate'];

    // Format Date helper
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    String formatDate(DateTime dt) {
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    }

    final startStr = form.startDate != null ? formatDate(form.startDate!) : '--';
    final endStr = form.endDate != null ? formatDate(form.endDate!) : '--';
    final durationDays = form.startDate != null && form.endDate != null
        ? form.endDate!.difference(form.startDate!).inDays
        : 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Title Header
          Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.event_outlined,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                'Campaign Schedule',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          // Date pickers Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Start Date Picker trigger
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Start Date & Time',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    InkWell(
                      onTap: () => _pickDateTime(context, isStart: true),
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12.0),
                          border: startError != null
                              ? Border.all(color: AppColors.error, width: 1.0)
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                form.startDate != null
                                    ? '${form.startDate!.day}/${form.startDate!.month}/${form.startDate!.year} ${form.startDate!.hour.toString().padLeft(2, '0')}:${form.startDate!.minute.toString().padLeft(2, '0')}'
                                    : 'Select start date',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 13.0,
                                  color: form.startDate != null ? AppColors.onSurface : Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(Icons.calendar_today_rounded, size: 16.0, color: AppColors.onSurfaceVariant),
                          ],
                        ),
                      ),
                    ),
                    if (startError != null) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        startError,
                        style: const TextStyle(color: AppColors.error, fontSize: 11.0, fontFamily: 'Inter'),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16.0),

              // End Date Picker trigger
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'End Date & Time',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    InkWell(
                      onTap: () => _pickDateTime(context, isStart: false),
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12.0),
                          border: endError != null
                              ? Border.all(color: AppColors.error, width: 1.0)
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                form.endDate != null
                                    ? '${form.endDate!.day}/${form.endDate!.month}/${form.endDate!.year} ${form.endDate!.hour.toString().padLeft(2, '0')}:${form.endDate!.minute.toString().padLeft(2, '0')}'
                                    : 'Select end date',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 13.0,
                                  color: form.endDate != null ? AppColors.onSurface : Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(Icons.calendar_today_rounded, size: 16.0, color: AppColors.onSurfaceVariant),
                          ],
                        ),
                      ),
                    ),
                    if (endError != null) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        endError,
                        style: const TextStyle(color: AppColors.error, fontSize: 11.0, fontFamily: 'Inter'),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          // Duration details summary box
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FC),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: AppColors.outlineVariant.withOpacity(0.2),
              ),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.8,
              children: [
                _buildSummaryField('Duration', '$durationDays Days'),
                _buildSummaryField('Start Date', startStr),
                _buildSummaryField('End Date', endStr),
                _buildSummaryField('Time Zone', 'GMT +4'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 3.0),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
      ],
    );
  }

  Future<void> _pickDateTime(BuildContext context, {required bool isStart}) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = isStart
        ? (form.startDate ?? now)
        : (form.endDate ?? now.add(const Duration(days: 7)));

    final bloc = context.read<CreateOfferBloc>();
    final theme = Theme.of(context);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && context.mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
        builder: (context, child) {
          return Theme(
            data: theme.copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.primary,
                onSurface: AppColors.onSurface,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (isStart) {
          bloc.add(StartDateChanged(finalDateTime));
        } else {
          bloc.add(EndDateChanged(finalDateTime));
        }
      }
    }
  }
}
