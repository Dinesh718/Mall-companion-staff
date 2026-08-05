import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../bloc/form/reservation_form_bloc.dart';
import '../../bloc/form/reservation_form_event.dart';
import '../../bloc/form/reservation_form_state.dart';

class StepChooseSchedule extends StatelessWidget {
  const StepChooseSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationFormBloc, ReservationFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                const Text(
                  'CHOOSE SCHEDULE',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            _buildTriggerCard(
              icon: Icons.calendar_month_rounded,
              label: 'Date',
              value: state.date != null ? _formatDate(state.date!) : 'Select Date',
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: state.date ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null && context.mounted) {
                  context.read<ReservationFormBloc>().add(
                    UpdateSchedule(
                      date: date,
                      time: state.time,
                      durationMinutes: state.durationMinutes,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 12.0),
            _buildTriggerCard(
              icon: Icons.schedule_rounded,
              label: 'Time',
              value: state.time ?? 'Select Time',
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null && context.mounted) {
                  context.read<ReservationFormBloc>().add(
                    UpdateSchedule(
                      date: state.date,
                      time: time.format(context),
                      durationMinutes: state.durationMinutes,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'ESTIMATED DURATION',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.0,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildDurationChip(context, 60, state.durationMinutes),
                  const SizedBox(width: 8.0),
                  _buildDurationChip(context, 90, state.durationMinutes),
                  const SizedBox(width: 8.0),
                  _buildDurationChip(context, 120, state.durationMinutes),
                  const SizedBox(width: 8.0),
                  _buildDurationChip(context, 180, state.durationMinutes),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTriggerCard({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          children: [
            Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.outlineVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.outline),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationChip(BuildContext context, int minutes, int selectedMinutes) {
    final isSelected = minutes == selectedMinutes;
    return GestureDetector(
      onTap: () {
        final state = context.read<ReservationFormBloc>().state;
        context.read<ReservationFormBloc>().add(
          UpdateSchedule(
            date: state.date,
            time: state.time,
            durationMinutes: minutes,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          border: isSelected ? null : Border.all(color: AppColors.outlineVariant),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(51), // violet-glow
                    blurRadius: 14.0,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          '$minutes Min',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return "${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}, ${date.year}";
  }
}
