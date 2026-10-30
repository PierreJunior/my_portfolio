import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colour tokens from the approved dark-teal design.
class AppColors {
  static const ink = Color(0xFF10131A);
  static const ground = Color(0xFFF5F7F7);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFD8E0DF);
  static const borderStrong = Color(0xFFC2CFCD);
  static const tint = Color(0xFFE6F2F0);

  static const textBody = Color(0xFF364443);
  static const textMuted = Color(0xFF475756);

  /// Dark teal used by the header, footer and diagrams.
  static const deep = Color(0xFF0B3B3C);
  static const deepCard = Color(0xFF124B4C);
  static const deepBorder = Color(0xFF1F6263);
  static const deepOutline = Color(0xFF2F7373);
  static const deepButtonBorder = Color(0xFF3F8584);
  static const onDeep = Color(0xFFFFFFFF);
  static const onDeepBody = Color(0xFFBFCDCB);
  static const onDeepMuted = Color(0xFF9DB0AE);
  static const onDeepNav = Color(0xFFD3DEDC);

  /// Accents: [accent] on light grounds, [accentBright] for buttons on dark,
  /// [accentSoft] for small text on dark.
  static const accent = Color(0xFF115E59);
  static const accentHover = Color(0xFF0B4A46);
  static const accentBright = Color(0xFF14B8A6);
  static const accentSoft = Color(0xFF5EEAD4);
  static const accentTimeline = Color(0xFF99D5CD);

  static const liveBg = Color(0xFFCCFBF1);
  static const retiredBg = Color(0xFFFBF0D2);
  static const retiredFg = Color(0xFF6B4E00);
  static const neutralBg = Color(0xFFE5EAEA);
  static const neutralFg = Color(0xFF364443);
}

/// Font families. Widget tests switch [useGoogleFonts] off so they never
/// try to download fonts.
class AppFonts {
  static bool useGoogleFonts = true;

  static TextStyle display({
    double size = 44,
    FontWeight weight = FontWeight.w600,
    Color? color,
    double height = 1.1,
    double letterSpacing = -0.02,
  }) {
    final style = TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing * size,
    );
    return useGoogleFonts ? GoogleFonts.spaceGrotesk(textStyle: style) : style;
  }

  static TextStyle body({
    double size = 16,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double height = 1.6,
  }) {
    final style = TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );
    return useGoogleFonts ? GoogleFonts.inter(textStyle: style) : style;
  }

  static TextStyle mono({
    double size = 13,
    FontWeight weight = FontWeight.w500,
    Color? color,
    double height = 1.5,
    double letterSpacing = 0,
  }) {
    final style = TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
    return useGoogleFonts ? GoogleFonts.jetBrainsMono(textStyle: style) : style;
  }
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      primary: AppColors.accent,
      surface: AppColors.ground,
    ),
    scaffoldBackgroundColor: AppColors.ground,
  );
  return base.copyWith(
    textTheme: AppFonts.useGoogleFonts
        ? GoogleFonts.interTextTheme(base.textTheme)
        : base.textTheme,
    focusColor: AppColors.accentSoft.withValues(alpha: 0.4),
  );
}

/// Width breakpoints shared by every section.
class Breakpoints {
  static const double mobile = 720;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;
}
