import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class SettingsSectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color? backgroundColor;
  final BoxBorder? border;

  const SettingsSectionCard({
    super.key,
    required this.title,
    required this.children,
    this.backgroundColor = AppColors.cardBackground,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28.0),
        border: border,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withAlpha(20),
            blurRadius: 15.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 16.0),
          ...children,
        ],
      ),
    );
  }
}

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 16.0,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.surfaceVariant,
          ),
        ],
      ),
    );
  }
}

class SettingsNavigationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SettingsNavigationTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(width: 16.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: AppColors.outline),
          ],
        ),
      ),
    );
  }
}

class SettingsValueTile extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final Widget? customValueWidget;

  const SettingsValueTile({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.customValueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14.0,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          customValueWidget ??
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? AppColors.onSurface,
                ),
                textAlign: TextAlign.right,
              ),
        ],
      ),
    );
  }
}

class SettingsSectionSubHeader extends StatelessWidget {
  final String title;

  const SettingsSectionSubHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'Work Sans',
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
