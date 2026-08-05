import 'package:flutter/material.dart';

class WeeklyActivityData {
  final String label;
  final double value;
  final bool isHighlight;

  WeeklyActivityData({
    required this.label,
    required this.value,
    this.isHighlight = false,
  });
}

class WeeklyActivityBarChart extends StatelessWidget {
  final List<WeeklyActivityData> data;
  final double height;
  final Color baseColor;
  final List<Color> highlightGradient;

  const WeeklyActivityBarChart({
    super.key,
    required this.data,
    this.height = 100.0,
    required this.baseColor,
    required this.highlightGradient,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return SizedBox(height: height);

    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((item) {
          final barHeight = maxValue > 0 ? (item.value / maxValue) * (height - 40) : 0.0;
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  item.value.toInt().toString(),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10.0,
                    fontWeight: item.isHighlight ? FontWeight.bold : FontWeight.normal,
                    color: item.isHighlight ? highlightGradient.first : const Color(0xFF7B7488),
                  ),
                ),
                const SizedBox(height: 4.0),
                Container(
                  width: double.infinity,
                  height: barHeight > 0 ? barHeight : 4.0, // Minimum height
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: item.isHighlight ? null : baseColor,
                    gradient: item.isHighlight
                        ? LinearGradient(
                            colors: highlightGradient,
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        : null,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100.0),
                      topRight: Radius.circular(100.0),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  item.label,
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.05,
                    color: item.isHighlight ? const Color(0xFF191C1E) : const Color(0xFF7B7488),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
