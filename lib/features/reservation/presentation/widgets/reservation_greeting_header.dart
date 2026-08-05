import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../pages/create_reservation_page.dart';

class ReservationGreetingHeader extends StatelessWidget {
  final int totalReservations;

  const ReservationGreetingHeader({
    super.key,
    required this.totalReservations,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium Boutique • Tuesday, Oct 24',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontFamily: 'Inter',
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Good afternoon, Staff',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'You have $totalReservations reservations today.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Inter',
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (MediaQuery.of(context).size.width > 600)
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(76),
                    blurRadius: 10.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateReservationPage(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12.0),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Text(
                      '+ New Reservation',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
}
