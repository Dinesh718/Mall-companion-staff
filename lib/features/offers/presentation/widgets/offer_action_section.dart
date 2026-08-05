// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/offer_entity.dart';
import '../pages/edit_offer_page.dart';
import '../bloc/offers_bloc.dart';
import '../bloc/offers_event.dart';
import '../bloc/offers_state.dart';
import 'destructive_confirmation_dialog.dart';

class OfferActionSection extends StatelessWidget {
  final OfferEntity offer;

  const OfferActionSection({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersBloc, OffersState>(
      builder: (context, state) {
        final isUpdatingStatus = state is OffersStatusUpdateInProgress;
        final isActive = offer.status.toLowerCase() == 'active';

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            border: Border(
              top: BorderSide(
                color: AppColors.outlineVariant.withOpacity(0.3),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10.0,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Primary Edit Button (Gradient, Height 60px)
                Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryGradientStart,
                        AppColors.primaryGradientEnd,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGradientStart.withOpacity(0.3),
                        blurRadius: 12.0,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: isUpdatingStatus
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditOfferPage(offer: offer),
                                ),
                              ).then((result) {
                                if (result == true && context.mounted) {
                                  context.read<OffersBloc>().add(LoadOfferDetails(offer.id));
                                }
                              });
                            },
                      borderRadius: BorderRadius.circular(20.0),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_document,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Edit Campaign',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),

                // Actions Row (Pause/Activate + Delete side-by-side)
                Row(
                  children: [
                    // Dynamic Status Toggle Button (Pause/Activate, Height 56px)
                    Expanded(
                      child: Container(
                        height: 56.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: AppColors.outlineVariant.withOpacity(0.5),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: isUpdatingStatus
                                ? null
                                : () {
                                    context.read<OffersBloc>().add(
                                          UpdateOfferStatusRequested(
                                            offer.id,
                                            isActive ? 'Paused' : 'Active',
                                          ),
                                        );
                                  },
                            borderRadius: BorderRadius.circular(16.0),
                            child: Center(
                              child: isUpdatingStatus
                                  ? const SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          isActive
                                              ? Icons.pause_circle_outline_rounded
                                              : Icons.play_circle_outline_rounded,
                                          color: AppColors.primary,
                                          size: 20.0,
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          isActive ? 'Pause' : 'Activate',
                                          style: const TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),

                    // Destructive Delete Button (Error Color background, Height 56px)
                    Expanded(
                      child: Container(
                        height: 56.0,
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.error.withOpacity(0.3),
                              blurRadius: 12.0,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: isUpdatingStatus
                                ? null
                                : () {
                                    final bloc = context.read<OffersBloc>();
                                    showDialog<bool>(
                                      context: context,
                                      builder: (dialogCtx) => DestructiveConfirmationDialog(
                                        offerId: offer.id,
                                        offersBloc: bloc,
                                      ),
                                    ).then((deleted) {
                                      if (deleted == true && context.mounted) {
                                        Navigator.of(context).pop(true);
                                      }
                                    });
                                  },
                            borderRadius: BorderRadius.circular(16.0),
                            child: const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
