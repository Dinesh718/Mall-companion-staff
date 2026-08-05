// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

enum SaveStatus { saved, saving, unsaved, failed }

class SaveStatusChip extends StatelessWidget {
  final SaveStatus status;

  const SaveStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String text;
    Color bgColor;
    Color contentColor;

    switch (status) {
      case SaveStatus.saved:
        icon = Icons.check_circle_rounded;
        text = 'All Changes Saved';
        bgColor = const Color(0xFFE6EEFF);
        contentColor = AppColors.primary;
        break;
      case SaveStatus.saving:
        icon = Icons.sync_rounded;
        text = 'Saving changes...';
        bgColor = const Color(0xFFEFF4FF);
        contentColor = AppColors.primary;
        break;
      case SaveStatus.unsaved:
        icon = Icons.warning_rounded;
        text = 'Unsaved Changes';
        bgColor = const Color(0xFFFFDAD6);
        contentColor = AppColors.error;
        break;
      case SaveStatus.failed:
        icon = Icons.error_rounded;
        text = 'Sync Failed';
        bgColor = const Color(0xFFFFDAD6);
        contentColor = AppColors.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(99.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == SaveStatus.saving)
            Container(
              width: 14.0,
              height: 14.0,
              margin: const EdgeInsets.only(right: 6.0),
              child: CircularProgressIndicator(
                color: contentColor,
                strokeWidth: 2.0,
              ),
            )
          else
            Icon(
              icon,
              size: 16.0,
              color: contentColor,
            ),
          if (status != SaveStatus.saving) const SizedBox(width: 6.0),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: contentColor,
            ),
          ),
        ],
      ),
    );
  }
}
