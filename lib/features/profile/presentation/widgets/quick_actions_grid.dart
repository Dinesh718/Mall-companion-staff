import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import 'package:mall_companion_staff/features/analytics/presentation/pages/analytics_page.dart';
import 'package:mall_companion_staff/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:mall_companion_staff/features/analytics/presentation/bloc/analytics_event.dart';
import 'package:mall_companion_staff/features/analytics/domain/usecases/get_analytics_usecase.dart';
import 'package:mall_companion_staff/features/analytics/data/repositories/mock_analytics_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Quick Actions',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.5,
          children: [
            _buildActionBtn(
              icon: Icons.edit_square,
              label: 'Edit Profile',
              bgColor: AppColors.primary,
              textColor: Colors.white,
              onTap: () {
                // Placeholder
              },
            ),
            _buildActionBtn(
              icon: Icons.analytics,
              label: 'Analytics',
              bgColor: Colors.white,
              textColor: AppColors.secondary,
              borderColor: AppColors.secondaryFixed,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AnalyticsBloc(
                        getAnalyticsUseCase: GetAnalyticsUseCase(MockAnalyticsRepository()),
                      )..add(const LoadAnalyticsRequested()),
                      child: const AnalyticsPage(),
                    ),
                  ),
                );
              },
            ),
            _buildActionBtn(
              icon: Icons.support_agent,
              label: 'Manager',
              bgColor: Colors.white,
              textColor: AppColors.primary,
              borderColor: AppColors.primaryFixed,
              onTap: () {
                // Placeholder
              },
            ),
            _buildActionBtn(
              icon: Icons.download,
              label: 'Download ID',
              bgColor: AppColors.secondary,
              textColor: Colors.white,
              onTap: () {
                // Placeholder
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionBtn({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: borderColor != null ? BorderSide(color: borderColor, width: 2.0) : BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20.0),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
