import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../maintenance/domain/entities/ticket_details_entity.dart';

class TicketLocationSection extends StatelessWidget {
  final TicketDetailsEntity ticket;

  const TicketLocationSection({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0, bottom: 16.0),
            child: const Text(
              'Location',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildLocationItem(Icons.apartment_rounded, 'Mall', 'Westfield Plaza'),
                      const SizedBox(height: 16.0),
                      _buildLocationItem(Icons.location_on_rounded, 'Zone', 'Food Court'),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    children: [
                      _buildLocationItem(Icons.layers_rounded, 'Floor', 'Level 2'),
                      const SizedBox(height: 16.0),
                      _buildLocationItem(Icons.storefront_rounded, 'Nearby', 'Starbucks'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          // Map Placeholder Image Area
          SizedBox(
            height: 160.0,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColorFiltered(
                  colorFilter: const ColorFilter.matrix([
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0,      0,      0,      0.4, 0,
                  ]),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuABTNryWJz7SKpFaJaZpqZ8Qfhz5iktuGZMAlH8A9M3pRrZF-inu4PY_6lBsieDyeF86Bi_6QyOkZ6WPbNAoRlsBSTuXsHpQCp6TWG-a9l2Ckt05Mm3YnH4-9kLar4wrvpphkhRnS55mRVXd0ePrLs3wV4gd5_Ikocb0hWqfvDBahYIUisdvo1PetFki5LacU5YQ4s2cqGXQGxE6XC8oJYL5WNf5CJ6IYSXrDKHZJeaWnngCvbo7HE',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: AppColors.outlineVariant);
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      elevation: 8,
                    ),
                    icon: const Icon(Icons.map_rounded, size: 20.0),
                    label: const Text(
                      'View on Map',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24.0, color: AppColors.onSurfaceVariant),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
