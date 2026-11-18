import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:my_portfolio/models/data.dart';
import 'package:my_portfolio/pages/case_study_page.dart';
import 'package:my_portfolio/sections/header_section.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/widgets/common.dart';

/// Step-by-step guide for joining a project's Google Play closed test.
///
/// Joining takes three sites (Google Groups, the Play opt-in page, the store
/// listing) and none of them points to the next one. This page is the
/// checklist: every step opens in a new tab, so visitors come back here.
class BetaPage extends StatelessWidget {
  final String slug;

  const BetaPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    // Rebuild on language change; `.tr()` alone doesn't register one.
    context.locale;
    final project = projectBySlug(slug);
    if (project == null || !project.hasBeta) return const CaseStudyPage(slug: '');

    final mobile = Breakpoints.isMobile(context);
    final title = project.titleKey.tr();
    final steps = [
      (
        title: LocaleKeys.beta_s1_title.tr(),
        body: LocaleKeys.beta_s1_body.tr(),
        button: LocaleKeys.beta_s1_button.tr(),
        url: project.testersGroupUrl!,
      ),
      (
        title: LocaleKeys.beta_s2_title.tr(),
        body: LocaleKeys.beta_s2_body.tr(),
        button: LocaleKeys.beta_s2_button.tr(),
        url: project.playTestingUrl!,
      ),
      (
        title: LocaleKeys.beta_s3_title.tr(),
        body: LocaleKeys.beta_s3_body.tr(args: [title]),
        button: LocaleKeys.beta_s3_button.tr(),
        url: project.playStoreUrl!,
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.deep,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    NavBar(
                      trailing: AppTextLink(
                        label: LocaleKeys.beta_back.tr(args: [title]),
                        uri: Uri.parse(project.route),
                        color: AppColors.onDeepNav,
                      ),
                    ),
                    PageWidth(
                      padding: EdgeInsets.only(top: mobile ? 24 : 56, bottom: mobile ? 48 : 64),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LocaleKeys.beta_label.tr(args: [title.toUpperCase()]),
                              style: AppFonts.mono(color: AppColors.accentSoft)),
                          const SizedBox(height: 20),
                          Semantics(
                            header: true,
                            child: Text(
                              LocaleKeys.beta_title.tr(args: [title]),
                              style: AppFonts.display(
                                  size: mobile ? 34 : 54, color: AppColors.onDeep, height: 1.05, letterSpacing: -0.03),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 720),
                            child: Text(
                              LocaleKeys.beta_intro.tr(args: [title]),
                              style: AppFonts.body(size: mobile ? 16 : 18, color: AppColors.onDeepBody, height: 1.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: mobile ? 32 : 48),
            PageWidth(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.tint,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          LocaleKeys.beta_account.tr(),
                          style: AppFonts.body(size: 15, color: AppColors.ink, weight: FontWeight.w600, height: 1.5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      for (final (i, step) in steps.indexed) ...[
                        _StepCard(
                          number: i + 1,
                          title: step.title,
                          body: step.body,
                          button: step.button,
                          uri: Uri.parse(step.url),
                        ),
                        const SizedBox(height: 16),
                      ],
                      if (project.liveUrl != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: AppTextLink(
                            label: LocaleKeys.beta_no_android.tr(),
                            uri: Uri.parse(project.liveUrl!),
                            newTab: true,
                          ),
                        ),
                      SizedBox(height: mobile ? 48 : 96),
                    ],
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

class _StepCard extends StatelessWidget {
  final int number;
  final String title;
  final String body;
  final String button;
  final Uri uri;

  const _StepCard({
    required this.number,
    required this.title,
    required this.body,
    required this.button,
    required this.uri,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final badge = Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
      child: Text('$number', style: AppFonts.body(weight: FontWeight.w700, color: AppColors.onDeep, height: 1)),
    );

    return SurfaceCard(
      padding: EdgeInsets.all(mobile ? 20 : 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          badge,
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.beta_step.tr(args: ['$number']), style: AppFonts.mono(size: 12, color: AppColors.accent)),
                const SizedBox(height: 6),
                Semantics(
                  header: true,
                  child: Text(title, style: AppFonts.display(size: mobile ? 20 : 24)),
                ),
                const SizedBox(height: 10),
                Text(body, style: AppFonts.body(size: 15, color: AppColors.textBody, height: 1.6)),
                const SizedBox(height: 18),
                AppLinkButton(label: button, uri: uri, newTab: true, expand: mobile),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
