// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class CreateOfferActionBar extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSaveDraft;
  final VoidCallback onPublish;
  final bool isPublishing;
  final String cancelLabel;
  final String publishLabel;

  const CreateOfferActionBar({
    super.key,
    required this.onCancel,
    required this.onSaveDraft,
    required this.onPublish,
    this.isPublishing = false,
    this.cancelLabel = 'Cancel',
    this.publishLabel = 'Publish Offer',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 30.0,
            offset: const Offset(0, -10),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant.withOpacity(0.3),
            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 12.0,
        bottom: 12.0 + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        children: [
          // Cancel Button
          ElevatedButton(
            onPressed: isPublishing ? null : onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.onSurfaceVariant,
              elevation: 0,
              side: const BorderSide(color: AppColors.outlineVariant, width: 1.0),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            ),
            child: Text(
              cancelLabel,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8.0),

          // Save Draft Button
          ElevatedButton(
            onPressed: isPublishing ? null : onSaveDraft,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              elevation: 0,
              side: const BorderSide(color: AppColors.primary, width: 1.0),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            ),
            child: const Text(
              'Save Draft',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12.0),

          // Publish Offer Button (fills remaining width)
          Expanded(
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                gradient: isPublishing
                    ? null
                    : const LinearGradient(
                        colors: [
                          AppColors.primaryGradientStart,
                          AppColors.primaryGradientEnd,
                        ],
                      ),
                color: isPublishing ? Colors.grey[300] : null,
                borderRadius: BorderRadius.circular(99.0),
                boxShadow: isPublishing
                    ? null
                    : [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 12.0,
                          offset: const Offset(0, 6),
                        ),
                      ],
              ),
              child: ElevatedButton.icon(
                onPressed: isPublishing ? null : onPublish,
                icon: isPublishing
                    ? const SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        ),
                      )
                    : const Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 20.0),
                label: Text(
                  isPublishing
                      ? (publishLabel == 'Update Campaign' ? 'Updating...' : 'Publishing...')
                      : publishLabel,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
