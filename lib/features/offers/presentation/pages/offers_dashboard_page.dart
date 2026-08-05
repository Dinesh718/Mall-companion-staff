// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_offer_page.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_loading_indicator.dart';
import '../../../../core/shared/presentation/widgets/app_error_state.dart';
import '../../data/repositories/mock_offer_repository.dart';
import '../../domain/usecases/load_offers_usecase.dart';
import '../../domain/usecases/search_offers_usecase.dart';
import '../../domain/usecases/filter_offers_usecase.dart';
import '../../domain/usecases/load_offer_details_usecase.dart';
import '../../domain/usecases/search_and_filter_offers_usecase.dart';
import '../bloc/offers_bloc.dart';
import '../bloc/offers_event.dart';
import '../bloc/offers_state.dart';
import '../widgets/offers_dashboard_header.dart';
import '../widgets/offers_overview_card.dart';
import '../widgets/offers_statistics_section.dart';
import '../widgets/offers_search_bar.dart';
import '../widgets/offers_attention_card.dart';
import '../widgets/offer_card.dart';
import '../widgets/offers_recent_activity.dart';

class OffersDashboardPage extends StatelessWidget {
  final bool showBackButton;

  const OffersDashboardPage({
    super.key,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockOfferRepository();
    return BlocProvider(
      create: (context) => OffersBloc(
        loadOffersUseCase: LoadOffersUseCase(mockRepo),
        searchOffersUseCase: SearchOffersUseCase(mockRepo),
        filterOffersUseCase: FilterOffersUseCase(mockRepo),
        loadOfferDetailsUseCase: LoadOfferDetailsUseCase(mockRepo),
        searchAndFilterOffersUseCase: SearchAndFilterOffersUseCase(mockRepo),
      )..add(const LoadOffers()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9FF), // Stitch background
        appBar: OffersDashboardHeader(showBackButton: showBackButton),
        body: Stack(
          children: [
            // Decorative background mesh bubbles
            Positioned(
              top: -100,
              left: -100,
              width: 350,
              height: 350,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.04),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              right: -150,
              width: 450,
              height: 450,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withOpacity(0.04),
                ),
              ),
            ),

            // Content Body Builder
            BlocBuilder<OffersBloc, OffersState>(
              builder: (context, state) {
                if (state is OffersLoading || state is OffersInitial) {
                  return const AppLoadingIndicator();
                } else if (state is OffersError) {
                  return AppErrorState(
                    title: 'Failed to load campaigns',
                    message: state.errorMessage,
                    onRetry: () {
                      context.read<OffersBloc>().add(const LoadOffers());
                    },
                  );
                } else if (state is OffersLoaded) {
                  final offers = state.offers;
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<OffersBloc>().add(const RefreshOffers());
                    },
                    color: AppColors.primary,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24.0),

                          // Greeting Section
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Offers Management',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Create and manage promotional campaigns.',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16.0,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24.0),

                          // Hero Overview Card
                          OffersOverviewCard(allOffers: state.allOffers),
                          const SizedBox(height: 24.0),

                          // Statistics Section
                          OffersStatisticsSection(allOffers: state.allOffers),
                          const SizedBox(height: 24.0),

                          // Search & Filter
                          OffersSearchBar(
                            activeFilter: state.activeFilter,
                            searchQuery: state.searchQuery,
                          ),
                          const SizedBox(height: 24.0),

                          // Requires Attention
                          const OffersAttentionCard(),
                          const SizedBox(height: 24.0),

                          // Live Campaigns header title
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Live Campaigns',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textNavy,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Container(
                                      width: 24.0,
                                      height: 24.0,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.08),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          offers.length.toString(),
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Sort campaigns clicked (mock)'),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.sort_rounded, size: 16.0),
                                      label: const Text('Sort'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColors.primary,
                                        textStyle: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Viewing all campaigns (mock)'),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColors.primary,
                                        textStyle: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      child: const Text('View All'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12.0),

                          // Offers Card Lists
                          if (offers.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 40.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.search_off_rounded, size: 48.0, color: Colors.grey),
                                    SizedBox(height: 12.0),
                                    Text(
                                      'No matching campaigns found',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: offers.length > 5 ? 5 : offers.length, // Display up to 5 campaigns in list view
                              separatorBuilder: (context, index) => const SizedBox(height: 20.0),
                              itemBuilder: (context, index) {
                                return OfferCard(offer: offers[index]);
                              },
                            ),
                          const SizedBox(height: 24.0),

                          // Recent Activity section
                          const OffersRecentActivity(),
                          const SizedBox(height: 100.0), // Padding for Floating Action Button
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),

        // Extended Floating Action Button (Create Offer)
        floatingActionButton: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF7B2FF7),
                Color(0xFF3B82F6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(99.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7B2FF7).withOpacity(0.4),
                blurRadius: 16.0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateOfferPage(),
                ),
              );
              if (result == true && context.mounted) {
                context.read<OffersBloc>().add(const LoadOffers());
              }
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            highlightElevation: 0,
            icon: const Icon(Icons.add_rounded, color: Colors.white),
            label: const Text(
              'Create Offer',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
