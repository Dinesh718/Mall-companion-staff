import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/emergency_entity.dart';

class EmergencyResponseStepper extends StatelessWidget {
  final EmergencyStatus currentStatus;

  const EmergencyResponseStepper({
    super.key,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      _StepperStep(label: 'Reported', status: EmergencyStatus.reported),
      _StepperStep(label: 'Accepted', status: EmergencyStatus.accepted),
      _StepperStep(label: 'En Route', status: EmergencyStatus.navigationStarted),
      _StepperStep(label: 'On Site', status: EmergencyStatus.onSite),
      _StepperStep(label: 'Resolved', status: EmergencyStatus.resolved),
    ];

    int currentIndex = steps.indexWhere((step) => step.status == currentStatus);
    if (currentIndex == -1) {
      // fallback if status is something intermediate like assigned or assistanceInProgress
      if (currentStatus == EmergencyStatus.assigned) currentIndex = 0; // closer to reported
      if (currentStatus == EmergencyStatus.assistanceInProgress) currentIndex = 3; // closer to onSite
    }
    
    // For calculating the active track width (as a proportion of total steps)
    // There are (steps.length - 1) segments.
    final segments = steps.length - 1;
    final activeSegments = currentIndex;
    final double activeFraction = activeSegments / segments;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Background track
        Positioned(
          left: 16.0,
          right: 16.0,
          child: Container(
            height: 2.0,
            color: AppColors.surfaceVariant,
          ),
        ),
        // Active track
        Positioned(
          left: 16.0,
          right: 16.0,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: activeFraction,
            child: Container(
              height: 2.0,
              color: AppColors.primary,
            ),
          ),
        ),
        // Nodes
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(steps.length, (index) {
            final step = steps[index];
            final isCompleted = index < currentIndex;
            final isCurrent = index == currentIndex;

            return Container(
              color: AppColors.surface, // to cover the track line behind the node
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildNode(isCompleted: isCompleted, isCurrent: isCurrent),
                  const SizedBox(height: 4.0),
                  Text(
                    step.label,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500,
                      color: isCurrent || isCompleted ? (isCurrent ? AppColors.primary : AppColors.onSurface) : AppColors.outline,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildNode({required bool isCompleted, required bool isCurrent}) {
    if (isCompleted) {
      return Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, size: 12.0, color: Colors.white),
      );
    } else if (isCurrent) {
      return Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 2.0),
        ),
        child: Center(
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.surfaceVariant, width: 2.0),
        ),
      );
    }
  }
}

class _StepperStep {
  final String label;
  final EmergencyStatus status;

  _StepperStep({required this.label, required this.status});
}
