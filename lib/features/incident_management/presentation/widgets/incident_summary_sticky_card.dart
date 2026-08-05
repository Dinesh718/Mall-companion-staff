import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/incident_summary_entity.dart';

class IncidentSummaryStickyCard extends StatelessWidget {
  final IncidentSummaryEntity summary;
  final VoidCallback onRefresh;

  const IncidentSummaryStickyCard({
    super.key,
    required this.summary,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24.0,
      left: 16.0,
      right: 16.0,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 448.0), // max-w-md
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: AppColors.inverseSurface,
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(color: Colors.white.withAlpha(12)), // border-white/5
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25), // shadow-xl approx
                  blurRadius: 24.0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.analytics_outlined,
                        color: AppColors.primaryFixedDim,
                        size: 20.0,
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.0, // label-md
                              fontWeight: FontWeight.w500,
                              color: AppColors.inverseOnSurface,
                            ),
                            children: [
                              TextSpan(text: '${summary.totalIncidents} Incidents • '),
                              TextSpan(
                                text: '${summary.criticalIncidents} Critical',
                                style: const TextStyle(
                                  color: AppColors.errorContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: ' • ${summary.assignedIncidents} Assigned • Updated ${_formatTimeAgo(summary.lastUpdatedTime)}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: onRefresh,
                  child: Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.refresh_rounded,
                      size: 14.0,
                      color: AppColors.inverseOnSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inMinutes == 0) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inHours}h ago';
    }
  }
}
