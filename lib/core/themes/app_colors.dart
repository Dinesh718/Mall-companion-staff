import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6100D6);
  static const Color primaryGradientStart = Color(0xFF7B2FF7);
  static const Color primaryGradientEnd = Color(0xFF3B82F6);
  static const Color darkBlue = Color(0xFF0058BE);

  // Status & Semantic Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);

  // Neutral Colors
  static const Color background = Color(0xFFF8F9FF);
  static const Color textNavy = Color(0xFF121C2A);
  static const Color textGray = Color(0xFF6B7280);
  static const Color borderViolet = Color(0xFFCCC3D9);
  static const Color cardBackground = Colors.white;
  static const Color secondary = Color(0xFF6B4DA9);

  // Stitch Design Specific Colors
  static const Color stitchBackground = Color(0xFFFEF7FF);
  static const Color surfaceContainer = Color(0xFFF3EBFA);
  static const Color surface = Color(0xFFFEF7FF);
  static const Color onSurface = Color(0xFF1D1A25);
  static const Color onSurfaceVariant = Color(0xFF4A4456);
  static const Color outline = Color(0xFF7B7488);
  static const Color inverseSurface = Color(0xFF322F39);
  static const Color inverseOnSurface = Color(0xFFF5EEFB);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color tertiaryFixed = Color(0xFFFFDCBB);
  static const Color onTertiaryFixed = Color(0xFF2C1700);
  static const Color outlineVariant = Color(0xFFCBC3D7);
  static const Color primaryContainer = Color(0xFF8455EF);
  static const Color onPrimaryContainer = Color(0xFFFFFBFF);
  static const Color primaryFixed = Color(0xFFE9DDFF);
  static const Color onPrimaryFixed = Color(0xFF23005C);
  static const Color secondaryFixed = Color(0xFFD8E2FF);
  static const Color secondaryFixedDim = Color(0xFFADC6FF);
  static const Color onSecondaryFixed = Color(0xFF001A42);
  static const Color onSecondaryFixedVariant = Color(0xFF004395);
  static const Color surfaceContainerHighest = Color(0xFFE0E3E5);
  static const Color surfaceBright = Color(0xFFF7F9FB);
  static const Color surfaceContainerLow = Color(0xFFF2F4F6);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);
  static const Color surfaceVariant = Color(0xFFE7E0ED);
  static const Color surfaceContainerHigh = Color(0xFFEDE5F3);
  static const Color tertiary = Color(0xFF855000);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFA76500);
  static const Color onTertiaryContainer = Color(0xFFFFFBFF);
  static const Color onTertiaryFixedVariant = Color(0xFF673D00);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF2170E4);
  static const Color onSecondaryContainer = Color(0xFFFEFCFF);
  static const Color primaryFixedDim = Color(0xFFD0BCFF);

  // Gradients
  static const List<Color> primaryGradient = [
    primaryGradientStart,
    primaryGradientEnd,
  ];

  static const List<Color> subtlePurpleGradient = [
    Color(0x00F8F9FF),
    Color(0x0D6100D6), // 5% purple tint
    Color(0xFFF8F9FF),
  ];

  static const List<Color> ticketHeroGradient = [
    Color(0xFF6B38D4),
    Color(0xFF0058BE),
  ];

  static const Color secondaryTicketColor = Color(0xFF0058BE);
}
