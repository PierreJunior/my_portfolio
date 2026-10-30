import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:my_portfolio/models/data.dart';
import 'package:my_portfolio/services/content_overrides.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/widgets/common.dart';
import 'package:url_launcher/link.dart';

/// Sections the nav bar can scroll to.
enum HomeSection { work, experience, stack, contact }

String _sectionLabel(HomeSection section) => switch (section) {
      HomeSection.work => LocaleKeys.nav_work.tr(),
      HomeSection.experience => LocaleKeys.nav_experience.tr(),
      HomeSection.stack => LocaleKeys.nav_stack.tr(),
      HomeSection.contact => LocaleKeys.nav_contact.tr(),
    };

String cvUrlFor(BuildContext context) =>
    contentOverrides.value.cvUrl ??
    DeveloperProfile.getCvUrl(context.locale.languageCode);

/// "pierre.kahozi" word mark. Links home.
class WordMark extends StatelessWidget {
  final double size;

  const WordMark({super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: DeveloperProfile.name,
      excludeSemantics: true,
      child: Text.rich(
        TextSpan(children: [
          const TextSpan(text: 'pierre'),
          TextSpan(text: '.kahozi', style: TextStyle(color: AppColors.accentSoft)),
        ]),
        style: AppFonts.display(size: size, weight: FontWeight.w700, color: AppColors.onDeep, height: 1.2),
      ),
    );
  }
}

/// Dark top bar: word mark, section links, EN/FR switch. On phones the
/// links move into the end drawer behind a menu button.
class NavBar extends StatelessWidget {
  final ValueChanged<HomeSection>? onNavigate;
  final Widget? trailing;

  const NavBar({super.key, this.onNavigate, this.trailing});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: PageWidth(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Link(
                    uri: Uri.parse('/'),
                    builder: (context, followLink) => InkWell(
                      onTap: followLink,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: WordMark(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            if (trailing != null)
              trailing!
            else if (mobile) ...[
              const LanguageToggle(compact: true),
              const SizedBox(width: 8),
              Builder(
                builder: (context) => IconButton(
                  tooltip: LocaleKeys.nav_menu.tr(),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  style: IconButton.styleFrom(
                    minimumSize: const Size(44, 44),
                    side: const BorderSide(color: AppColors.deepOutline),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.menu, color: AppColors.onDeep),
                ),
              ),
            ] else ...[
              for (final section in HomeSection.values)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: TextButton(
                    onPressed: () => onNavigate?.call(section),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.onDeepNav,
                      minimumSize: const Size(44, 44),
                    ),
                    child: Text(_sectionLabel(section), style: AppFonts.body(size: 15, color: AppColors.onDeepNav)),
                  ),
                ),
              const SizedBox(width: 4),
              const LanguageToggle(),
            ],
          ],
        ),
      ),
    );
  }
}

/// EN | FR switch. Each language is its own button with a pressed state,
/// so screen readers announce which one is active.
class LanguageToggle extends StatelessWidget {
  final bool compact;

  const LanguageToggle({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final current = context.locale.languageCode;
    return Semantics(
      label: LocaleKeys.nav_language.tr(),
      container: true,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.deepOutline),
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final code in const ['en', 'fr'])
              if (!compact || code != current)
                Semantics(
                  button: true,
                  selected: code == current,
                  child: InkWell(
                    onTap: () => context.setLocale(Locale(code)),
                    child: Container(
                      constraints: const BoxConstraints(minWidth: 44, minHeight: 40),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      color: code == current ? AppColors.onDeep : Colors.transparent,
                      child: Text(
                        code.toUpperCase(),
                        style: AppFonts.mono(
                          color: code == current ? AppColors.ink : AppColors.onDeepNav,
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

/// Phone navigation drawer.
class NavDrawer extends StatelessWidget {
  final ValueChanged<HomeSection> onNavigate;

  const NavDrawer({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.deep,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const WordMark(),
            const SizedBox(height: 24),
            for (final section in HomeSection.values)
              ListTile(
                minTileHeight: 52,
                title: Text(_sectionLabel(section), style: AppFonts.body(size: 18, color: AppColors.onDeep)),
                onTap: () {
                  Navigator.of(context).pop();
                  onNavigate(section);
                },
              ),
            const SizedBox(height: 24),
            const Align(alignment: Alignment.centerLeft, child: LanguageToggle()),
          ],
        ),
      ),
    );
  }
}

/// Dark hero: headline, intro, calls to action, portrait and status card.
class HeroSection extends StatelessWidget {
  final VoidCallback onSeeWork;

  const HeroSection({super.key, required this.onSeeWork});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    return ValueListenableBuilder<ContentOverrides>(
      valueListenable: contentOverrides,
      builder: (context, overrides, _) {
        final copy = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.hero_eyebrow.tr(),
              style: AppFonts.mono(size: mobile ? 12 : 14, color: AppColors.accentSoft, letterSpacing: 0.5),
            ),
            const SizedBox(height: 24),
            Semantics(
              header: true,
              child: Text(
                overrides.heroTitle ?? LocaleKeys.hero_title.tr(),
                style: AppFonts.display(
                  size: mobile ? 38 : 64,
                  color: AppColors.onDeep,
                  height: mobile ? 1.08 : 1.04,
                  letterSpacing: -0.03,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                overrides.heroSubtitle ?? LocaleKeys.hero_subtitle.tr(),
                style: AppFonts.body(size: mobile ? 16 : 19, color: AppColors.onDeepBody),
              ),
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 14,
              runSpacing: 10,
              children: [
                SizedBox(
                  width: mobile ? double.infinity : null,
                  child: TextButton(
                    onPressed: onSeeWork,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.accentBright,
                      foregroundColor: AppColors.deep,
                      minimumSize: const Size(48, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      LocaleKeys.hero_cta_work.tr(),
                      style: AppFonts.body(weight: FontWeight.w600, color: AppColors.deep, height: 1.2),
                    ),
                  ),
                ),
                AppLinkButton(
                  label: LocaleKeys.hero_cta_cv.tr(),
                  uri: Uri.parse(cvUrlFor(context)),
                  style: AppButtonStyle.outlineOnDark,
                  newTab: true,
                  expand: mobile,
                ),
              ],
            ),
          ],
        );

        if (mobile) {
          return PageWidth(
            padding: const EdgeInsets.only(top: 24, bottom: 96),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/profile.jpg',
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                    cacheWidth: 264,
                    semanticLabel: LocaleKeys.hero_portrait_alt.tr(),
                  ),
                ),
                const SizedBox(height: 20),
                copy,
              ],
            ),
          );
        }

        return PageWidth(
          padding: const EdgeInsets.only(top: 56, bottom: 140),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: copy),
              const SizedBox(width: 56),
              SizedBox(
                width: 340,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Screenshot(
                      asset: 'assets/profile.jpg',
                      semanticLabel: LocaleKeys.hero_portrait_alt.tr(),
                      height: 425,
                      decodeWidth: 680,
                      alignment: Alignment.center,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.deepCard,
                        border: Border.all(color: AppColors.deepBorder),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('● ${LocaleKeys.hero_status_label.tr()}',
                              style: AppFonts.mono(size: 12, color: AppColors.accentSoft)),
                          const SizedBox(height: 6),
                          Text(LocaleKeys.hero_status_text.tr(),
                              style: AppFonts.body(size: 15, color: const Color(0xFFE4ECEB), height: 1.5)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
