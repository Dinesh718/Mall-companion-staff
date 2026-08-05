// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_status.dart';

class ManageSessionSection extends StatelessWidget {
  final QueueStatus status;
  final String? activeAction;
  final VoidCallback onCall;
  final VoidCallback onArrived;
  final VoidCallback onStart;
  final VoidCallback onComplete;
  final VoidCallback onSkip;
  final VoidCallback onCancel;

  const ManageSessionSection({
    super.key,
    required this.status,
    required this.activeAction,
    required this.onCall,
    required this.onArrived,
    required this.onStart,
    required this.onComplete,
    required this.onSkip,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Manage Session',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 16.0),

        if (status == QueueStatus.completed)
          _buildStatusMessageCard(
            context,
            color: const Color(0xFFE6F4EA),
            borderColor: const Color(0xFF34A853).withOpacity(0.3),
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xFF137333),
            title: 'Completed Successfully',
            subtitle: 'The customer service transaction was finalized.',
          )
        else if (status == QueueStatus.cancelled)
          _buildStatusMessageCard(
            context,
            color: const Color(0xFFFCE8E6),
            borderColor: const Color(0xFFEA4335).withOpacity(0.3),
            icon: Icons.cancel_rounded,
            iconColor: const Color(0xFFC5221F),
            title: 'Queue Cancelled',
            subtitle: 'This session has been marked as cancelled.',
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth = (constraints.maxWidth - 24.0) / 3;
              final isAnyLoading = activeAction != null;
              final actions = <Widget>[];

              if (status == QueueStatus.waiting) {
                actions.add(_ActionCard(
                  width: cardWidth,
                  icon: Icons.call_rounded,
                  label: 'Call Customer',
                  onTap: onCall,
                  isLoading: activeAction == 'call',
                  isDisabled: isAnyLoading,
                  iconColor: AppColors.primary,
                ));
                actions.add(_ActionCard(
                  width: cardWidth,
                  icon: Icons.how_to_reg_rounded,
                  label: 'Mark Arrived',
                  onTap: onArrived,
                  isLoading: activeAction == 'arrive',
                  isDisabled: isAnyLoading,
                  iconColor: AppColors.primary,
                ));
                actions.add(_ActionCard(
                  width: cardWidth,
                  icon: Icons.skip_next_rounded,
                  label: 'Skip Customer',
                  onTap: onSkip,
                  isLoading: activeAction == 'skip',
                  isDisabled: isAnyLoading,
                  iconColor: AppColors.primary,
                ));
                actions.add(_ActionCard(
                  width: cardWidth,
                  icon: Icons.cancel_rounded,
                  label: 'Cancel Queue',
                  onTap: onCancel,
                  isLoading: activeAction == 'cancel',
                  isDisabled: isAnyLoading,
                  iconColor: AppColors.error,
                  isError: true,
                ));
              } else if (status == QueueStatus.called) {
                actions.add(_ActionCard(
                  width: cardWidth,
                  icon: Icons.how_to_reg_rounded,
                  label: 'Mark Arrived',
                  onTap: onArrived,
                  isLoading: activeAction == 'arrive',
                  isDisabled: isAnyLoading,
                  iconColor: AppColors.primary,
                ));
                actions.add(_ActionCard(
                  width: cardWidth,
                  icon: Icons.skip_next_rounded,
                  label: 'Skip Customer',
                  onTap: onSkip,
                  isLoading: activeAction == 'skip',
                  isDisabled: isAnyLoading,
                  iconColor: AppColors.primary,
                ));
                actions.add(_ActionCard(
                  width: cardWidth,
                  icon: Icons.cancel_rounded,
                  label: 'Cancel Queue',
                  onTap: onCancel,
                  isLoading: activeAction == 'cancel',
                  isDisabled: isAnyLoading,
                  iconColor: AppColors.error,
                  isError: true,
                ));
              } else if (status == QueueStatus.arrived) {
                actions.add(_ActionCard(
                  width: cardWidth,
                  icon: Icons.play_arrow_rounded,
                  label: 'Start Service',
                  onTap: onStart,
                  isLoading: activeAction == 'start',
                  isDisabled: isAnyLoading,
                  iconColor: AppColors.primary,
                ));
                actions.add(_ActionCard(
                  width: cardWidth,
                  icon: Icons.cancel_rounded,
                  label: 'Cancel Queue',
                  onTap: onCancel,
                  isLoading: activeAction == 'cancel',
                  isDisabled: isAnyLoading,
                  iconColor: AppColors.error,
                  isError: true,
                ));
              } else if (status == QueueStatus.serving) {
                actions.add(_ActionCard(
                  width: cardWidth,
                  icon: Icons.done_all_rounded,
                  label: 'Complete Service',
                  onTap: onComplete,
                  isLoading: activeAction == 'complete',
                  isDisabled: isAnyLoading,
                  iconColor: AppColors.primary,
                ));
              }

              return Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: actions,
              );
            },
          ),
      ],
    );
  }

  Widget _buildStatusMessageCard(
    BuildContext context, {
    required Color color,
    required Color borderColor,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28.0),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatefulWidget {
  final double width;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isLoading;
  final bool isDisabled;
  final Color iconColor;
  final bool isError;

  const _ActionCard({
    required this.width,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isLoading,
    required this.isDisabled,
    required this.iconColor,
    this.isError = false,
  });

  @override
  State<_ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<_ActionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final activeBg = widget.isError
        ? AppColors.error.withOpacity(0.12)
        : AppColors.primary.withOpacity(0.08);

    final showDisabled = widget.isDisabled || widget.isLoading;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = !showDisabled),
      onExit: (_) => setState(() => _isHovered = false),
      child: Opacity(
        opacity: showDisabled ? 0.6 : 1.0,
        child: Container(
          width: widget.width,
          height: 112.0,
          decoration: BoxDecoration(
            color: _isHovered ? activeBg : Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: widget.isError
                  ? AppColors.error.withOpacity(0.3)
                  : AppColors.outlineVariant.withOpacity(0.2),
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
              onTap: showDisabled ? null : widget.onTap,
              borderRadius: BorderRadius.circular(24.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isLoading)
                      SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(widget.iconColor),
                        ),
                      )
                    else
                      Icon(
                        widget.icon,
                        color: widget.iconColor,
                        size: 32.0,
                      ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: widget.isError ? AppColors.error : AppColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
