// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../data/repositories/mock_offer_repository.dart';
import '../../domain/entities/offer_entity.dart';
import '../../domain/entities/create_offer_form_entity.dart';
import '../../domain/usecases/create_offer_usecase.dart';
import '../../domain/usecases/save_offer_draft_usecase.dart';
import '../../domain/usecases/validate_offer_usecase.dart';
import '../../domain/usecases/update_offer_usecase.dart';
import '../bloc/create_offer_bloc.dart';
import '../bloc/create_offer_event.dart';
import '../bloc/create_offer_state.dart';
import '../widgets/campaign_summary_card.dart';
import '../widgets/save_status_chip.dart';
import '../widgets/basic_information_section.dart';
import '../widgets/discount_details_section.dart';
import '../widgets/campaign_schedule_section.dart';
import '../widgets/eligible_customers_section.dart';
import '../widgets/applicable_categories_section.dart';
import '../widgets/campaign_banner_section.dart';
import '../widgets/offer_description_section.dart';
import '../widgets/terms_conditions_section.dart';
import '../widgets/campaign_history_accordion.dart';
import '../widgets/create_offer_action_bar.dart';

class EditOfferPage extends StatelessWidget {
  final OfferEntity offer;

  const EditOfferPage({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    final mockRepository = MockOfferRepository();

    return BlocProvider(
      create: (context) => CreateOfferBloc(
        createOfferUseCase: CreateOfferUseCase(mockRepository),
        saveOfferDraftUseCase: SaveOfferDraftUseCase(mockRepository),
        validateOfferUseCase: ValidateOfferUseCase(mockRepository),
        updateOfferUseCase: UpdateOfferUseCase(mockRepository),
      )..add(InitializeEditOffer(offer)),
      child: EditOfferView(originalOffer: offer),
    );
  }
}

class EditOfferView extends StatelessWidget {
  final OfferEntity originalOffer;

  const EditOfferView({
    super.key,
    required this.originalOffer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOfferBloc, CreateOfferState>(
      listener: (context, state) {
        if (state is CreateOfferUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Campaign "${state.offer.title}" updated successfully!'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context, true);
        }

        if (state is CreateOfferDraftSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Draft saved successfully!'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context, true);
        }

        if (state is CreateOfferValidationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please resolve validation errors before updating.'),
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
          return Scaffold(
            appBar: _buildAppBar(context),
            body: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        final formState = _getFormState(state);
        if (formState == null) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: const Center(
              child: Text('Failed to load form details.'),
            ),
          );
        }

        // Determine Save Status
        SaveStatus saveStatus = SaveStatus.saved;
        if (state is CreateOfferPublishing || state is CreateOfferValidating) {
          saveStatus = SaveStatus.saving;
        } else if (state is CreateOfferFailure) {
          saveStatus = SaveStatus.failed;
        } else if (_hasChanges(formState, originalOffer)) {
          saveStatus = SaveStatus.unsaved;
        }

        final isUpdating = state is CreateOfferPublishing;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FC),
          appBar: _buildAppBar(context),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Campaign Summary Card
                      CampaignSummaryCard(offer: originalOffer),
                      const SizedBox(height: 16.0),

                      // Save Status Chip
                      SaveStatusChip(status: saveStatus),
                      const SizedBox(height: 24.0),

                      // Reused Form widgets
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

                      // Descriptions and terms conditions card wrapper
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
                      const SizedBox(height: 24.0),

                      // Campaign history log accordion
                      CampaignHistoryAccordion(offer: originalOffer),
                      const SizedBox(height: 48.0),
                    ],
                  ),
                ),
              ),

              // Bottom Actions Bar
              CreateOfferActionBar(
                isPublishing: isUpdating,
                cancelLabel: 'Discard',
                publishLabel: 'Update Campaign',
                onCancel: () {
                  Navigator.pop(context);
                },
                onSaveDraft: () {
                  context.read<CreateOfferBloc>().add(const SaveDraftRequested());
                },
                onPublish: () {
                  context.read<CreateOfferBloc>().add(UpdateOfferRequested(originalId: originalOffer.id));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: AppColors.primary,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit Offer',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          Text(
            'Update your campaign details',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.0,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.onSurfaceVariant,
          ),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: Container(
            width: 36.0,
            height: 36.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuC-sHDc5CIJpAC_pmZefbLtfIfUqh6vUPQkswUowXrDTKMR9BA1wQb_nvjpDccnfjZhcLKnCsBTPD1vuWDqTr_zqikIIir-QkGRXRltBBE7EOfgH7iiwzFBAraUgh6Q9YtY6h_03p5Q1tRnKpk91udjptQ3XeK5Mqn5e6KwBsCZvRvP98GuGWGdBuGz1LJ20G47q0TXK3NhopnaGPojrkk2aqDbYVwt2DnBlsT4nrknz8lMNQXOSePTHDnj_uePfr3nKVJQSh-SjA',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.person_rounded,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _hasChanges(CreateOfferFormEntity form, OfferEntity original) {
    final originalForm = CreateOfferFormEntity.fromEntity(original);
    return form.title != originalForm.title ||
        form.description != originalForm.description ||
        form.discountValue != originalForm.discountValue ||
        form.couponCode != originalForm.couponCode ||
        form.category != originalForm.category ||
        form.offerType != originalForm.offerType ||
        form.discountType != originalForm.discountType ||
        form.audience != originalForm.audience ||
        form.bannerUrl != originalForm.bannerUrl;
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
