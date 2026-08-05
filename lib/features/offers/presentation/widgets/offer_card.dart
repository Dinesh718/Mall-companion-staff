// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_entity.dart';
import '../../domain/usecases/load_offers_usecase.dart';
import '../../domain/usecases/search_offers_usecase.dart';
import '../../domain/usecases/filter_offers_usecase.dart';
import '../../domain/usecases/load_offer_details_usecase.dart';
import '../../data/repositories/mock_offer_repository.dart';
import '../bloc/offers_bloc.dart';
import '../pages/offer_details_page.dart';
import '../pages/edit_offer_page.dart';
import '../bloc/offers_event.dart';

class OfferCard extends StatelessWidget {
  final OfferEntity offer;

  const OfferCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamic status calculations
    final isExpiring = offer.metadata != null && offer.metadata!['alertType'] == 'expires_tomorrow';
    final progress = offer.views > 0 ? (offer.redemptions / (offer.views * 0.3)).clamp(0.0, 1.0) : 0.0;
    final progressPercent = (progress * 100).toInt();

    // Format dates
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    String formatDate(DateTime dt) {
      return '${dt.day.toString().padLeft(2, '0')} ${months[dt.month - 1]}';
    }
    final dateRangeStr = '${formatDate(offer.startDate)} - ${formatDate(offer.endDate)}';

    void navigateToDetails() {
      final mockRepo = MockOfferRepository();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider<OffersBloc>(
            create: (context) => OffersBloc(
              loadOffersUseCase: LoadOffersUseCase(mockRepo),
              searchOffersUseCase: SearchOffersUseCase(mockRepo),
              filterOffersUseCase: FilterOffersUseCase(mockRepo),
              loadOfferDetailsUseCase: LoadOfferDetailsUseCase(mockRepo),
            ),
            child: OfferDetailsPage(offerId: offer.id),
          ),
        ),
      ).then((result) {
        if (result == true && context.mounted) {
          context.read<OffersBloc>().add(const LoadOffers());
        }
      });
    }

    return GestureDetector(
      onTap: navigateToDetails,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.04),
            blurRadius: 16.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner Image + Overlays
          Container(
            height: 200.0,
            decoration: const BoxDecoration(
              color: Color(0xFFF0F3FF),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    offer.bannerUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primary.withOpacity(0.05),
                      child: const Icon(
                        Icons.broken_image_rounded,
                        color: AppColors.primary,
                        size: 48.0,
                      ),
                    ),
                  ),
                ),
                // Gradient bottom scrim
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                // Top Left: discount tag
                Positioned(
                  top: 16.0,
                  left: 16.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: isExpiring ? const Color(0xFFF59E0B) : AppColors.primary,
                      borderRadius: BorderRadius.circular(99.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isExpiring ? Icons.bolt_rounded : Icons.stars_rounded,
                          color: Colors.white,
                          size: 14.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          isExpiring ? 'FLASH SALE' : '${offer.discountValue.toInt()}% OFF',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Top Right: Status Badge & Logo
                Positioned(
                  top: 16.0,
                  right: 16.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: isExpiring ? const Color(0xFFFEF2F2) : Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(99.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4.0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6.0,
                              height: 6.0,
                              decoration: BoxDecoration(
                                color: isExpiring ? const Color(0xFFEF4444) : AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            Text(
                              isExpiring ? 'Expiring' : offer.status,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: isExpiring ? const Color(0xFFB91C1C) : AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: Image.network(
                          offer.storeLogoUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.storefront,
                            size: 16.0,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Bottom texts: Category + Title
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.category_outlined,
                            color: Colors.white70,
                            size: 14.0,
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            offer.category.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        offer.title,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Card Details (views, redeems, progress, action buttons)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isExpiring ? Icons.timer_rounded : Icons.calendar_today_rounded,
                          color: isExpiring ? const Color(0xFFD97706) : AppColors.onSurfaceVariant,
                          size: 16.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          isExpiring ? 'Ends in 24 hours' : dateRangeStr,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13.0,
                            fontWeight: isExpiring ? FontWeight.bold : FontWeight.normal,
                            color: isExpiring ? const Color(0xFFD97706) : AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              offer.views >= 1000 ? '${(offer.views / 1000).toStringAsFixed(1)}k' : offer.views.toString(),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const Text(
                              'VIEWS',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 9.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              offer.redemptions >= 1000 ? '${(offer.redemptions / 1000).toStringAsFixed(1)}k' : offer.redemptions.toString(),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const Text(
                              'REDEEMED',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 9.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'PERFORMANCE PROGRESS',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          '$progressPercent%',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: isExpiring ? const Color(0xFFD97706) : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      height: 6.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F3FF),
                        borderRadius: BorderRadius.circular(99.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isExpiring
                                  ? [const Color(0xFFF59E0B), const Color(0xFFD97706)]
                                  : [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
                            ),
                            borderRadius: BorderRadius.circular(99.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                // Actions divider line
                Divider(
                  color: AppColors.outlineVariant.withOpacity(0.3),
                  height: 1.0,
                ),
                const SizedBox(height: 16.0),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: navigateToDetails,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'VIEW DETAILS',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 14.0,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 36.0,
                          height: 36.0,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F3FF),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.analytics_outlined,
                              size: 18.0,
                              color: AppColors.onSurfaceVariant,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Analytics (future milestone)'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          width: 36.0,
                          height: 36.0,
                          decoration: BoxDecoration(
                            color: isExpiring ? const Color(0xFFFEF3C7) : const Color(0xFFF0F3FF),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.edit_outlined,
                              size: 18.0,
                              color: isExpiring ? const Color(0xFFB91C1C) : AppColors.onSurfaceVariant,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditOfferPage(offer: offer),
                                ),
                              ).then((result) {
                                if (result == true && context.mounted) {
                                  context.read<OffersBloc>().add(const LoadOffers());
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
