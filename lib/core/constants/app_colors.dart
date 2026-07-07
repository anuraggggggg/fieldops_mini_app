// lib/utils/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryDark = Color(0xFF1557B0);
  static const Color primaryLight = Color(0xFFE8F0FE);
  static const Color primaryGradientStart = Color(0xFF1A73E8);
  static const Color primaryGradientEnd = Color(0xFF0D47A1);

  // Secondary Colors
  static const Color secondary = Color(0xFF34A853);
  static const Color secondaryLight = Color(0xFFE6F4EA);

  // Accent Colors
  static const Color accent = Color(0xFFEA4335);
  static const Color accentLight = Color(0xFFFCE8E6);

  // Status Colors
  static const Color statusAssigned = Color(0xFFFF8F00);
  static const Color statusAssignedLight = Color(0xFFFFF3E0);
  static const Color statusInProgress = Color(0xFF7B1FA2);
  static const Color statusInProgressLight = Color(0xFFF3E5F5);
  static const Color statusCompleted = Color(0xFF34A853);
  static const Color statusCompletedLight = Color(0xFFE6F4EA);
  static const Color statusPending = Color(0xFFFBBC04);
  static const Color statusPendingLight = Color(0xFFFFFDE7);

  // Priority Colors
  static const Color priorityHigh = Color(0xFFEA4335);
  static const Color priorityHighLight = Color(0xFFFCE8E6);
  static const Color priorityMedium = Color(0xFFFBBC04);
  static const Color priorityMediumLight = Color(0xFFFFFDE7);
  static const Color priorityLow = Color(0xFF34A853);
  static const Color priorityLowLight = Color(0xFFE6F4EA);

  // Neutral Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFFF8F9FA);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textLight = Color(0xFFFFFFFF);

  // Border & Divider
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF0F0F0);

  // Shadow
  static const Color shadow = Color(0x1A000000);
  static const Color shadowDark = Color(0x33000000);

  // Error & Warning
  static const Color error = Color(0xFFEA4335);
  static const Color errorLight = Color(0xFFFCE8E6);
  static const Color warning = Color(0xFFFBBC04);
  static const Color warningLight = Color(0xFFFFFDE7);
  static const Color success = Color(0xFF34A853);
  static const Color successLight = Color(0xFFE6F4EA);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryGradientStart,
      primaryGradientEnd,
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF8F9FA),
    ],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF34A853),
      Color(0xFF2E7D32),
    ],
  );

  static const LinearGradient warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF8F00),
      Color(0xFFE65100),
    ],
  );

  static const LinearGradient infoGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1A73E8),
      Color(0xFF0D47A1),
    ],
  );

  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7B1FA2),
      Color(0xFF4A148C),
    ],
  );
}