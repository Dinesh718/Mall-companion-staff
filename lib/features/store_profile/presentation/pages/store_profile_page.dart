// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_loading_indicator.dart';
import '../../../../core/shared/presentation/widgets/app_error_state.dart';
import '../../data/repositories/mock_store_profile_repository.dart';
import '../../domain/usecases/load_store_profile_usecase.dart';
import '../bloc/store_profile_bloc.dart';
import '../bloc/store_profile_event.dart';
import '../bloc/store_profile_state.dart';
import '../widgets/store_profile_header.dart';
import '../widgets/store_identity_card.dart';
import '../widgets/statistics_section.dart';
import '../widgets/location_card.dart';
import '../widgets/operational_status_card.dart';
import '../widgets/weekly_schedule_card.dart';
import '../widgets/social_media_card.dart';
import '../widgets/gallery_card.dart';

class StoreProfilePage extends StatelessWidget {
  final bool showBackButton;

  const StoreProfilePage({
    super.key,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreProfileBloc(
        loadStoreProfileUseCase: LoadStoreProfileUseCase(
          MockStoreProfileRepository(),
        ),
      )..add(const LoadStoreProfile()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FC), // secondary background
        appBar: StoreProfileHeader(
          storeBannerUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuC-EZhClocgHJZSKt-p2qxVEoaEkYwbpHXGj9nDZNoia8KfalctAexN2Nelsh5fpvVI3sy-z9dWBL3pE_Q-WFi_IWAuPsvXvyK1bpEEPeSkQyWPrXRmEwe78IaJPhdT4rEphEA5P9YuK8cxc4XL5gve623BsB3SQCiBYgAP4S9loiEqdV-8x-mkMP95AAjE0GG9d5dc9AJJRt_302ATzmYUkyJb0Eu5ldBS6ukIF26nTmeatmhK-0jZnrDMSPheLW_Og4blCWQy6A',
          showBackButton: showBackButton,
        ),
        body: BlocBuilder<StoreProfileBloc, StoreProfileState>(
          builder: (context, state) {
            if (state is StoreProfileLoading || state is StoreProfileInitial) {
              return const AppLoadingIndicator();
            } else if (state is StoreProfileError) {
              return AppErrorState(
                title: 'Failed to load store profile',
                message: state.errorMessage,
                onRetry: () {
                  context.read<StoreProfileBloc>().add(const LoadStoreProfile());
                },
              );
            } else if (state is StoreProfileLoaded) {
              final store = state.store;
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      context.read<StoreProfileBloc>().add(const RefreshStoreProfile());
                    },
                    color: AppColors.primary,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24.0),
                          StoreIdentityCard(store: store),
                          const SizedBox(height: 24.0),
                          StatisticsSection(store: store),
                          const SizedBox(height: 24.0),
                          LocationCard(store: store),
                          const SizedBox(height: 24.0),
                          OperationalStatusCard(store: store),
                          const SizedBox(height: 24.0),
                          WeeklyScheduleCard(store: store),
                          const SizedBox(height: 24.0),
                          SocialMediaCard(store: store),
                          const SizedBox(height: 24.0),
                          GalleryCard(galleryUrls: store.galleryUrls),
                          const SizedBox(height: 32.0),

                          // Footer Note
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.history_rounded,
                                  size: 14.0,
                                  color: AppColors.textGray,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  'Last Updated: ${store.lastUpdated}',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11.0,
                                    color: AppColors.textGray,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Floating Action Button matching gradient and styling
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryGradientStart,
                            AppColors.primaryGradientEnd,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryGradientStart.withOpacity(0.3),
                            blurRadius: 16.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Edit Store Profile (future milestone)'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(16.0),
                          child: const Icon(
                            Icons.edit_rounded,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
