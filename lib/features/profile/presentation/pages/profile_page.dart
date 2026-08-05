import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

import '../widgets/profile_hero_card.dart';
import '../widgets/availability_status_card.dart';
import '../widgets/performance_snapshot_card.dart';
import '../widgets/contact_info_card.dart';
import '../widgets/work_info_card.dart';
import '../widgets/skills_certifications_card.dart';
import '../widgets/documents_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/additional_info_cards.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.stitchBackground,
      appBar: AppBar(
        backgroundColor: AppColors.stitchBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Profile',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Text(
              'MAINTENANCE STAFF',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.05,
                color: const Color(0xFF191C1E).withAlpha(153),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primary),
            onPressed: () {
              // Edit profile logic
            },
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, color: Colors.red, size: 48.0),
                  const SizedBox(height: 16.0),
                  Text(
                    'Failed to load profile',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(const LoadProfileRequested());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is ProfileLoaded) {
            final profile = state.profile;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(const RefreshProfileRequested());
              },
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileHeroCard(profile: profile),
                    const SizedBox(height: 16.0),
                    AvailabilityStatusCard(profile: profile),
                    const SizedBox(height: 16.0),
                    PerformanceSnapshotCard(profile: profile),
                    const SizedBox(height: 16.0),
                    ContactInfoCard(profile: profile),
                    const SizedBox(height: 16.0),
                    WorkInfoCard(profile: profile),
                    const SizedBox(height: 16.0),
                    SkillsCertificationsCard(profile: profile),
                    const SizedBox(height: 16.0),
                    DocumentsCard(profile: profile),
                    const SizedBox(height: 16.0),
                    EmergencyInfoCard(profile: profile),
                    const SizedBox(height: 16.0),
                    AuthorizedEquipmentCard(profile: profile),
                    const SizedBox(height: 16.0),
                    const QuickActionsGrid(),
                    const SizedBox(height: 80.0), // Padding for bottom nav
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
