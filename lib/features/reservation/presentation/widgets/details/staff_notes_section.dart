import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../reservation/domain/entities/reservation_details_entity.dart';

class StaffNotesSection extends StatelessWidget {
  final ReservationDetailsEntity details;

  const StaffNotesSection({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border(
          top: BorderSide(color: AppColors.outlineVariant.withAlpha(76)),
          right: BorderSide(color: AppColors.outlineVariant.withAlpha(76)),
          bottom: BorderSide(color: AppColors.outlineVariant.withAlpha(76)),
          left: const BorderSide(color: AppColors.primary, width: 4.0),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withAlpha(12),
            blurRadius: 15.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.speaker_notes_rounded,
                color: AppColors.primary,
                size: 20.0,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'INTERNAL STAFF NOTES',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            details.internalStaffNotes.trim().isEmpty 
                ? 'No notes available.' 
                : details.internalStaffNotes,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
              color: AppColors.onSurface,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
