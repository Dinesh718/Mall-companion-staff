// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../../../../core/themes/app_colors.dart';
import '../../data/repositories/mock_offer_repository.dart';
import '../../domain/usecases/create_offer_usecase.dart';
import '../../domain/usecases/save_offer_draft_usecase.dart';
import '../../domain/usecases/validate_offer_usecase.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';
import '../bloc/create_offer_state.dart';
import '../widgets/create_offer_header.dart';
import '../widgets/campaign_progress_indicator.dart';
import '../widgets/basic_information_section.dart';
import '../widgets/discount_details_section.dart';
import '../widgets/campaign_schedule_section.dart';
import '../widgets/eligible_customers_section.dart';
import '../widgets/applicable_categories_section.dart';
import '../widgets/campaign_banner_section.dart';
import '../widgets/offer_description_section.dart';
import '../widgets/terms_conditions_section.dart';
import '../widgets/create_offer_action_bar.dart';

class CreateOfferPage extends StatelessWidget {
  const CreateOfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mockRepository = MockOfferRepository();

    return BlocProvider(
      create: (context) => CreateOfferBloc(
        createOfferUseCase: CreateOfferUseCase(mockRepository),
        saveOfferDraftUseCase: SaveOfferDraftUseCase(mockRepository),
        validateOfferUseCase: ValidateOfferUseCase(mockRepository),
      )..add(const InitializeCreateOffer()),
      child: const CreateOfferView(),
    );
  }
}

class CreateOfferView extends StatelessWidget {
  const CreateOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOfferBloc, CreateOfferState>(
      listener: (context, state) {
        if (state is CreateOfferDraftSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Draft "${state.offer.title}" saved successfully!'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context, true);
        }

        if (state is CreateOfferPublished) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Campaign "${state.offer.title}" published successfully!'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context, true);
        }

        if (state is CreateOfferValidationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please resolve all validation errors before publishing.'),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        if (state is CreateOfferFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CreateOfferInitial) {
          return const Scaffold(
            appBar: CreateOfferHeader(),
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        // Extract form values
        final formState = _getFormState(state);
        final isPublishing = state is CreateOfferPublishing;

        if (formState == null) {
          return const Scaffold(
            appBar: CreateOfferHeader(),
            body: Center(
              child: Text('Failed to initialize form'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FC),
          appBar: const CreateOfferHeader(),
          body: Column(
            children: [
              // Progress indicator below App Bar
              CampaignProgressIndicator(form: formState),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  child: Column(
                    children: [
                      // Hero Header Banner
                      _buildHeroCard(),
                      const SizedBox(height: 24.0),

                      // Step Sections
                      BasicInformationSection(form: formState),
                      const SizedBox(height: 24.0),

                      DiscountDetailsSection(form: formState),
                      const SizedBox(height: 24.0),

                      CampaignScheduleSection(form: formState),
                      const SizedBox(height: 24.0),

                      EligibleCustomersSection(form: formState),
                      const SizedBox(height: 24.0),

                      ApplicableCategoriesSection(form: formState),
                      const SizedBox(height: 24.0),

                      CampaignBannerSection(form: formState),
                      const SizedBox(height: 24.0),

                      // Text description area cards
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.0),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            OfferDescriptionSection(form: formState),
                            const SizedBox(height: 24.0),
                            TermsConditionsSection(form: formState),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48.0),
                    ],
                  ),
                ),
              ),

              // Sticky Bottom Action Bar
              CreateOfferActionBar(
                isPublishing: isPublishing,
                onCancel: () {
                  Navigator.pop(context);
                },
                onSaveDraft: () {
                  context.read<CreateOfferBloc>().add(const SaveDraftRequested());
                },
                onPublish: () {
                  context.read<CreateOfferBloc>().add(const PublishOfferRequested());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryGradientStart,
            AppColors.primaryGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 12.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(99.0),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.stars_rounded, color: Colors.white, size: 14.0),
                SizedBox(width: 4.0),
                Text(
                  'Draft Mode',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          const Row(
            children: [
              Icon(Icons.campaign_rounded, color: Colors.white, size: 36.0),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Campaign',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'Create and publish promotional campaigns.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.0,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  CreateOfferFormEntity? _getFormState(CreateOfferState state) {
    if (state is CreateOfferEditing) return state.formState;
    if (state is CreateOfferValidationError) return state.formState;
    if (state is CreateOfferFailure) return state.formState;
    if (state is CreateOfferValidating) return state.formState;
    if (state is CreateOfferPublishing) return state.formState;
    return null;
  }
}
