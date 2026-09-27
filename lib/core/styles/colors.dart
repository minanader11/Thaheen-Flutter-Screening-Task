import 'package:flutter/material.dart';

class ColorManager {
  // ── Brand ─────────────────────────────────────────────────
  static const Color primary      = Color(0xFF2395F8); // accent / CTA
  static const Color primaryDark  = Color(0xFF1C77C6); // hover/pressed, gradient end
  static const Color primaryGradientStart = Color(0xFF2AA7FF);
  static const Color primaryGradientEnd   = Color(0xFF0957DE);

  // ── Surfaces ──────────────────────────────────────────────
  static const Color background   = Color(0xFFF8F8FF); // app scaffold bg
  static const Color surface      = Colors.white;       // cards
  static const Color surfaceElevated = Color(0xFFEBEBEB);
  static const Color cardBorder   = Color(0xFFF0F0F0);
  static const Color borderColor  = Color(0xFF3A3A3A);

  // ── Text ──────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF000000);
  static const Color textMuted     = Color(0xFF8A8A8A);
  static const Color textOnPrimary = Colors.white;

  // ── Semantic (converted from Thaheen's toast tokens) ──────
  static const Color success = Color(0xFF37A471); // hsl(152 50% 43%)
  static const Color warning = Color(0xFFFFC65C); // hsl(39 100% 68%)
  static const Color error   = Color(0xFFC13D2F); // hsl(6 61% 47%)
  static const Color info    = Color(0xFF3182ED); // hsl(214 84% 56%)

  // ── Lesson / progress status (LMS-specific) ───────────────
  static const Color statusNotStarted = textMuted;
  static const Color statusInProgress = warning;
  static const Color statusCompleted  = success;
  static const Color statusLocked     = Color(0xFFB0B0B0);

  // ── Misc ──────────────────────────────────────────────────
  static const Color divider = surfaceElevated;
  static const Color black   = Colors.black;
  static const Color white   = Colors.white;

  // ── Compatibility aliases ─────────────────────────────────
  static const Color textSecondary       = textMuted;
  static const Color mainAppColor        = primary;
  static const Color secondary           = warning;
  static const Color red                 = error;
  static const Color green               = success;
  static const Color yellow              = warning;
  static const Color purple              = info;
  static const Color errorBorder         = error;
  static const Color secondaryBackground = background;
}
