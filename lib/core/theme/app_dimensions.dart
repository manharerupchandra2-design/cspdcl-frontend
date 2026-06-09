// lib/core/theme/app_dimensions.dart

import 'package:flutter/material.dart';

class AppDimens {
  AppDimens._();

  // ── Spacing ──────────────────────────────────────────────
  static const s2 = 2.0;
  static const s4 = 4.0;
  static const s6 = 6.0;
  static const s8 = 8.0;
  static const s10 = 10.0;
  static const s12 = 12.0;
  static const s14 = 14.0;
  static const s16 = 16.0;
  static const s20 = 20.0;
  static const s24 = 24.0;
  static const s28 = 28.0;
  static const s32 = 32.0;
  static const s40 = 40.0;
  static const s48 = 48.0;

  // ── Radius ───────────────────────────────────────────────
  static const r4 = 4.0;
  static const r6 = 6.0;
  static const r8 = 8.0;
  static const r10 = 10.0;
  static const r12 = 12.0;
  static const r16 = 16.0;
  static const r20 = 20.0;
  static const r24 = 24.0;
  static const r30 = 30.0;
  static const rFull = 100.0;

  // ── BorderRadius ─────────────────────────────────────────
  static final br4 = BorderRadius.circular(r4);
  static final br6 = BorderRadius.circular(r6);
  static final br8 = BorderRadius.circular(r8);
  static final br10 = BorderRadius.circular(r10);
  static final br12 = BorderRadius.circular(r12);
  static final br16 = BorderRadius.circular(r16);
  static final br20 = BorderRadius.circular(r20);
  static final br24 = BorderRadius.circular(r24);
  static final brFull = BorderRadius.circular(rFull);

  // ── Button ───────────────────────────────────────────────
  static const buttonHeight = 52.0;
  static const buttonHeightSm = 42.0;
  static const buttonHeightLg = 58.0;

  // ── AppBar ───────────────────────────────────────────────
  static const appBarHeight = 60.0;

  // ── Card ─────────────────────────────────────────────────
  static const cardPadding = EdgeInsets.all(16.0);
  static const cardPaddingSm = EdgeInsets.all(12.0);

  // ── Page ─────────────────────────────────────────────────
  static const pagePadding = EdgeInsets.all(16.0);
  static const pageHPadding = EdgeInsets.symmetric(horizontal: 16.0);

  // ── Icon ─────────────────────────────────────────────────
  static const iconSm = 18.0;
  static const iconMd = 22.0;
  static const iconLg = 28.0;
  static const iconXl = 36.0;
  static const iconXxl = 48.0;

  // ── Avatar ───────────────────────────────────────────────
  static const avatarSm = 32.0;
  static const avatarMd = 44.0;
  static const avatarLg = 56.0;
}

// ── Gaps (widget shortcuts) ───────────────────────────────────
class Gap {
  static const h2 = SizedBox(height: 2);
  static const h3 = SizedBox(height: 3);
  static const h4 = SizedBox(height: 4);
  static const h6 = SizedBox(height: 6);
  static const h8 = SizedBox(height: 8);
  static const h10 = SizedBox(height: 10);
  static const h12 = SizedBox(height: 12);
  static const h16 = SizedBox(height: 16);
  static const h20 = SizedBox(height: 20);
  static const h24 = SizedBox(height: 24);
  static const h28 = SizedBox(height: 28);
  static const h32 = SizedBox(height: 32);
  static const h40 = SizedBox(height: 40);
  static const h48 = SizedBox(height: 48);

  static const w4 = SizedBox(width: 4);
  static const w6 = SizedBox(width: 6);
  static const w8 = SizedBox(width: 8);
  static const w10 = SizedBox(width: 10);
  static const w12 = SizedBox(width: 12);
  static const w14 = SizedBox(width: 14);
  static const w16 = SizedBox(width: 16);
  static const w20 = SizedBox(width: 20);
}
