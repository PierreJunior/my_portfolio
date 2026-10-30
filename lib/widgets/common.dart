import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:my_portfolio/models/data.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:url_launcher/link.dart';

/// Centres [child] in the 1200 px content column with the page gutter.
class PageWidth extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const PageWidth({super.key, required this.child, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    final gutter = Breakpoints.isMobile(context) ? 20.0 : 32.0;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1200 + gutter * 2),
        child: Padding(
          padding: padding.add(EdgeInsets.symmetric(horizontal: gutter)),
          child: child,
        ),
      ),
    );
  }
}

/// "01 / SELECTED WORK" label above a section title.
class SectionHeading extends StatelessWidget {
  final String label;
  final String title;
  final bool onDark;

  const SectionHeading({
    super.key,
    required this.label,
    required this.title,
    this.onDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.mono(
            color: onDark ? AppColors.accentSoft : AppColors.accent,
          ),
        ),
        const SizedBox(height: 12),
        Semantics(
          header: true,
          child: Text(
            title,
            style: AppFonts.display(
              size: mobile ? 32 : 44,
              color: onDark ? AppColors.onDeep : AppColors.ink,
            ),
          ),
        ),
      ],
    );
  }
}

enum AppButtonStyle { primary, brightOnDark, outlineOnDark, outline }

/// A link styled as a button. Built on [Link] so the web build renders a
/// real anchor: it can be opened in a new tab, and crawlers can follow it.
class AppLinkButton extends StatelessWidget {
  final String label;
  final Uri uri;
  final AppButtonStyle style;
  final bool newTab;
  final bool expand;

  const AppLinkButton({
    super.key,
    required this.label,
    required this.uri,
    this.style = AppButtonStyle.primary,
    this.newTab = false,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg, Color? border) = switch (style) {
      AppButtonStyle.primary => (AppColors.accent, AppColors.onDeep, null),
      AppButtonStyle.brightOnDark => (AppColors.accentBright, AppColors.deep, null),
      AppButtonStyle.outlineOnDark => (Colors.transparent, AppColors.onDeep, AppColors.deepButtonBorder),
      AppButtonStyle.outline => (Colors.transparent, AppColors.ink, AppColors.borderStrong),
    };
    return Link(
      uri: uri,
      target: newTab ? LinkTarget.blank : LinkTarget.self,
      builder: (context, followLink) => SizedBox(
        width: expand ? double.infinity : null,
        child: TextButton(
          onPressed: followLink,
          style: TextButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: border == null ? BorderSide.none : BorderSide(color: border),
            ),
          ),
          child: Text(label, style: AppFonts.body(weight: FontWeight.w600, color: fg, height: 1.2)),
        ),
      ),
    );
  }
}

/// An inline text link ("Read case study →").
class AppTextLink extends StatelessWidget {
  final String label;
  final Uri uri;
  final bool newTab;
  final Color color;

  const AppTextLink({
    super.key,
    required this.label,
    required this.uri,
    this.newTab = false,
    this.color = AppColors.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: uri,
      target: newTab ? LinkTarget.blank : LinkTarget.self,
      builder: (context, followLink) => TextButton(
        onPressed: followLink,
        style: TextButton.styleFrom(
          foregroundColor: color,
          minimumSize: const Size(44, 44),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.padded,
          alignment: Alignment.centerLeft,
        ),
        child: Text(label, style: AppFonts.body(weight: FontWeight.w600, color: color, height: 1.2)),
      ),
    );
  }
}

/// Small rounded label: "● LIVE", "DELIVERED FOR AKROTECH · RETIRED".
class Pill extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;

  const Pill({super.key, required this.text, required this.background, required this.foreground});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: AppFonts.mono(size: 12, color: foreground, height: 1.2)),
    );
  }
}

/// The status chips for a project, derived from [Project.status].
List<Widget> statusPills(Project project) {
  return switch (project.status) {
    ProjectStatus.live => [
        Pill(text: LocaleKeys.status_live.tr(), background: AppColors.liveBg, foreground: AppColors.accent),
        Pill(text: LocaleKeys.status_own.tr(), background: AppColors.neutralBg, foreground: AppColors.neutralFg),
      ],
    ProjectStatus.retired => [
        Pill(
          text: LocaleKeys.status_retired.tr(args: [(project.client ?? '').toUpperCase()]),
          background: AppColors.retiredBg,
          foreground: AppColors.retiredFg,
        ),
      ],
    ProjectStatus.learning => [
        Pill(text: LocaleKeys.status_learning.tr(), background: AppColors.neutralBg, foreground: AppColors.neutralFg),
      ],
  };
}

/// White rounded card used across sections.
class SurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? topAccent;

  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.radius = 14,
    this.topAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (topAccent != null) Container(height: 3, color: topAccent),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

/// Lays children out in equal columns that wrap, like CSS
/// `repeat(auto-fit, minmax(minWidth, 1fr))`. Rows size to their content.
///
/// Items in a row keep their own height. Stretching them with
/// IntrinsicHeight under-measured text on web and clipped card content.
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double minItemWidth;
  final double spacing;
  final int? maxColumns;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 220,
    this.spacing = 20,
    this.maxColumns,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var columns = ((constraints.maxWidth + spacing) / (minItemWidth + spacing)).floor();
      columns = columns.clamp(1, maxColumns ?? children.length.clamp(1, 99));
      final rows = <Widget>[];
      for (var i = 0; i < children.length; i += columns) {
        final rowItems = children.sublist(i, (i + columns).clamp(0, children.length));
        rows.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var j = 0; j < columns; j++) ...[
              if (j > 0) SizedBox(width: spacing),
              Expanded(child: j < rowItems.length ? rowItems[j] : const SizedBox.shrink()),
            ],
          ],
        ));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) SizedBox(height: spacing),
            rows[i],
          ],
        ],
      );
    });
  }
}

/// A bundled screenshot, decoded at roughly the size it is shown so large
/// PNGs don't cost full-resolution memory.
class Screenshot extends StatelessWidget {
  final String asset;
  final String semanticLabel;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final BorderRadius borderRadius;
  final int decodeWidth;

  const Screenshot({
    super.key,
    required this.asset,
    required this.semanticLabel,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.topCenter,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.decodeWidth = 1400,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        asset,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        cacheWidth: decodeWidth,
        semanticLabel: semanticLabel,
        errorBuilder: (context, error, stack) => Container(
          width: width,
          height: height,
          color: AppColors.tint,
        ),
      ),
    );
  }
}
