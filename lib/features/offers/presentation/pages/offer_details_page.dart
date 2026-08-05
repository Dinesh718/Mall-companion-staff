import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/presentation/widgets/app_loading_indicator.dart';
import '../../../../core/shared/presentation/widgets/app_error_state.dart';
import '../../domain/entities/offer_entity.dart';
import '../bloc/offers_bloc.dart';
import '../bloc/offers_event.dart';
import '../bloc/offers_state.dart';
import '../widgets/offer_details_header.dart';
import '../widgets/offer_banner_card.dart';
import '../widgets/campaign_overview_card.dart';
import '../widgets/campaign_validity_card.dart';
import '../widgets/store_information_card.dart';
import '../widgets/campaign_description_card.dart';
import '../widgets/campaign_health_card.dart';
import '../widgets/performance_card.dart';
import '../widgets/timeline_card.dart';
import '../widgets/terms_conditions_card.dart';
import '../widgets/offer_action_section.dart';

class OfferDetailsPage extends StatefulWidget {
  final String offerId;

  const OfferDetailsPage({
    super.key,
    required this.offerId,
  });

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  @override
  void initState() {
    super.initState();
    // Dispatch LoadOfferDetails event on entry
    context.read<OffersBloc>().add(LoadOfferDetails(widget.offerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: const OfferDetailsHeader(),
      body: BlocBuilder<OffersBloc, OffersState>(
        buildWhen: (previous, current) =>
            current is OfferDetailsLoading ||
            current is OfferDetailsLoaded ||
            current is OfferDetailsError,
        builder: (context, state) {
          if (state is OfferDetailsLoading || state is OffersInitial) {
            return _buildSkeletonLoader();
          } else if (state is OfferDetailsError) {
            return _buildErrorState(state.errorMessage);
          } else if (state is OfferDetailsLoaded) {
            return _buildDetailsContent(state.offer);
          } else {
            // fallback
            return const Center(child: AppLoadingIndicator());
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<OffersBloc, OffersState>(
        buildWhen: (previous, current) =>
            current is OfferDetailsLoading ||
            current is OfferDetailsLoaded ||
            current is OfferDetailsError ||
            current is OffersStatusUpdateInProgress ||
            current is OffersStatusUpdateFailure,
        builder: (context, state) {
          if (state is OfferDetailsLoaded) {
            return OfferActionSection(offer: state.offer);
          }
          // render disabled placeholder footer while loading/error
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetailsContent(OfferEntity offer) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner Card
          OfferBannerCard(offer: offer),
          const SizedBox(height: 24.0),

          // Overview Card
          CampaignOverviewCard(offer: offer),
          const SizedBox(height: 24.0),

          // Validity and Location section
          CampaignValidityCard(offer: offer),
          const SizedBox(height: 24.0),

          StoreInformationCard(offer: offer),
          const SizedBox(height: 24.0),

          // Strategic Context (Description)
          CampaignDescriptionCard(offer: offer),
          const SizedBox(height: 24.0),

          // Campaign Health
          CampaignHealthCard(offer: offer),
          const SizedBox(height: 24.0),

          // Live Performance Metrics
          PerformanceCard(offer: offer),
          const SizedBox(height: 24.0),

          // Status & System timelines
          TimelineCard(offer: offer),
          const SizedBox(height: 24.0),

          // Terms & Conditions accordion
          TermsConditionsCard(offer: offer),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner Skeleton
          Container(
            height: 280.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          const SizedBox(height: 24.0),

          // Card Skeleton
          Container(
            height: 180.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          const SizedBox(height: 24.0),

          // Progress Skeleton
          Container(
            height: 120.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMsg) {
    return Center(
      child: AppErrorState(
        message: errorMsg,
        onRetry: () {
          context.read<OffersBloc>().add(LoadOfferDetails(widget.offerId));
        },
      ),
    );
  }
}
