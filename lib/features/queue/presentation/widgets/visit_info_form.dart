// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_priority.dart';

class VisitInfoForm extends StatelessWidget {
  final String serviceType;
  final QueuePriority priority;
  final int estimatedDurationMinutes;

  final ValueChanged<String> onServiceTypeChanged;
  final ValueChanged<QueuePriority> onPriorityChanged;
  final ValueChanged<int> onDurationChanged;

  const VisitInfoForm({
    super.key,
    required this.serviceType,
    required this.priority,
    required this.estimatedDurationMinutes,
    required this.onServiceTypeChanged,
    required this.onPriorityChanged,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            children: [
              const Icon(
                Icons.event_available_outlined,
                color: AppColors.primary,
                size: 24.0,
              ),
              const SizedBox(width: 8.0),
              const Expanded(
                child: Text(
                  'Visit Information',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Divider(color: AppColors.outlineVariant, height: 1.0, thickness: 0.5),
          const SizedBox(height: 20.0),

          // Service Type & Priority
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 500) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildServiceTypeSection()),
                    const SizedBox(width: 24.0),
                    Expanded(child: _buildPrioritySection()),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildServiceTypeSection(),
                    const SizedBox(height: 20.0),
                    _buildPrioritySection(),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 20.0),

          // Estimated Duration
          const Text(
            'Estimated Service Duration',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: estimatedDurationMinutes,
                isExpanded: true,
                icon: const Icon(Icons.expand_more_rounded, color: AppColors.onSurfaceVariant),
                onChanged: (val) {
                  if (val != null) {
                    onDurationChanged(val);
                  }
                },
                items: const [
                  DropdownMenuItem(value: 15, child: Text('15 Minutes')),
                  DropdownMenuItem(value: 30, child: Text('30 Minutes')),
                  DropdownMenuItem(value: 45, child: Text('45 Minutes')),
                  DropdownMenuItem(value: 60, child: Text('60+ Minutes')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Service Type',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(99.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGradientStart.withOpacity(0.2),
                      blurRadius: 6.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Walk-in',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(99.0),
                  border: Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.3),
                  ),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_outline_rounded, size: 12.0, color: AppColors.onSurfaceVariant),
                      SizedBox(width: 4.0),
                      Text(
                        'Soon',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrioritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Priority Level',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            _buildPriorityButton('Normal', QueuePriority.normal),
            const SizedBox(width: 8.0),
            _buildPriorityButton('VIP', QueuePriority.vip),
            const SizedBox(width: 8.0),
            _buildPriorityButton('Senior', QueuePriority.senior),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityButton(String label, QueuePriority targetPriority) {
    final isSelected = priority == targetPriority;
    return Expanded(
      child: GestureDetector(
        onTap: () => onPriorityChanged(targetPriority),
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.outlineVariant.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(99.0),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.outlineVariant,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
