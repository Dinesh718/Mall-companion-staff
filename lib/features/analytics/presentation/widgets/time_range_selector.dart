import 'package:flutter/material.dart';

class TimeRangeSelector extends StatelessWidget {
  final String activeRange;
  final ValueChanged<String> onRangeSelected;

  const TimeRangeSelector({
    super.key,
    required this.activeRange,
    required this.onRangeSelected,
  });

  static const List<String> ranges = ['Today', 'Week', 'Month', 'Quarter', 'Year'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        children: ranges.map((range) {
          final isActive = range == activeRange;
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () => onRangeSelected(range),
              borderRadius: BorderRadius.circular(99.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                decoration: BoxDecoration(
                  gradient: isActive
                      ? const LinearGradient(
                          colors: [Color(0xFF7C3AED), Color(0xFF316BF3)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isActive ? null : const Color(0xFFE6E8EA), // surface-container-high
                  borderRadius: BorderRadius.circular(99.0),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  range.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.05,
                    color: isActive ? Colors.white : const Color(0xFF4A4455), // on-surface-variant
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
