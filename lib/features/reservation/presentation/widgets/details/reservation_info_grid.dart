import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../reservation/domain/entities/reservation_details_entity.dart';

class ReservationInfoGrid extends StatelessWidget {
  final ReservationDetailsEntity details;

  const ReservationInfoGrid({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.outlineVariant.withAlpha(76)),
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
                Icons.info_outline_rounded,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Reservation Details',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.5,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            children: [
              _buildInfoItem('Table', details.table),
              _buildInfoItem('Area', details.area),
              _buildInfoItem('Type', details.type),
              _buildInfoItem('Preference', details.preference),
              _buildInfoItem('Occasion', details.occasion, isPrimary: true),
              _buildInfoItem('Booking Source', details.bookingSource),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {bool isPrimary = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.0,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: isPrimary ? AppColors.primary : AppColors.onSurface,
          ),
        ),
      ],
    );
  }
}
