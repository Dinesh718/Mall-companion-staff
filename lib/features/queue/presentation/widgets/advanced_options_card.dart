// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_source.dart';

class AdvancedOptionsCard extends StatelessWidget {
  final String internalNotes;
  final QueueSource queueSource;
  final ValueChanged<String> onNotesChanged;
  final ValueChanged<QueueSource> onSourceChanged;

  const AdvancedOptionsCard({
    super.key,
    required this.internalNotes,
    required this.queueSource,
    required this.onNotesChanged,
    required this.onSourceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          leading: const Icon(
            Icons.settings_outlined,
            color: AppColors.primary,
            size: 24.0,
          ),
          title: const Text(
            'Advanced Options',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          iconColor: AppColors.onSurfaceVariant,
          childrenPadding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
          children: [
            const Divider(color: AppColors.outlineVariant, height: 1.0, thickness: 0.5),
            const SizedBox(height: 20.0),

            // Internal Notes
            const Text(
              'Internal Notes (Staff Only)',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6.0),
            TextField(
              controller: TextEditingController(text: internalNotes)
                ..selection = TextSelection.fromPosition(TextPosition(offset: internalNotes.length)),
              onChanged: onNotesChanged,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'e.g. Previously visited last month, requested specific staff member.',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: AppColors.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // Queue Source & Assign Staff Row
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 500) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildQueueSourceField()),
                      const SizedBox(width: 24.0),
                      Expanded(child: _buildAssignStaffField()),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildQueueSourceField(),
                      const SizedBox(height: 20.0),
                      _buildAssignStaffField(),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildQueueSourceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Queue Source',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<QueueSource>(
              value: queueSource,
              isExpanded: true,
              icon: const Icon(Icons.expand_more_rounded, color: AppColors.onSurfaceVariant),
              onChanged: (val) {
                if (val != null) {
                  onSourceChanged(val);
                }
              },
              items: QueueSource.values.map((source) {
                return DropdownMenuItem(
                  value: source,
                  child: Text(source.toDisplayString()),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssignStaffField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Assign Staff',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(99.0),
              ),
              child: const Text(
                'COMING SOON',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 8.0,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(
          height: 48.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: AppColors.outlineVariant.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: AppColors.outlineVariant.withOpacity(0.3),
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 16.0,
                color: AppColors.onSurfaceVariant,
              ),
              SizedBox(width: 8.0),
              Text(
                'Auto-assignment active',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.0,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
