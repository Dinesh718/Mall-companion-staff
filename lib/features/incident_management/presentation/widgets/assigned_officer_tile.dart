import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/assigned_officer_entity.dart';

class AssignedOfficerTile extends StatelessWidget {
  final AssignedOfficerEntity officer;

  const AssignedOfficerTile({
    super.key,
    required this.officer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAvatar(),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              officer.name,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0, // label-md
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: _getStatusColor(officer.status),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4.0),
                Text(
                  officer.status.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    if (officer.avatarUrl.isNotEmpty) {
      return Container(
        width: 32.0,
        height: 32.0,
        padding: const EdgeInsets.all(1.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6B38D4),
              AppColors.secondaryContainer,
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            officer.avatarUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
          ),
        ),
      );
    }
    return _buildFallbackAvatar();
  }

  Widget _buildFallbackAvatar() {
    return Container(
      width: 32.0,
      height: 32.0,
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person_outline,
        size: 16.0,
        color: AppColors.onSurfaceVariant,
      ),
    );
  }

  Color _getStatusColor(String status) {
    final lower = status.toLowerCase();
    if (lower.contains('responding')) {
      return Colors.amber[500]!;
    } else if (lower.contains('on site') || lower.contains('resolved')) {
      return Colors.green[500]!;
    }
    return AppColors.primary;
  }
}
