// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../bloc/offers_bloc.dart';
import '../bloc/offers_event.dart';
import '../bloc/offers_state.dart';

class DestructiveConfirmationDialog extends StatelessWidget {
  final String offerId;
  final OffersBloc offersBloc;

  const DestructiveConfirmationDialog({
    super.key,
    required this.offerId,
    required this.offersBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: offersBloc,
      child: BlocConsumer<OffersBloc, OffersState>(
        listener: (context, state) {
          if (state is OffersDeleteSuccess) {
            Navigator.of(context).pop(true);
          } else if (state is OffersDeleteFailure) {
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
          final isDeleting = state is OffersDeleting;

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'Delete Campaign?',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: AppColors.onSurface,
              ),
            ),
            content: const Text(
              'Are you sure you want to delete this campaign? This action cannot be undone.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.0,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            actionsPadding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
            actions: [
              TextButton(
                onPressed: isDeleting
                    ? null
                    : () {
                        Navigator.of(context).pop(false);
                      },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: isDeleting
                    ? null
                    : () {
                        context.read<OffersBloc>().add(DeleteOfferRequested(offerId));
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.error.withOpacity(0.3),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99.0),
                  ),
                ),
                child: isDeleting
                    ? const SizedBox(
                        width: 18.0,
                        height: 18.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Delete',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
