import 'package:flutter/material.dart';
import '../../domain/entities/profile_entity.dart';
import '../../../../core/themes/app_colors.dart';

class SkillsCertificationsCard extends StatelessWidget {
  final ProfileEntity profile;

  const SkillsCertificationsCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(37, 99, 235, 0.08),
            blurRadius: 15.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skills & Certifications',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            'Certified Skills: ${profile.certifiedSkills.length}',
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A4455),
            ),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: profile.certifiedSkills.map((skill) {
              final isSecondary = skill.toLowerCase() == 'first aid';
              final color = isSecondary ? AppColors.secondary : AppColors.primary;
              final bgColor = isSecondary ? AppColors.secondaryFixed : AppColors.primaryFixed;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(9999.0),
                  border: Border.all(color: color.withAlpha(25)),
                ),
                child: Text(
                  skill,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
