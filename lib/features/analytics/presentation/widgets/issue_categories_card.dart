import 'package:flutter/material.dart';
import '../../domain/entities/issue_category_entity.dart';
import '../../../../core/presentation/widgets/charts/category_pie_chart.dart';
import '../../../../core/themes/app_colors.dart';

class IssueCategoriesCard extends StatelessWidget {
  final List<IssueCategoryEntity> categories;

  const IssueCategoriesCard({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final totalTickets = categories.fold(0, (sum, item) => sum + item.count);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.08),
            blurRadius: 20.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Issue Categories',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              CategoryPieChart(
                data: categories.map((c) => PieChartData(
                  value: c.count.toDouble(),
                  color: Color(int.parse('0xFF${c.colorHex}')),
                  label: c.name,
                )).toList(),
                strokeWidth: 16.0,
                centerWidget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      totalTickets.toString(),
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF630ED4), // primary
                      ),
                    ),
                    const Text(
                      'TOTAL TICKETS',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 8.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.outline,
                        letterSpacing: 0.05,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32.0),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return Row(
                      children: [
                        Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            color: Color(int.parse('0xFF${cat.colorHex}')),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            cat.name,
                            style: const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12.0,
                              color: Color(0xFF4A4455), // on-surface-variant
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
