// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_entity.dart';

class CampaignHistoryAccordion extends StatefulWidget {
  final OfferEntity offer;

  const CampaignHistoryAccordion({
    super.key,
    required this.offer,
  });

  @override
  State<CampaignHistoryAccordion> createState() => _CampaignHistoryAccordionState();
}

class _CampaignHistoryAccordionState extends State<CampaignHistoryAccordion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Audit logs dynamic check
    final systemLogs = widget.offer.systemLogs ?? [
      {'version': 'Version 1.4', 'description': 'Last Edited By Alex Chen • Today, 10:45 AM'},
      {'version': 'Version 1.0', 'description': 'Created By Sarah Jenkins • 01 Jul, 2026'},
    ];

    return Container(
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header Button
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.history_rounded,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Campaign History',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                '${systemLogs.length} Versions saved',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.expand_more_rounded,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Collapsible Timeline Content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1.0, color: Color(0xFFF3F4F6)),
                  const SizedBox(height: 16.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: systemLogs.length,
                    itemBuilder: (context, index) {
                      final log = systemLogs[index];
                      final isFirst = index == 0;
                      final isLast = index == systemLogs.length - 1;

                      final version = log['version'] ?? 'Version 1.0';
                      final description = log['description'] ??
                          '${log['event'] ?? 'Updated'} by ${log['user'] ?? 'Staff'} • ${log['date'] ?? '2026-07-25'}';

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Timeline indicator line
                          Column(
                            children: [
                              Container(
                                width: 10.0,
                                height: 10.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isFirst ? AppColors.primary : Colors.grey[400],
                                ),
                              ),
                              if (!isLast)
                                Container(
                                  width: 2.0,
                                  height: 40.0,
                                  color: Colors.grey[200],
                                ),
                            ],
                          ),
                          const SizedBox(width: 12.0),

                          // Text detail
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  version,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: isFirst ? AppColors.onSurface : AppColors.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  description,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12.0,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
