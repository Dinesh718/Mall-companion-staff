import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../bloc/emergency_hub_bloc.dart';
import '../bloc/emergency_hub_event.dart';
import '../bloc/emergency_hub_state.dart';
import '../widgets/emergency_hero_card.dart';
import '../widgets/primary_action_card.dart';
import '../widgets/assistance_service_card.dart';
import '../widgets/facility_tile.dart';
import '../widgets/guideline_grid.dart';
import '../widgets/contact_list_tile.dart';

class EmergencyHubPage extends StatefulWidget {
  const EmergencyHubPage({super.key});

  @override
  State<EmergencyHubPage> createState() => _EmergencyHubPageState();
}

class _EmergencyHubPageState extends State<EmergencyHubPage> {
  @override
  void initState() {
    super.initState();
    context.read<EmergencyHubBloc>().add(const LoadEmergencyHubDataRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<EmergencyHubBloc, EmergencyHubState>(
        builder: (context, state) {
          if (state is EmergencyHubInitial || state is EmergencyHubLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (state is EmergencyHubError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 60.0),
                  const SizedBox(height: 16.0),
                  const Text('Failed to load emergency hub', style: TextStyle(fontFamily: 'Inter', fontSize: 18.0, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                  const SizedBox(height: 8.0),
                  Text(state.message, style: const TextStyle(fontFamily: 'Inter', color: Colors.grey)),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () => context.read<EmergencyHubBloc>().add(const LoadEmergencyHubDataRequested()),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is EmergencyHubLoaded) {
            final data = state.hubData;

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                context.read<EmergencyHubBloc>().add(const RefreshEmergencyHubDataRequested());
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                slivers: [
                  // App Bar
                  SliverAppBar(
                    floating: true,
                    pinned: true,
                    backgroundColor: AppColors.surface.withAlpha(178), // surface/70
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    titleSpacing: 16.0,
                    flexibleSpace: ClipRect(
                      child: BackdropFilter(
                        filter: _blurFilter,
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(1.0),
                      child: Container(
                        color: AppColors.outlineVariant.withAlpha(76),
                        height: 1.0,
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.menu_rounded, color: AppColors.primary),
                      onPressed: () {},
                    ),
                    title: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emergency Hub',
                          style: TextStyle(fontFamily: 'Inter', fontSize: 22.0, fontWeight: FontWeight.bold, color: AppColors.primary, height: 1.2),
                        ),
                        Text(
                          'Emergency & Assistance',
                          style: TextStyle(fontFamily: 'Inter', fontSize: 12.0, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.info_outline_rounded, color: AppColors.primary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  
                  // Mall Status Banner
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      color: AppColors.surfaceContainerLow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              color: data.isMallOperatingNormally ? Colors.green : AppColors.error,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            data.isMallOperatingNormally 
                                ? 'Mall operating normally • All services active' 
                                : 'Emergency Mode Active',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.0, // label-md
                              fontWeight: FontWeight.w500,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Body
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0), // p-margin-mobile
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Location Card
                        GlassCard(
                          padding: const EdgeInsets.all(12.0),
                          borderRadius: 12.0,
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_rounded, color: AppColors.primary),
                              const SizedBox(width: 12.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Your Location',
                                    style: TextStyle(fontFamily: 'Inter', fontSize: 12.0, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant),
                                  ),
                                  Text(
                                    data.locationText,
                                    style: const TextStyle(fontFamily: 'Inter', fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.onSurface),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),

                        // Hero Card
                        EmergencyHeroCard(
                          securityTeamStatus: data.securityTeamStatus,
                          avgResponseTime: data.avgResponseTime,
                          mallStatusText: data.mallStatusText,
                        ),
                        const SizedBox(height: 24.0),

                        // Primary Actions Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: MediaQuery.of(context).size.width < 400 ? 0.9 : 1.1,
                          ),
                          itemCount: data.primaryActions.length,
                          itemBuilder: (context, index) {
                            return PrimaryActionCard(
                              action: data.primaryActions[index],
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${data.primaryActions[index].title} triggered (Placeholder)')),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 24.0),

                        // Assistance Services
                        const SectionHeader(title: 'Assistance Services'),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width >= 768 ? 4 : (MediaQuery.of(context).size.width < 400 ? 1 : 2),
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: MediaQuery.of(context).size.width < 400 ? 3.0 : 2.2,
                          ),
                          itemCount: data.assistanceServices.length,
                          itemBuilder: (context, index) {
                            return AssistanceServiceCard(
                              service: data.assistanceServices[index],
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${data.assistanceServices[index].title} tapped (Placeholder)')),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 24.0),

                        // Nearby Facilities
                        const SectionHeader(title: 'Nearby Facilities'),
                        ...data.nearbyFacilities.map((facility) => FacilityTile(
                          facility: facility,
                          onViewOnMap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('View ${facility.name} on Map (Placeholder)')),
                            );
                          },
                        )),
                        const SizedBox(height: 24.0),

                        // Safety Guidelines
                        const SectionHeader(title: 'Safety Guidelines'),
                        GuidelineGrid(guidelines: data.guidelines),
                        const SizedBox(height: 24.0),

                        // Emergency Contacts
                        const SectionHeader(title: 'Emergency Contacts'),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            children: List.generate(data.emergencyContacts.length, (index) {
                              return ContactListTile(
                                contact: data.emergencyContacts[index],
                                isLast: index == data.emergencyContacts.length - 1,
                                onCall: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Calling ${data.emergencyContacts[index].name} (Placeholder)')),
                                  );
                                },
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 80.0), // Padding for bottom nav
                      ]),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  ImageFilter get _blurFilter => ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0);
}
