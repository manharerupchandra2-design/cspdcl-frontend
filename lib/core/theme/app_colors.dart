// lib/core/theme/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand ────────────────────────────────────────────────
  static const primary        = Color(0xFF0A2647); // Deep navy
  static const primaryLight   = Color(0xFF144272); // Medium navy
  static const primaryLighter = Color(0xFF205295); // Light navy
  static const accent         = Color(0xFFE7B10A); // Electric gold
  static const accentDark     = Color(0xFFB8860B); // Dark gold
  static const accentLight    = Color(0xFFFFF0A0); // Pale gold

  // ── Status ───────────────────────────────────────────────
  static const success        = Color(0xFF1B9C52);
  static const successLight   = Color(0xFFD6F5E3);
  static const warning        = Color(0xFFE78B10);
  static const warningLight   = Color(0xFFFEEDD6);
  static const error          = Color(0xFFD62828);
  static const errorLight     = Color(0xFFFFDEDE);
  static const info           = Color(0xFF1565C0);
  static const infoLight      = Color(0xFFDCEAFF);

  // ── Neutral ──────────────────────────────────────────────
  static const background     = Color(0xFFF4F6FA);
  static const surface        = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFEEF1F8);
  static const divider        = Color(0xFFE2E8F0);
  static const border         = Color(0xFFCDD5E0);
  static const shadow         = Color(0x1A0A2647);

  // ── Text ─────────────────────────────────────────────────
  static const textPrimary    = Color(0xFF0D1B2A);
  static const textSecondary  = Color(0xFF4A5568);
  static const textHint       = Color(0xFF9AA5B4);
  static const textDisabled   = Color(0xFFCBD2D9);
  static const textOnPrimary  = Color(0xFFFFFFFF);
  static const textOnAccent   = Color(0xFF0A2647);

  // ── Gradients ────────────────────────────────────────────
  static const gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight, primaryLighter],
  );

  static const gradientAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentDark, accent],
  );

  static const gradientCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF4F6FA)],
  );

  // Status badge colors
  static Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':   return warning;
      case 'reading_done': return info;
      case 'bill_generated': return success;
      default: return textHint;
    }
  }

  static Color statusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':   return warningLight;
      case 'reading_done': return infoLight;
      case 'bill_generated': return successLight;
      default: return surfaceVariant;
    }
  }
}
