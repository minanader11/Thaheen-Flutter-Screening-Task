import 'package:flutter/material.dart';

class ColorManager {
  // Defines color constants for the app
  // Example : static const Color primaryColor = Color(0xFF3F51B5);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color purple = Colors.purple;
  static const Color green = Color(0xff20810A);
  static const Color yellow = Color.fromARGB(255, 224, 204, 25);
  static const Color red = Color.fromARGB(255, 173, 31, 21);
  static const Color mainAppColor = Color(0xFF8A1538);
  static const Color statusBarColor = Color(0xFF4B0618);
  static const Color secondaryBackground = Color(0xFFFCF9FA);
  static const Color errorFill = Color(0xFFFFFBE6);
  static const Color errorBorder = Color(0xFFAD6800);
  static const Color borderColor = Color(0xFFD3BBC2);
  static const Color greenColorForText = Color(0xFF237804);
  static const Color green135200 = Color(0xff135200);
  static const Color warningColor = Color(0xff874D00);
  static const Color onboardingDotInactive = Color(0xFFD3BBC2);

  static const Color primary   = Color(0xFF5BA3D0);
  static const Color secondary = Color(0xFFFFA726);
  static const Color tertiary  = Color(0xFF6CBF56);
  static const Color neutral   = Color(0xFF0F172A);

  // ── Task type colors ──────────────────────────────────────
  static const Color dailyTask   = primary;
  static const Color bonusTask   = secondary;
  static const Color flashTask   = tertiary;

  // ── Scoreboard ────────────────────────────────────────────
  static const Color cardBg         = Color(0xFF1E293B);
  static const Color cardBorder     = Color(0xFF334155);
  static const Color firstPlaceGlow = secondary;
  static const Color scoreBoardBg   = neutral;

  // ── Text ──────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textDark      = neutral;

  // ── UI ────────────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color error   = Color(0xFFEF4444);
  static const Color warning = secondary;
  static const Color divider = Color(0xFF1E293B);
  static const Color surface = Color(0xFF1E293B);
  static const Color background = neutral;
}
