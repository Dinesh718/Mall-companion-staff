import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/emergency_action_entity.dart';

class PrimaryActionCard extends StatelessWidget {
  final EmergencyActionEntity action;
  final VoidCallback onTap;

  const PrimaryActionCard({
    super.key,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color onBgColor;
    Color iconBgColor;
    Color iconColor;

    if (action.isDestructive) {
      bgColor = AppColors.errorContainer;
      onBgColor = AppColors.onErrorContainer;
      iconBgColor = AppColors.error;
      iconColor = AppColors.onError;
    } else {
      switch (action.title) {
        case 'Fire Exit':
          bgColor = AppColors.tertiaryFixed;
          onBgColor = AppColors.onTertiaryFixed;
          iconBgColor = AppColors.tertiaryContainer;
          iconColor = AppColors.onTertiaryContainer;
          break;
        case 'First Aid':
          bgColor = AppColors.secondaryFixed;
          onBgColor = AppColors.onSecondaryFixed;
          iconBgColor = AppColors.secondaryContainer;
          iconColor = AppColors.onSecondaryContainer;
          break;
        case 'Security Assistance':
        default:
          bgColor = AppColors.primaryFixed;
          onBgColor = AppColors.onPrimaryFixed;
          iconBgColor = AppColors.primaryContainer;
          iconColor = AppColors.onPrimaryContainer;
          break;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
        border: action.isDestructive ? Border.all(color: AppColors.error, width: 2.0) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getIconData(action.iconName),
                      color: iconColor,
                      size: 28.0,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    action.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20.0, // title-lg-mobile approximation
                      fontWeight: FontWeight.bold,
                      color: onBgColor,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    action.subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.0, // label-md
                      fontWeight: FontWeight.w500,
                      color: onBgColor.withAlpha(230),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'sos':
        return Icons.sos_rounded;
      case 'directions_run':
        return Icons.directions_run_rounded;
      case 'medical_services':
        return Icons.medical_services_rounded;
      case 'local_police':
        return Icons.local_police_rounded;
      default:
        return Icons.error_outline;
    }
  }
}
